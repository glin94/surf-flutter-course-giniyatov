import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/formatters/formatter.dart';
import 'package:places/ui/common/widgets/image.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';

/// Экран отображения детальной информации об интересном месте
class SightDetails extends StatelessWidget {
  final Sight sight = mocks[1];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            GalleryWidget(
              sight: sight,
            ),
            const SizedBox(
              height: 15,
            ),
            DetailsWidget(
              sight: sight,
            ),
          ],
        ),
      ),
    );
  }
}

///  Галлерея для детального отображения интересного места
class GalleryWidget extends StatelessWidget {
  const GalleryWidget({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 360,
          width: double.infinity,
          foregroundDecoration: BoxDecoration(
              backgroundBlendMode: BlendMode.multiply,
              color: Colors.transparent.withOpacity(.4),
              gradient: cardGradient),
          child: ImageWidget(
            url: sight.url,
          ),
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
            child: IconButton(
              icon: SvgPicture.asset(
                icArrow,
              ),
              onPressed: () => print("back"),
            ),
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
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDetails(context),
          _buildRouteButton(),
          _buildPlanningAndFavouriteButtons(context),
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sight.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        Row(
          children: [
            Text(
              sight.type,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: colorDarkSecondary2,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                openOrCloseText(sight),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: colorInnactiveBlack,
                    ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
          ),
          child: Text(
            sight.details,
            style: textBody2,
          ),
        ),
      ],
    );
  }

  Widget _buildRouteButton() {
    return Container(
        width: double.infinity,
        height: 48,
        child: ElevatedButton.icon(
          label: Text(
            goButtonText,
          ),
          icon: SvgPicture.asset(icGO),
          onPressed: () => print("GO!"),
        ));
  }

  Widget _buildPlanningAndFavouriteButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
      ),
      child: Column(
        children: [
          Container(
            height: 1,
            color: colorInnactiveBlack,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  icon: SvgPicture.asset(
                    icCalendar,
                    color: colorInnactiveBlack,
                  ),
                  onPressed: () => print("plan"),
                  label: Text(
                    plannedButtonText,
                    style: textBody2.copyWith(
                      color: colorInnactiveBlack,
                    ),
                  ),
                ),
                TextButton.icon(
                  icon: SvgPicture.asset(
                    icHeart,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () => print("favorite"),
                  label: Text(
                    "В Избранное",
                    style: textBody2.copyWith(),
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
