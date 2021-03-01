import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/common/formatters/formatter.dart';
import 'package:places/ui/common/widgets/image.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_details.dart';

// Карточка интересного места на главном экране
class SightCard extends StatefulWidget {
  final Sight sight;

  SightCard({
    ValueKey key,
    @required this.sight,
  }) : super(key: key);

  @override
  _SightCardState createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 218,
        maxHeight: 218,
      ),
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Stack(
          children: [
            Column(
              children: [
                _SightCardTop(
                  url: widget.sight.url,
                ),
                _SightCardBottom(
                  sight: widget.sight,
                  visitingText: Container(),
                ),
              ],
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                widget.sight.type.toLowerCase(),
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
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (c) => SightDetails(sight: widget.sight),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 4,
              top: 4,
              child: IconButton(
                onPressed: () => print("favorite"),
                icon: SvgPicture.asset(
                  icHeart,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Верхняя часть карточки интересного места на главном экране
class _SightCardTop extends StatelessWidget {
  const _SightCardTop({
    Key key,
    @required this.url,
  }) : super(key: key);

  final String url;

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
          url: url,
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

///Нижняя часть карточки интересного места на главном экране
class _SightCardBottom extends StatelessWidget {
  const _SightCardBottom({
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
        color: Theme.of(context).cardColor,
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
            openOrCloseText(sight.isOpen, sight.openingTime),
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

/// Карточка интересного места на экране "Хочу посетить"
class SightCardWanted extends StatelessWidget {
  final Sight sight;
  final Function onDelete;
  const SightCardWanted({
    Key key,
    this.sight,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 218,
        maxHeight: 218,
      ),
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Stack(
          children: [
            Column(
              children: [
                _SightCardTop(url: sight.url),
                _SightCardBottom(
                  sight: sight,
                  visitingText: Container(
                    height: 30,
                    child: Text(
                      sight.plannedOrAchievedText,
                      style: textBody2.copyWith(
                        color: colorLightGreen,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                sight.type.toLowerCase(),
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
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (c) => SightDetails(sight: sight),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Wrap(children: [
                IconButton(
                  onPressed: () => print("share"),
                  icon: SvgPicture.asset(
                    icCalendar,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: SvgPicture.asset(
                    icClose,
                    color: Colors.white,
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

/// Карточка интересного места на экране "Посетил"
class SightCardVisited extends StatelessWidget {
  final Sight sight;
  final Function onDelete;
  const SightCardVisited({Key key, this.sight, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 218,
        maxHeight: 218,
      ),
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Stack(
          children: [
            Column(
              children: [
                _SightCardTop(url: sight.url),
                _SightCardBottom(
                  sight: sight,
                  visitingText: Container(
                    height: 30,
                    child: Text(
                      sight.plannedOrAchievedText,
                      style: textBody2.copyWith(
                        color: colorDarkSecondary2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                sight.type.toLowerCase(),
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
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (c) => SightDetails(sight: sight),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Wrap(children: [
                IconButton(
                  onPressed: () => print("share"),
                  icon: SvgPicture.asset(
                    icShare,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: SvgPicture.asset(
                    icClose,
                    color: Colors.white,
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
