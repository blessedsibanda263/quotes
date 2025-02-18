import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';

abstract class QuoteListEvent extends Equatable {
  const QuoteListEvent();

  @override
  List<Object?> get props => [];
}

class QuoteListFilterByFavoritesToggled extends QuoteListEvent {
  const QuoteListFilterByFavoritesToggled();
}

class QuoteListTagChanged extends QuoteListEvent {
  final Tag? tag;

  const QuoteListTagChanged(this.tag);

  @override
  List<Object?> get props => [tag];
}

class QuoteListSearchTermChanged extends QuoteListEvent {
  final String searchTerm;

  const QuoteListSearchTermChanged(this.searchTerm);

  @override
  List<Object?> get props => [searchTerm];
}

class QuoteListRefreshed extends QuoteListEvent {
  const QuoteListRefreshed();
}

class QuoteListNextPageRequested extends QuoteListEvent {
  final int pageNumber;

  const QuoteListNextPageRequested({required this.pageNumber});
}

abstract class QuoteListItemFavoriteToggled extends QuoteListEvent {
  final int id;

  const QuoteListItemFavoriteToggled(this.id);
}

class QuoteListItemFavorited extends QuoteListItemFavoriteToggled {
  const QuoteListItemFavorited(super.id);
}

class QuoteListItemUnfavorited extends QuoteListItemFavoriteToggled {
  const QuoteListItemUnfavorited(super.id);
}

class QuoteListFailedFetchRetried extends QuoteListEvent {
  const QuoteListFailedFetchRetried();
}

class QuoteListUsernameObtained extends QuoteListEvent {
  const QuoteListUsernameObtained();
}

class QuoteListItemUpdated extends QuoteListEvent {
  final Quote updatedQuote;

  const QuoteListItemUpdated(this.updatedQuote);
}
