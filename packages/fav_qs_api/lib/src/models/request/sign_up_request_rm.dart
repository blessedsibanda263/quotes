import 'package:fav_qs_api/src/models/request/user_info_rm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_rm.g.dart';

@JsonSerializable(createFactory: false)
class SignUpRequestRM {
  const SignUpRequestRM({required this.user});

  @JsonKey(name: 'user')
  final UserInfoRM user;

  Map<String, dynamic> toJson() => _$SignUpRequestRMToJson(this);
}
