import 'package:flutter/material.dart';
import 'package:places/colors.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/text_styles.dart';

class SightDetails extends StatelessWidget {
  final Sight sight = mocks[1];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 360,
                color: Colors.deepPurple,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(sight.name,
                            style:
                                textTitle.copyWith(color: colorLightSecondary)),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Text(sight.type,
                                style: textSmallBold.copyWith(
                                    color: colorLightSecondary)),
                            SizedBox(width: 16),
                            Text(
                              "закрыто до 09:00",
                              style: textSmall.copyWith(
                                  color: colorLightSecondary2),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          sight.details,
                          maxLines: 4,
                          style: textSmall.copyWith(color: colorLightSecondary),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          child: Center(
                            child: Text(
                              "ПОСТРОИТЬ МАРШРУТ",
                              style: textButton.copyWith(color: Colors.white),
                            ),
                          ),
                          height: 48,
                          decoration: BoxDecoration(
                              color: colorLightGreen,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        const SizedBox(height: 24),
                        Container(height: 1, color: colorInnactiveBlack),
                        const SizedBox(height: 8),
                        Container(
                          height: 40,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Center(
                                        child: Text("Запланировать",
                                            style: textSmall.copyWith(
                                                color: colorInnactiveBlack))),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Center(
                                      child: Text(
                                    "В Избранное",
                                    style: textSmall.copyWith(
                                        color: colorLightSecondary),
                                  )),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              top: 36,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: 32,
                width: 32,
              ))
        ],
      ),
    );
  }
}
