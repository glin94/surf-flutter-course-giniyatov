import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/common/formatters/formatter.dart';
import 'package:places/ui/common/widgets/image.dart';
import 'package:places/ui/common/widgets/separator.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';

/// Экран отображения детальной информации об интересном месте
class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails({Key key, this.sight}) : super(key: key);

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
            SightDetailsWidget(
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
          child: _BackButton(),
        )
      ],
    );
  }
}

/// Кнопка назад
class _BackButton extends StatelessWidget {
  const _BackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}

class SightDetailsWidget extends StatelessWidget {
  const SightDetailsWidget({
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
          _SightDescription(sight: sight),
          const _RouteButton(),
          _buildPlanningAndFavouriteButtons(context),
        ],
      ),
    );
  }

  Widget _buildPlanningAndFavouriteButtons(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        const Separator(),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const _PlanningButton(),
            const _FavouriteButton(),
          ],
        ),
      ],
    );
  }
}

/// Кнопка добавления места в 'Избранное'
class _FavouriteButton extends StatelessWidget {
  const _FavouriteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: SvgPicture.asset(
        icHeart,
        color: Theme.of(context).iconTheme.color,
      ),
      onPressed: () => print("favorite"),
      label: Text(
        "В Избранное",
        style: textBody2.copyWith(),
      ),
    );
  }
}

/// Кнопка добавления места в 'Хочу посетить'
class _PlanningButton extends StatelessWidget {
  const _PlanningButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
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
    );
  }
}

/// Конпка построения маршрута
class _RouteButton extends StatelessWidget {
  const _RouteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        label: Text(
          goButtonText,
        ),
        icon: SvgPicture.asset(icGO),
        onPressed: () => print("GO!"),
      ),
    );
  }
}

/// Детальное описание места
class _SightDescription extends StatelessWidget {
  const _SightDescription({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
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
}
