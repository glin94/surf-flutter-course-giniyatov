import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/common/formatters/formatter.dart';
import 'package:places/ui/common/widgets/image.dart';
import 'package:places/ui/common/widgets/separator.dart';
import 'package:places/ui/common/widgets/waiting_indicator.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';

/// Экран отображения детальной информации об интересном месте
class SightDetails extends StatelessWidget {
  const SightDetails({
    Key key,
    this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 700),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: FutureBuilder<Place>(
            future: placeInteractor.getPlaceDetails(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final sight = snapshot.data;
                return Stack(children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        elevation: 0,
                        primary: true,
                        stretch: true,
                        automaticallyImplyLeading: false,
                        expandedHeight: 300,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          stretchModes: <StretchMode>[
                            StretchMode.blurBackground,
                            StretchMode.zoomBackground,
                          ],
                          background: GalleryWidget(imagesUrlList: sight.urls),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              _SightDescription(sight: sight),
                              const SizedBox(height: 24),
                              const _RouteButton(),
                              const SizedBox(height: 24),
                              const Separator(),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const _PlanningButton(),
                                  _FavouriteButton(place: sight),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Positioned(
                    top: 12,
                    right: 160,
                    left: 160,
                    child: const _Rectangle(),
                  ),
                  const Positioned(
                    top: 16,
                    right: 16,
                    child: const _CircleCloseButton(),
                  ),
                ]);
              } else
                return WaitingIndicator();
            }),
      ),
    );
  }
}

class _Rectangle extends StatelessWidget {
  const _Rectangle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class _CircleCloseButton extends StatelessWidget {
  const _CircleCloseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: Center(
        child: CloseButton(
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}

///  Галлерея картинок для детального отображения интересного места
class GalleryWidget extends StatelessWidget {
  const GalleryWidget({
    Key key,
    @required this.imagesUrlList,
  }) : super(key: key);

  final List<dynamic> imagesUrlList;

  @override
  Widget build(BuildContext context) {
    return _CustomScrollBar(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagesUrlList.length,
        itemBuilder: (context, index) => Container(
          width: double.infinity,
          foregroundDecoration: BoxDecoration(
              backgroundBlendMode: BlendMode.multiply,
              color: Colors.transparent.withOpacity(.4),
              gradient: cardGradient),
          child: ImageWidget(url: imagesUrlList[index]),
        ),
      ),
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
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          icArrow,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          icClose,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}

/// Кнопка добавления места в 'Избранное'
class _FavouriteButton extends StatelessWidget {
  const _FavouriteButton({
    Key key,
    this.place,
  }) : super(key: key);

  final Place place;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Place>>(
      initialData: placeInteractor.favoritesList,
      stream: placeInteractor.favoriteListStream,
      builder: (context, snapshot) =>
          snapshot.data.map((item) => item.id).contains(place.id)
              ? TextButton.icon(
                  icon: SvgPicture.asset(
                    icHeartFilled,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () => placeInteractor.removeFromFavorites(place),
                  label: Text(
                    removeFromFavoriteText,
                    style: textBody2.copyWith(),
                  ),
                )
              : TextButton.icon(
                  icon: SvgPicture.asset(
                    icHeart,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () => placeInteractor.addToFavorites(place),
                  label: Text(
                    addToFavoriteText,
                    style: textBody2.copyWith(),
                  ),
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

/// Кнопка построения маршрута
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
        label: Text(goButtonText),
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

  final Place sight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sight.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          children: [
            Text(
              placeTypeText(sight.placeType).toLowerCase(),
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: colorDarkSecondary2,
                  ),
            ),
            const SizedBox(width: 16),
            Text(
              openOrCloseText(sight.isOpen, sight.openingTime),
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: colorInnactiveBlack,
                  ),
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          sight.description,
          // maxLines: 4,
          style: textBody2,
        ),
      ],
    );
  }
}

/// Кастомный скроллбар
class _CustomScrollBar extends StatelessWidget {
  const _CustomScrollBar({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        highlightColor: Theme.of(context).accentColor,
        platform: TargetPlatform.android,
      ),
      child: Scrollbar(
        radius: Radius.circular(8),
        thickness: 7,
        child: child,
      ),
    );
  }
}
