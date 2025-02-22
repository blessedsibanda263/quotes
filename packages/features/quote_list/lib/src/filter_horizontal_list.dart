import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_list/src/quote_list_bloc.dart';
import 'package:quote_list/src/quote_list_event.dart';
import 'package:quote_list/src/quote_list_state.dart';

const _itemSpacing = Spacing.xSmall;

class FilterHorizontalList extends StatelessWidget {
  const FilterHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: Spacing.mediumLarge),
      child: Row(
        children: [
          const _FavoritesChip(),
          ...Tag.values.map((tag) => _TagChip(tag: tag)).toList(),
        ],
      ),
    );
  }
}

class _FavoritesChip extends StatelessWidget {
  const _FavoritesChip({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Padding(
      padding: EdgeInsets.only(right: _itemSpacing, left: theme.screenMarging),
      child: BlocSelector<QuoteListBloc, QuoteListState, bool>(
        selector: (state) {
          final isFilteringByFavorites =
              state.filter is QuoteListFilterByFavorites;
          return isFilteringByFavorites;
        },
        builder: (context, isFavoritesOnly) {
          return RoundedChoiceChip(
            label: "Favorites",
            isSelected: isFavoritesOnly,
            avatar: Icon(
              isFavoritesOnly ? Icons.favorite : Icons.favorite_border_outlined,
              color:
                  isFavoritesOnly
                      ? theme.roundedChoiceChipSelectedAvatarColor
                      : theme.roundedChoiceChipAvatarColor,
            ),
            onSelected: (isSelected) {
              _releaseFocus(context);
              final bloc = context.read<QuoteListBloc>();
              bloc.add(const QuoteListFilterByFavoritesToggled());
            },
          );
        },
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({super.key, required this.tag});

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final isLastTag = Tag.values.last == tag;
    return Padding(
      padding: EdgeInsets.only(
        right: isLastTag ? theme.screenMarging : _itemSpacing,
        left: _itemSpacing,
      ),
      child: BlocSelector<QuoteListBloc, QuoteListState, Tag?>(
        selector: (state) {
          final filter = state.filter;
          final selectedTag =
              filter is QuoteListFilterByTag ? filter.tag : null;
          return selectedTag;
        },
        builder: (context, selectedTag) {
          final isSelected = selectedTag == tag;
          return RoundedChoiceChip(
            label: tag.toLocalizedString(context),
            isSelected: isSelected,
            onSelected: (isSelected) {
              _releaseFocus(context);
              final bloc = context.read<QuoteListBloc>();
              bloc.add(QuoteListTagChanged(isSelected ? tag : null));
            },
          );
        },
      ),
    );
  }
}

void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();

extension on Tag {
  String toLocalizedString(BuildContext context) {
    switch (this) {
      case Tag.life:
        return "Life";
      case Tag.happiness:
        return "Happiness";
      case Tag.work:
        return "Work";
      case Tag.nature:
        return "Nature";
      case Tag.science:
        return "Science";
      case Tag.love:
        return "Love";
      case Tag.funny:
        return "Funny";
    }
  }
}
