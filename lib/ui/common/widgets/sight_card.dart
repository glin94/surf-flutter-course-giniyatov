import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/common/formatters/formatter.dart';
import 'package:places/ui/common/widgets/image.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:provider/provider.dart';

// Карточка интересного места на главном экране
class SightCard extends StatefulWidget {
  SightCard({
    Key key,
    @required this.sight,
  }) : super(key: key);

  final Place sight;

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
                _SightCardTop(imgUrls: widget.sight.urls),
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
                placeTypeText(widget.sight.placeType).toLowerCase(),
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
                onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  builder: (context) => SightDetails(id: widget.sight.id),
                ),
              ),
            ),
            Positioned(
              right: 4,
              top: 4,
              child: Consumer<PlaceInteractor>(
                builder: (context, placeInteractor, child) =>
                    StreamBuilder<List<Place>>(
                  stream: placeInteractor.favoriteListStream,
                  initialData: placeInteractor.favoritesList,
                  builder: (context, snapshot) => !snapshot.data
                          .map((item) => item.id)
                          .contains(widget.sight.id)
                      ? IconButton(
                          onPressed: () =>
                              placeInteractor.addToFavoriteList(widget.sight),
                          icon: SvgPicture.asset(
                            icHeart,
                            color: Colors.white,
                          ),
                        )
                      : IconButton(
                          onPressed: () => placeInteractor
                              .removeFromFavoritesList(widget.sight),
                          icon: SvgPicture.asset(
                            icHeartFilled,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            )
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
    @required this.imgUrls,
  }) : super(key: key);

  final List<String> imgUrls;

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
        child: imgUrls.isNotEmpty
            ? ImageWidget(
                url: imgUrls.first,
              )
            : Container(),
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

  final Place sight;

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
class FavoriteSightCard extends StatefulWidget {
  const FavoriteSightCard({
    Key key,
    this.sight,
    this.onDelete,
  }) : super(key: key);

  final Place sight;

  final VoidCallback onDelete;

  @override
  _FavoriteSightCardState createState() => _FavoriteSightCardState();
}

class _FavoriteSightCardState extends State<FavoriteSightCard> {
  showDateTimePicker() async {
    if (Platform.isAndroid) {
      final result = await showDatePicker(
        context: context,
        locale: Locale('ru', 'RU'),
        firstDate: DateTime.now(),
        initialDate: widget.sight.visitingDate,
        lastDate: DateTime.now().add(
          Duration(days: 90),
        ),
        helpText: "ВЫБЕРИТЕ ДАТУ ПОСЕЩЕНИЯ",
      );
      if (result != null) {
        setState(() {
          widget.sight.visitingDate = result;
        });
      }
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height / 3,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            minimumDate: DateTime.now(),
            maximumDate: DateTime.now().add(
              Duration(days: 90),
            ),
            backgroundColor: Theme.of(context).cardColor,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (time) => setState(() {
              widget.sight.visitingDate = time;
            }),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Dismissible(
        key: widget.key,
        background: const _DeleteBackgroundSwipe(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => widget.onDelete(),
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
                        _SightCardTop(imgUrls: widget.sight.urls),
                        _SightCardBottom(
                          sight: widget.sight,
                          visitingText: Container(
                            height: 30,
                            child: Text(
                              widget.sight.plannedOrAchievedText,
                              style: textBody2.copyWith(
                                color: widget.sight.isAchieved
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
                        widget.sight.type.toLowerCase(),
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
                        onTap: () => showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          builder: (context) =>
                              SightDetails(id: widget.sight.id),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Wrap(children: [
                        widget.sight.isAchieved
                            ? IconButton(
                                onPressed: () => print("share"),
                                icon: SvgPicture.asset(
                                  icShare,
                                  color: Colors.white,
                                ),
                              )
                            : IconButton(
                                onPressed: showDateTimePicker,
                                icon: SvgPicture.asset(
                                  icCalendar,
                                  color: Colors.white,
                                ),
                              ),
                        IconButton(
                          onPressed: widget.onDelete,
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

  final Place sight;

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> {
  @override
  Widget build(BuildContext context) {
    return Draggable<Place>(
      data: widget.sight,
      childWhenDragging: SizedBox.shrink(),
      feedback: widget.child,
      child: widget.child,
    );
  }
}
