import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/common/widgets/text_clear_button.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';

/// Поисковая строка
class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    this.enable,
    this.textEditingController,
    this.onChanged,
    this.onFilterTap,
  }) : super(key: key);

  final TextEditingController textEditingController;

  final bool enable;

  final Function onChanged;

  final Function onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: textEditingController,
          enabled: enable,
          keyboardType: TextInputType.text,
          cursorHeight: 24,
          autofocus: true,
          cursorColor: Theme.of(context).accentColor,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(16),
            hintText: searchBarHintText,
            alignLabelWithHint: false,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 14),
              child: SvgPicture.asset(
                icSearch,
              ),
            ),
            suffix: TextClearButton(textController: textEditingController),
            filled: true,
            hintStyle: textSubtitle1.copyWith(
              color: colorInnactiveBlack,
            ),
            focusedBorder: _searchBarBorder(),
            fillColor: Theme.of(context).cardColor,
            border: _searchBarBorder(),
            disabledBorder: _searchBarBorder(),
            enabledBorder: _searchBarBorder(),
          ),
          textCapitalization: TextCapitalization.sentences,
        ),
        enable
            ? Container()
            : Positioned(
                bottom: 8,
                right: 16,
                top: 8,
                child: _FilterButton(onTap: onFilterTap),
              ),
      ],
    );
  }

  OutlineInputBorder _searchBarBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      );
}

/// Кнопка фильтра
class _FilterButton extends StatelessWidget {
  const _FilterButton({
    Key key,
    this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        icFilter,
      ),
    );
  }
}
