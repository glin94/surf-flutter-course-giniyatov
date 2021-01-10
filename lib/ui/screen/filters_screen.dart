import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/util/filter.dart';
import 'package:places/util/formatter.dart';

///Экран фильтров
class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  ///Фильтрованный список (изначально пустой)
  List<Sight> _filterSights = List();

  double _min = 100;

  double _max = 10000;

  RangeValues _rangeValues;

  @override
  void initState() {
    super.initState();

    _rangeValues = RangeValues(_min, _max);

    ///начальные значения фильтров
    categoryValues.forEach((item) {
      if (mocks.any((sight) => item['name'].toLowerCase() == sight.type))
        item['isTicked'] = true;
    });

    ///фильтрация
    _filterSights = filter(
      _rangeValues.start / 1000,
      _rangeValues.end / 1000,
      categoryValues,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 32,
          icon: SvgPicture.asset(icArrow),
          onPressed: () {},
        ),
        actions: [buildClearFilterButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "КАТЕГОРИИ",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    _buildFilterIcons(context),
                  ],
                ),
                SizedBox(
                  height: 56,
                ),
                _buildSlider(context)
              ],
            ),
            _buildFilterButton()
          ],
        ),
      ),
    );
  }

  /// Кнопка отмены фильтров
  CupertinoButton buildClearFilterButton() {
    return CupertinoButton(
      child: Text(
        "Очистить",
        style: textSubtitle1.copyWith(
          color: colorLightGreen,
        ),
      ),
      onPressed: () => setState(() {
        ///отмена фильтра
        categoryValues.forEach(
          (item) => item["isTicked"] = false,
        );

        _filterSights = filter(
          _rangeValues.start / 1000,
          _rangeValues.end / 1000,
          categoryValues,
        );
      }),
    );
  }

  /// Таблица фильтров
  Widget _buildFilterIcons(BuildContext context) {
    return Wrap(
      spacing: 44,
      runSpacing: 40,
      children: categoryValues
          .map((item) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFilterItem(context, item),
                  const SizedBox(height: 12),
                  Text(
                    item["name"],
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).accentColor,
                        ),
                  ),
                ],
              ))
          .toList(),
    );
  }

  /// Элемент фильтра
  Widget _buildFilterItem(BuildContext context, Map<String, dynamic> category) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: () => setState(() {
        category["isTicked"] = !category["isTicked"];

        _filterSights = filter(
          _rangeValues.start / 1000,
          _rangeValues.end / 1000,
          categoryValues,
        );
      }),
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
                    child: _buildTickChoice(context),
                  )
                : Container(),
            SvgPicture.asset(
              category["iconText"],
              color: colorLightGreen,
            )
          ],
        ),
      ),
    );
  }

  /// Иконка выбора
  Widget _buildTickChoice(BuildContext context) {
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

  ///Слайдер
  Widget _buildSlider(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Расстояние",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            "от ${distanceFormat(_rangeValues.start)} до ${distanceFormat(_rangeValues.end)}",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
      SizedBox(
        height: 24,
      ),
      RangeSlider(
        values: _rangeValues,
        min: _min,
        max: _max,
        onChanged: (RangeValues value) {
          setState(() {
            _rangeValues = value;

            _filterSights = filter(
              _rangeValues.start / 1000,
              _rangeValues.end / 1000,
              categoryValues,
            );
          });
        },
      ),
    ]);
  }

  /// Кнопка применения фильтров
  Widget _buildFilterButton() {
    return Container(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
          child: Text(
            "ПОКАЗАТЬ (${_filterSights.length})",
          ),
          onPressed: () {}),
    );
  }
}
