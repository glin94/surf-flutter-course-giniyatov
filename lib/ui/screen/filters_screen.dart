import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/formatters/formatter.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/util/const.dart';
import 'package:places/util/filter.dart';

///Экран фильтров
class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  void initState() {
    super.initState();

    filterModel.addListener(() {
      setState(() {});
    });

    ///начальные значения фильтров
    categoryValues.forEach((item) {
      if (mocks.any((sight) => item['name'].toLowerCase() == sight.type))
        item['isTicked'] = true;
    });

    ///фильтрация
    filterModel.filter(categoryValues);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: [
          ClearButton(),
        ],
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
                          categoriesText,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Filter(),
                  ],
                ),
                const SizedBox(height: 56),
                RadiusSlider(),
              ],
            ),
            FilterButton(),
          ],
        ),
      ),
    );
  }
}

/// Таблица фильтров
class Filter extends StatefulWidget {
  const Filter({
    Key key,
  }) : super(key: key);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  void initState() {
    super.initState();

    filterModel.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 44,
      runSpacing: 40,
      children: categoryValues
          .map((item) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilterItem(
                    category: item,
                  ),
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
}

/// Элемент фильтра
class FilterItem extends StatefulWidget {
  final category;

  const FilterItem({Key key, this.category}) : super(key: key);
  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: () {
        setState(() {
          widget.category["isTicked"] = !widget.category["isTicked"];
          filterModel.filter(categoryValues);
        });
      },
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
            widget.category["isTicked"]
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: const TickChoice(),
                  )
                : Container(),
            SvgPicture.asset(
              widget.category["iconText"],
              color: colorLightGreen,
            )
          ],
        ),
      ),
    );
  }
}

/// Иконка выбора
class TickChoice extends StatelessWidget {
  const TickChoice({
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

/// Кнопка применения фильтров
class FilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          "$viewButtonText (${filterModel.filterSights.length})",
        ),
        onPressed: () {},
      ),
    );
  }
}

/// Кнопка отмены фильтров
class ClearButton extends StatefulWidget {
  @override
  _ClearButtonState createState() => _ClearButtonState();
}

class _ClearButtonState extends State<ClearButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Text(
        cancelText,
        style: textSubtitle1.copyWith(
          color: colorLightGreen,
        ),
      ),
      onPressed: () => setState(() {
        ///отмена фильтра
        categoryValues.forEach(
          (item) => item["isTicked"] = false,
        );
        filterModel.filter(categoryValues);
      }),
    );
  }
}

///Слайдер
class RadiusSlider extends StatefulWidget {
  @override
  _RadiusSliderState createState() => _RadiusSliderState();
}

class _RadiusSliderState extends State<RadiusSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            distanceText,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            "от ${distanceFormat(filterModel.rangeValues.start)} до ${distanceFormat(filterModel.rangeValues.end)}",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
      SizedBox(
        height: 24,
      ),
      RangeSlider(
        values: filterModel.rangeValues,
        min: minDistanceM,
        max: maxDistanceM,
        onChanged: (RangeValues value) {
          setState(() {
            filterModel.rangeValuesChange = value;
            filterModel.filter(categoryValues);
          });
        },
      ),
    ]);
  }
}
