import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/common/widgets/image.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';

/// Карточка интересного места на главном экране
class SightCard extends StatelessWidget {
  const SightCard({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Column(
        children: [
          SightCardTop(
            sight: sight,
          ),
          SightCardBottom(
            sight: sight,
          ),
        ],
      ),
    );
  }
}

/// Верхняя часть карточки интересного места на главном экране
class SightCardTop extends StatelessWidget {
  const SightCardTop({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          width: double.infinity,
          height: 95,
          foregroundDecoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
              ),
              backgroundBlendMode: BlendMode.multiply,
              color: Colors.transparent.withOpacity(.4),
              gradient: cardGradient),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(16.0),
                topRight: const Radius.circular(16.0)),
            child: ImageWidget(
              url: sight.url,
            ),
          )),
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
        child: SvgPicture.asset(
          icHeart,
          color: Colors.white,
        ),
      ),
    ]);
  }
}

/// Нижняя часть карточки интересного места на главном экране
class SightCardBottom extends StatelessWidget {
  const SightCardBottom({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 92,
      decoration: const BoxDecoration(
        color: colorBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: const Radius.circular(16),
          bottomRight: const Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(16),
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
          const SizedBox(
            height: 2,
          ),
          Text(
            openOrCloseText(sight),
            maxLines: 1,
            style: textSmall.copyWith(
              color: colorLightSecondary2,
            ),
          ),
        ],
      ),
    );
  }
}
