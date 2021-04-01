import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/filter/filter_interactor.dart';
import 'package:places/ui/common/formatters/formatter.dart';
import 'package:places/ui/common/widgets/back_button.dart';
import 'package:places/ui/common/widgets/text_form_field.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/util/const.dart';

final filterInteractor = FilterInteractor();

/// Экран фильтров
class FiltersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        actions: [const _ClearButton()],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const _FilterTable(),
                const SizedBox(height: 56),
                const _RadiusSlider(),
              ]),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: const _FilterButton(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Кнопка отмены фильтров
class _ClearButton extends StatelessWidget {
  const _ClearButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Text(
        cancelText,
        style: textSubtitle1.copyWith(
          color: colorLightGreen,
        ),
      ),
      onPressed: filterInteractor.clear,
    );
  }
}

/// Таблица фильтров
class _FilterTable extends StatelessWidget {
  const _FilterTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CaptionText(title: categoriesText),
        const SizedBox(
          height: 24,
        ),
        StreamBuilder<List<Map>>(
          initialData: filterInteractor.filterValues,
          stream: filterInteractor.filtersStream,
          builder: (context, snapshot) {
            return (MediaQuery.of(context).size.height <= 800 &&
                    MediaQuery.of(context).size.width <= 480)
                ? Container(
                    height: 100,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: snapshot.data
                          .map(
                            (item) => Padding(
                              padding: const EdgeInsets.only(right: 44.0),
                              child: _FilterItem(
                                key: ValueKey(item["name"]),
                                category: item,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                : Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    children: snapshot.data
                        .map(
                          (item) => _FilterItem(
                            key: ValueKey(item["name"]),
                            category: item,
                          ),
                        )
                        .toList(),
                  );
          },
        )
      ],
    );
  }
}

/// Элемент фильтра
class _FilterItem extends StatelessWidget {
  final Map category;

  const _FilterItem({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: () => filterInteractor.choiceFilterItem = category,
          splashColor: colorLightGreen.withOpacity(.16),
          child: Container(
              decoration: BoxDecoration(
                color: colorLightGreen.withOpacity(.16),
                shape: BoxShape.circle,
              ),
              height: 64,
              width: 64,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  category["isTicked"]
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: const _TickChoice(),
                        )
                      : Container(),
                  SvgPicture.asset(
                    category["iconText"],
                    color: colorLightGreen,
                  )
                ],
              )),
        ),
        const SizedBox(height: 12),
        Text(
          category["name"],
          style: Theme.of(context).textTheme.caption.copyWith(
                color: Theme.of(context).accentColor,
              ),
        ),
      ],
    );
  }
}

/// Иконка выбора
class _TickChoice extends StatelessWidget {
  const _TickChoice({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).accentColor,
      ),
      child: SvgPicture.asset(
        icTickChoice,
        color: Theme.of(context).backgroundColor,
      ),
    );
  }
}

/// Слайдер
class _RadiusSlider extends StatelessWidget {
  const _RadiusSlider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        initialData: filterInteractor.rangeValues,
        stream: filterInteractor.rangeValuesStream,
        builder: (context, snapshot) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      distanceText,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      "от ${distanceFormat(filterInteractor.rangeValues.start)} до ${distanceFormat(filterInteractor.rangeValues.end)}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                RangeSlider(
                  values: snapshot.data,
                  min: minDistanceM,
                  max: maxDistanceM,
                  onChanged: (RangeValues values) =>
                      filterInteractor.rangeValuesChange = values,
                ),
              ]);
        });
  }
}

/// Кнопка применения фильтров
class _FilterButton extends StatelessWidget {
  const _FilterButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: List<Sight>(),
      stream: filterInteractor.sightsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Sight>> snapshot) {
        var filterSights = List();
        if (snapshot != null && snapshot.hasData) {
          filterSights = snapshot.data;
        }
        return Container(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            child: Text(
              "$viewButtonText (${filterSights.length})",
            ),
            onPressed: filterSights.length != 0 ? () {} : null,
          ),
        );
      },
    );
  }
}
