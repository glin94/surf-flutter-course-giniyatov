import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/common/widgets/text_form_field.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/filters_screen.dart';

///Поисковая строка
class SearchBar extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool enable;
  final Function onChanged;
  const SearchBar({
    Key key,
    this.enable,
    this.textEditingController,
    this.onChanged,
  }) : super(key: key);
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
            suffix: ClearButton(textController: textEditingController),
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
            : const Positioned(
                bottom: 8,
                right: 16,
                top: 8,
                child: const FilterButton(),
              ),
      ],
    );
  }

  OutlineInputBorder _searchBarBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }
}

///Кнопка фильтра
class FilterButton extends StatelessWidget {
  const FilterButton({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (c) => FiltersScreen(),
        ),
      ),
      child: SvgPicture.asset(
        icFilter,
      ),
    );
  }
}
