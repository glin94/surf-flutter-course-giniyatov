import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/interactor/filter/sight_interactor.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

///Форма для текста
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
          onChanged: (s) => sightInteractor.validate(),
          maxLines: maxLines,
          cursorHeight: 24,
          cursorColor: Theme.of(context).accentColor,
          keyboardType: textInputType,
          decoration: InputDecoration(
            hintStyle: textSubtitle1.copyWith(
              color: colorInnactiveBlack,
            ),
            hintText: hintText,
            suffix: _ClearButton(textController: textController),
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colorDarkRed,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colorDarkRed,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colorLightGreen,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colorLightGreen,
                width: 1.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({
    Key key,
    @required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        textController.clear();
        sightInteractor.validate();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.clear,
          size: 20,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

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
