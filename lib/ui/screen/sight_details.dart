import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/formatters/formatter.dart';
import 'package:places/ui/common/widgets/image.dart';
import 'package:places/ui/common/widgets/separator.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';

/// Экран отображения детальной информации об интересном месте
class SightDetails extends StatefulWidget {
  const SightDetails({
    Key key,
    this.id,
  }) : super(key: key);

  final String id;

  @override
  _SightDetailsState createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  Sight sight;

  Sight getSight(String id) => mocks.firstWhere((sight) => sight.id == id);

  @override
  void initState() {
    super.initState();
    sight = getSight(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            primary: true,
            stretch: true,
            pinned: true,
            automaticallyImplyLeading: false,
            expandedHeight: 360,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [const _BackButton()],
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              stretchModes: <StretchMode>[
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
              background: GalleryWidget(imagesUrlList: sight.imgListUrl),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            sliver: SliverFillRemaining(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _SightDescription(sight: sight),
                  const SizedBox(height: 24),
                  const _RouteButton(),
                  const SizedBox(height: 24),
                  const Separator(),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const _PlanningButton(),
                      const _FavouriteButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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

  final List<String> imagesUrlList;

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
          sight.details,
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
