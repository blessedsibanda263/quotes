import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';

class QuoteListState extends Equatable {
  final List<Quote>? itemList;
  final int? nextPage;
  final dynamic error;
  final QuoteListFilter? filter;
  final dynamic refreshError;
  final dynamic favoriteToggleError;

  const QuoteListState({
    this.itemList,
    this.nextPage,
    this.error,
    this.filter,
    this.refreshError,
    this.favoriteToggleError,
  });

  QuoteListState.loadingNewTag({required Tag? tag})
    : this(filter: tag != null ? QuoteListFilterByTag(tag) : null);

  QuoteListState.loadingNewSearchTerm({required String searchTerm})
    : this(
        filter:
            searchTerm.isEmpty ? null : QuoteListFilterBySearchTerm(searchTerm),
      );

  const QuoteListState.loadingToggledFavoritesFilter({
    required bool isFilteringByFavorites,
  }) : this(
         filter:
             isFilteringByFavorites ? const QuoteListFilterByFavorites() : null,
       );

  const QuoteListState.noItemsFound({required QuoteListFilter? filter})
    : this(itemList: const [], error: null, nextPage: 1, filter: filter);

  const QuoteListState.success({
    required int? nextPage,
    required List<Quote> itemList,
    required QuoteListFilter? filter,
    required bool isRefresh,
  }) : this(nextPage: nextPage, itemList: itemList, filter: filter);

  QuoteListState copyWithNewError(dynamic error) => QuoteListState(
    itemList: itemList,
    nextPage: nextPage,
    error: error,
    filter: filter,
    refreshError: null,
  );

  QuoteListState copyWithNewRefreshError(dynamic refreshError) =>
      QuoteListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: refreshError,
        favoriteToggleError: null,
      );

  QuoteListState copyWithUpdatedQuote(Quote updatedQuote) {
    return QuoteListState(
      itemList:
          itemList?.map((quote) {
            if (quote.id == updatedQuote.id) {
              return updatedQuote;
            } else {
              return quote;
            }
          }).toList(),
      nextPage: nextPage,
      error: error,
      filter: filter,
      refreshError: null,
      favoriteToggleError: null,
    );
  }

  QuoteListState copyWithFavoriteToggleError(dynamic favoriteToggleError) =>
      QuoteListState(
        itemList: itemList,
        nextPage: nextPage,
        error: error,
        filter: filter,
        refreshError: refreshError,
        favoriteToggleError: favoriteToggleError,
      );

  @override
  List<Object?> get props => [
    itemList,
    nextPage,
    error,
    filter,
    refreshError,
    favoriteToggleError,
  ];
}

abstract class QuoteListFilter extends Equatable {
  const QuoteListFilter();

  @override
  List<Object?> get props => [];
}

class QuoteListFilterByTag extends QuoteListFilter {
  final Tag tag;

  const QuoteListFilterByTag(this.tag);

  @override
  List<Object?> get props => [tag];
}

class QuoteListFilterBySearchTerm extends QuoteListFilter {
  final String searchTerm;

  const QuoteListFilterBySearchTerm(this.searchTerm);

  @override
  List<Object?> get props => [searchTerm];
}

class QuoteListFilterByFavorites extends QuoteListFilter {
  const QuoteListFilterByFavorites();
}
