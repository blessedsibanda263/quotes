// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_list_page_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteListPageRM _$QuoteListPageRMFromJson(Map<String, dynamic> json) =>
    QuoteListPageRM(
      isLastPage: json['last_page'] as bool,
      quoteList:
          (json['quotes'] as List<dynamic>)
              .map((e) => QuoteRM.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
