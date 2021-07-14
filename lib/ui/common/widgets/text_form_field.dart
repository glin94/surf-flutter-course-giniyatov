import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/interactor/new_place_interactor.dart';
import 'package:places/ui/common/widgets/text_clear_button.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:provider/provider.dart';

/// Поле ввода
class TextFormFieldWidget extends StatelessWidget {
  final int maxLines;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController textController;
  final String label;
  final String hintText;

  const TextFormFieldWidget({
    Key key,
    this.maxLines,
    this.textInputType,
    this.textInputAction,
    this.textController,
    this.label = "",
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CaptionText(title: label),
        const SizedBox(height: 12),
        TextFormField(
          controller: textController,
          inputFormatters: textInputType == TextInputType.number
              ? [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[$.\d]"),
                  )
                ]
              : null,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: textInputAction,
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
          onChanged: (s) => context.read<NewPlaceInteractor>().validate(),
          maxLines: maxLines,
          cursorHeight: 24,
          cursorColor: Theme.of(context).accentColor,
          keyboardType: textInputType,
          decoration: InputDecoration(
            hintStyle: textSubtitle1.copyWith(
              color: colorInnactiveBlack,
            ),
            hintText: hintText,
            suffix: TextClearButton(textController: textController),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            errorBorder: _border(colorDarkRed, 2.0),
            focusedErrorBorder: _border(colorDarkRed, 2.0),
            focusedBorder: _border(colorLightGreen, 2.0),
            enabledBorder: _border(colorLightGreen, 1.0),
          ),
        )
      ],
    );
  }

  OutlineInputBorder _border(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}

/// Заголовок формы
class CaptionText extends StatelessWidget {
  final String title;
  const CaptionText({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
