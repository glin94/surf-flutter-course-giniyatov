import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

class EmptyPlacesScreen extends StatelessWidget {
  final String iconsAssetText;
  final String header;
  final String text;

  const EmptyPlacesScreen({
    Key key,
    this.iconsAssetText,
    this.header,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconsAssetText,
            height: 64,
            color: colorInnactiveBlack,
          ),
          const SizedBox(height: 32),
          Text(
            header,
            style: textHeadLine6.copyWith(color: colorInnactiveBlack),
          ),
          SizedBox(height: 8),
          Container(
            width: 253.5,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: textBody2.copyWith(color: colorInnactiveBlack),
            ),
          ),
        ],
      ),
    );
  }
}
