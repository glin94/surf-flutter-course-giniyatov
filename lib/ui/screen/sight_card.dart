import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

import '../res/colors.dart';
import '../res/text_styles.dart';

class SightCard extends StatelessWidget {
  final Sight sight;
  const SightCard({Key key, @required this.sight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      height: 188,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 96,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    color: Colors.deepPurple),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(16),
                    color: colorBackground,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          sight.name,
                          maxLines: 2,
                          style:
                              textRegular.copyWith(color: colorLightSecondary),
                        ),
                        SizedBox(height: 2),
                        Text(
                          sight.details,
                          maxLines: 1,
                          style:
                              textSmall.copyWith(color: colorLightSecondary2),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Text(
              sight.type,
              style: textSmallBold.copyWith(color: Colors.white),
            ),
          ),
          Positioned(
            top: 18,
            right: 19,
            child: Container(
              color: Colors.white,
              height: 18,
              width: 20,
            ),
          )
        ],
      ),
    );
  }
}
