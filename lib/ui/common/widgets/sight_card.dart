import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/common/formatters/formatter.dart';
import 'package:places/ui/common/widgets/image.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_details.dart';

// Карточка интересного места на главном экране
class SightCard extends StatefulWidget {
  SightCard({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  _SightCardState createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 168,
        maxHeight: 218,
      ),
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Stack(
          children: [
            Column(
              children: [
                _SightCardTop(imgUrl: widget.sight.imgListUrl.first),
                _SightCardBottom(
                  sight: widget.sight,
                  visitingText: const SizedBox.shrink(),
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
                    builder: (c) => SightDetails(id: widget.sight.id),
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

/// Верхняя часть карточки интересного места
class _SightCardTop extends StatelessWidget {
  const _SightCardTop({
    Key key,
    @required this.imgUrl,
  }) : super(key: key);

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: const Radius.circular(16.0),
        topRight: const Radius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        width: MediaQuery.of(context).size.width,
        constraints: const BoxConstraints(
          maxHeight: 96,
          minHeight: 96,
        ),
        foregroundDecoration: _buildDecoration(),
        child: ImageWidget(
          url: imgUrl,
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
      gradient: cardGradient,
    );
  }
}

///Нижняя часть карточки интересного места
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
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(
        maxHeight: 122,
        minHeight: 72,
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
          const SizedBox(height: 2),
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

/// Карточка интересного места на экранах "Хочу посетить"/"Посетил"
class FavoriteSightCard extends StatelessWidget {
  const FavoriteSightCard({
    Key key,
    this.sight,
    this.onDelete,
  }) : super(key: key);

  final Sight sight;

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Dismissible(
        key: key,
        background: const _DeleteBackgroundSwipe(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => onDelete(),
        child: Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            type: MaterialType.transparency,
            child: Container(
              constraints: BoxConstraints(
                minHeight: 168,
                maxHeight: 218,
              ),
              width: MediaQuery.of(context).size.width,
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        _SightCardTop(imgUrl: sight.imgListUrl.first),
                        _SightCardBottom(
                          sight: sight,
                          visitingText: Container(
                            height: 30,
                            child: Text(
                              sight.plannedOrAchievedText,
                              style: textBody2.copyWith(
                                color: sight.isAchieved
                                    ? colorDarkSecondary2
                                    : colorLightGreen,
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
                        highlightColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                        splashColor:
                            Theme.of(context).accentColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (c) => SightDetails(id: sight.id),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Wrap(children: [
                        sight.isAchieved
                            ? IconButton(
                                onPressed: () => print("share"),
                                icon: SvgPicture.asset(
                                  icShare,
                                  color: Colors.white,
                                ),
                              )
                            : IconButton(
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
            ),
          ),
        ),
      ),
    );
  }
}

class _DeleteBackgroundSwipe extends StatelessWidget {
  const _DeleteBackgroundSwipe({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: colorError,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icBuckets,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  deleteSightText,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///Обертка для перетаскивания
class DraggableCard extends StatefulWidget {
  const DraggableCard({
    Key key,
    this.child,
    this.sight,
  }) : super(key: key);

  final Widget child;

  final Sight sight;

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> {
  @override
  Widget build(BuildContext context) {
    return Draggable<Sight>(
      data: widget.sight,
      childWhenDragging: SizedBox.shrink(),
      feedback: widget.child,
      child: widget.child,
    );
  }
}
