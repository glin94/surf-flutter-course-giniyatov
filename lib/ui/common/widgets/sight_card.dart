import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/common/formatters/formatter.dart';
import 'package:places/ui/common/widgets/image.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';

/// Карточка интересного места на главном экране
class SightCard extends StatelessWidget {
  SightCard({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  List<Widget> icons = [
    IconButton(
      iconSize: 24,
      onPressed: () => print("favorite"),
      icon: SvgPicture.asset(
        icHeart,
        color: Colors.white,
      ),
    )
  ];

  Widget visitingTextContainer = Container();

  ///  Карточка планируемых для посещения мест
  SightCard.wantToVisit({@required this.sight}) {
    icons = [
      IconButton(
        onPressed: () => print("calendar"),
        icon: SvgPicture.asset(
          icCalendar,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: () => print("close"),
        icon: SvgPicture.asset(
          icClose,
          color: Colors.white,
        ),
      ),
    ];
    visitingTextContainer = Container(
        height: 30,
        child: Text(
          sight.plannedOrAchievedText,
          style: textBody2.copyWith(
            color: colorLightGreen,
          ),
        ));
  }

  ///  Карточка для экрана посещенных мест (наследуется от SightCard)
  SightCard.visited({@required this.sight}) {
    icons = [
      IconButton(
        onPressed: () => print("share"),
        icon: SvgPicture.asset(
          icShare,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: () => print("close"),
        icon: SvgPicture.asset(
          icClose,
          color: Colors.white,
        ),
      ),
    ];
    visitingTextContainer = Container(
        height: 30,
        child: Text(
          sight.plannedOrAchievedText,
          style: textBody2.copyWith(
            color: colorDarkSecondary2,
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
        child: Stack(
          children: [
            Column(
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
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                sight.type,
                style: textBody1.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
                splashColor: Theme.of(context).accentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Wrap(
                children: icons,
              ),
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
    return Container(
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
      ),
    );
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
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
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
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: 2,
          ),
          visitingText,
          Text(
            openOrCloseText(sight),
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: colorDarkSecondary2,
                ),
          ),
        ],
      ),
    );
  }
}
