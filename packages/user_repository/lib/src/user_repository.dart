import 'package:domain_models/domain_models.dart';
import 'package:fav_qs_api/fav_qs_api.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/src/mappers/cache_to_domain.dart';
import 'package:user_repository/src/mappers/domain_to_cache.dart';
import 'package:user_repository/src/mappers/remote_to_domain.dart';
import 'package:user_repository/src/user_local_storage.dart';
import 'package:user_repository/src/user_secure_storage.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final FavQsApi remoteApi;
  final UserLocalStorage _localStorage;
  final UserSecureStorage _secureStorage;
  final BehaviorSubject<User?> _userSubject = BehaviorSubject();
  final BehaviorSubject<DarkModePreference> _darkModePreferenceSubject =
      BehaviorSubject();

  UserRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
    @visibleForTesting UserLocalStorage? localStorage,
    @visibleForTesting UserSecureStorage? secureStorage,
  }) : _localStorage =
           localStorage ?? UserLocalStorage(noSqlStorage: noSqlStorage),
       _secureStorage = secureStorage ?? const UserSecureStorage();

  Future<void> upsertDarkModePreference(DarkModePreference preference) async {
    await _localStorage.upsertDarkModePreference(preference.toCacheModel());
    _darkModePreferenceSubject.add(preference);
  }

  Stream<DarkModePreference> getDarkModePreference() async* {
    if (!_darkModePreferenceSubject.hasValue) {
      final storedPreference = await _localStorage.getDarkModePreference();
      _darkModePreferenceSubject.add(
        storedPreference?.toDomainModel() ??
            DarkModePreference.useSystemSettings,
      );
    }
    yield* _darkModePreferenceSubject;
  }

  Future<void> signIn(String email, String password) async {
    try {
      final apiUser = await remoteApi.sigIn(email, password);
      await _secureStorage.upsertUserInfo(
        username: apiUser.username,
        email: apiUser.email,
        token: apiUser.token,
      );
      final domainUser = apiUser.toDomainModel();
      _userSubject.add(domainUser);
    } on InvalidCredentialsFavQsException catch (_) {
      throw InvalidCredentialsException();
    }
  }

  Stream<User?> getUser() async* {
    if (!_userSubject.hasValue) {
      final userInfo = await Future.wait([
        _secureStorage.getUserEmail(),
        _secureStorage.getUserEmail(),
      ]);
      final email = userInfo[0];
      final username = userInfo[1];

      if (email != null && username != null) {
        _userSubject.add(User(username: username, email: email));
      } else {
        _userSubject.add(null);
      }
    }
    yield* _userSubject.stream;
  }

  Future<String?> getUserToken() {
    return _secureStorage.getUserToken();
  }

  Future<void> signUp(String username, String email, String password) async {
    try {
      final userToken = await remoteApi.signUp(username, email, password);
      await _secureStorage.upsertUserInfo(
        username: username,
        email: email,
        token: userToken,
      );
      _userSubject.add(User(username: username, email: email));
    } catch (error) {
      if (error is UsernameAlreadyTakenFavQsException) {
        throw UsernameAlreadyTakeException();
      } else if (error is EmailAlreadyRegisteredFavQsException) {
        throw EmailAlreadyRegisteredException();
      }
      rethrow;
    }
  }

  Future<void> updateProfile(
    String username,
    String email,
    String? newPassword,
  ) async {
    try {
      await remoteApi.updateProfile(username, email, newPassword);
      await _secureStorage.upsertUserInfo(username: username, email: email);
      _userSubject.add(User(username: username, email: email));
    } on UsernameAlreadyTakenFavQsException catch (_) {
      throw UsernameAlreadyTakeException();
    }
  }

  Future<void> signOut() async {
    await remoteApi.signOut();
    await _secureStorage.deleteUserInfo();
    _userSubject.add(null);
  }

  Future<void> requestPasswordResetEmail(String email) async {
    await remoteApi.requestPasswordResetEmail(email);
  }
}
