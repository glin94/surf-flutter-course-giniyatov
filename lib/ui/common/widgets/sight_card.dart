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
  SightCard({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  List<Widget> icons = [
    SvgPicture.asset(
      icHeart,
      color: Colors.white,
    )
  ];

  Widget visitingTextContainer = Container();

  ///  Карточка планируемых для посещения мест
  SightCard.wantToVisit({@required this.sight}) {
    icons = [
      SvgPicture.asset(
        icCalendar,
        color: Colors.white,
      ),
      SvgPicture.asset(
        icClose,
        color: Colors.white,
      )
    ];
    visitingTextContainer = Container(
        height: 30,
        child: Text(
          sight.plannedOrAchievedText,
          style: textSmall.copyWith(
            color: colorLightGreen,
          ),
        ));
  }

  ///  Карточка для экрана посещенных мест (наследуется от SightCard)
  SightCard.visited({@required this.sight}) {
    icons = [
      SvgPicture.asset(
        icShare,
        color: Colors.white,
      ),
      SvgPicture.asset(
        icClose,
        color: Colors.white,
      ),
    ];
    visitingTextContainer = Container(
        height: 30,
        child: Text(
          sight.plannedOrAchievedText,
          style: textSmall.copyWith(
            color: colorLightSecondary2,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 188,
        maxHeight: 218,
      ),
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Column(
          children: [
            SightCardTop(
              sight: sight,
              icons: icons,
            ),
            SightCardBottom(
              sight: sight,
              visitingText: visitingTextContainer,
            ),
          ],
        ),
      ),
    );
  }
}

/// Верхняя часть карточки интересного места на главном экране
class SightCardTop extends StatelessWidget {
  const SightCardTop({
    Key key,
    @required this.sight,
    this.icons,
  }) : super(key: key);

  final Sight sight;
  final List<Widget> icons;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: 96,
            minHeight: 96,
          ),
          foregroundDecoration: _buildDecoration(),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(16.0),
              topRight: const Radius.circular(16.0),
            ),
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
        child: Wrap(
          spacing: 17,
          children: icons,
        ),
      ),
    ]);
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
        ),
        backgroundBlendMode: BlendMode.multiply,
        color: Colors.transparent.withOpacity(.4),
        gradient: cardGradient);
  }
}

/// Нижняя часть карточки интересного места на главном экране
class SightCardBottom extends StatelessWidget {
  const SightCardBottom({
    Key key,
    @required this.sight,
    this.visitingText,
  }) : super(key: key);

  final Sight sight;
  final Widget visitingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: 122,
        minHeight: 92,
      ),
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
          visitingText ?? Container(),
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
