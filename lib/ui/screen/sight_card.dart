import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

class SightCard extends StatelessWidget {
  final Sight sight;
  const SightCard({Key key, @required this.sight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Column(
        children: [
          Stack(children: [
            Container(
              height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Colors.deepPurple,
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                sight.type,
                style: textSmallBold.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 18,
              right: 19,
              child: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
            ),
          ]),
          Container(
            height: 92,
            decoration: BoxDecoration(
              color: colorBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sight.name,
                  maxLines: 2,
                  style: textRegular.copyWith(
                    color: colorLightSecondary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  sight.details,
                  maxLines: 1,
                  style: textSmall.copyWith(
                    color: colorLightSecondary2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
