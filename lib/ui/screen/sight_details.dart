import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

class SightDetails extends StatelessWidget {
  final Sight sight = mocks[1];

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: [
        GalleryWidget(),
        DetailsWidget(sight: sight),
      ],
    ));
  }
}

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 360,
          color: Colors.deepPurple,
        ),
        Positioned(
          top: 36,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 32,
            width: 32,
          ),
        )
      ],
    );
  }
}

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDetails(),
          _buildRouteButton(),
          _buildPlanningAndFavouriteButtons()
        ],
      ),
    );
  }

  Widget _buildPlanningAndFavouriteButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Container(
            height: 1,
            color: colorInnactiveBlack,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Запланировать",
                    style: textSmall.copyWith(
                      color: colorInnactiveBlack,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "В Избранное",
                    style: textSmall.copyWith(
                      color: colorLightSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteButton() {
    return MaterialButton(
      elevation: 0,
      minWidth: double.infinity,
      color: colorLightGreen,
      child: Text(
        "ПОСТРОИТЬ МАРШРУТ",
        style: textButton.copyWith(
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onPressed: () {},
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sight.name,
          style: textTitle.copyWith(
            color: colorLightSecondary,
          ),
        ),
        Row(
          children: [
            Text(
              sight.type,
              style: textSmallBold.copyWith(
                color: colorLightSecondary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                sight.isOpen
                    ? "открыто"
                    : "закрыто до ${sight.openingTime.hour.toString().padLeft(2, '0')}:00",
                style: textSmall.copyWith(
                  color: colorLightSecondary2,
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            sight.details,
            maxLines: 4,
            style: textSmall.copyWith(
              color: colorLightSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
