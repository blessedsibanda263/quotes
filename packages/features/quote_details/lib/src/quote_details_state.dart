part of 'quote_details_cubit.dart';

abstract class QuoteDetailsState extends Equatable {
  const QuoteDetailsState();
}

class QuoteDetailsInProgress extends QuoteDetailsState {
  const QuoteDetailsInProgress();

  @override
  List<Object?> get props => [];
}

class QuoteDetailsSuccess extends QuoteDetailsState {
  final Quote quote;
  final dynamic quoteUpdateError;

  const QuoteDetailsSuccess({required this.quote, this.quoteUpdateError});

  @override
  List<Object?> get props => [];
}

class QuoteDetailsFailure extends QuoteDetailsState {
  const QuoteDetailsFailure();

  @override
  List<Object?> get props => [];
}
