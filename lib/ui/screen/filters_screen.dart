import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/interactor/filter/filter_interactor.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/formatters/formatter.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/util/const.dart';

///Экран фильтров
class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  void initState() {
    super.initState();
    filterInteractor.filter(categoryValues);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: [
          _ClearButton(),
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
                    const _FilterTable(),
                  ],
                ),
                const SizedBox(height: 56),
                _RadiusSlider(),
              ],
            ),
            _FilterButton(),
          ],
        ),
      ),
    );
  }
}

/// Кнопка отмены фильтров
class _ClearButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        child: Text(
          cancelText,
          style: textSubtitle1.copyWith(
            color: colorLightGreen,
          ),
        ),
        onPressed: () {
          ///отмена фильтра
          categoryValues.forEach(
            (item) => item["isTicked"] = false,
          );
          filterInteractor.filter(categoryValues);
        });
  }
}

/// Таблица фильтров
class _FilterTable extends StatelessWidget {
  const _FilterTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 44,
      runSpacing: 40,
      children: categoryValues
          .map(
            (item) => _FilterItem(
              category: item,
            ),
          )
          .toList(),
    );
  }
}

/// Элемент фильтра
class _FilterItem extends StatefulWidget {
  final category;

  const _FilterItem({Key key, this.category}) : super(key: key);
  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<_FilterItem> {
  @override
  void initState() {
    super.initState();

    filterInteractor.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: () {
            setState(() {
              widget.category["isTicked"] = !widget.category["isTicked"];
              filterInteractor.filter(categoryValues);
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
                        child: const _TickChoice(),
                      )
                    : Container(),
                SvgPicture.asset(
                  widget.category["iconText"],
                  color: colorLightGreen,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.category["name"],
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

///Слайдер
class _RadiusSlider extends StatefulWidget {
  @override
  _RadiusSliderState createState() => _RadiusSliderState();
}

class _RadiusSliderState extends State<_RadiusSlider> {
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
            "от ${distanceFormat(filterInteractor.rangeValues.start)} до ${distanceFormat(filterInteractor.rangeValues.end)}",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
      SizedBox(
        height: 24,
      ),
      RangeSlider(
        values: filterInteractor.rangeValues,
        min: minDistanceM,
        max: maxDistanceM,
        onChanged: (RangeValues value) {
          setState(() {
            filterInteractor.rangeValuesChange = value;
            filterInteractor.filter(categoryValues);
          });
        },
      ),
    ]);
  }
}

/// Кнопка применения фильтров
class _FilterButton extends StatefulWidget {
  @override
  __FilterButtonState createState() => __FilterButtonState();
}

class __FilterButtonState extends State<_FilterButton> {
  @override
  void initState() {
    super.initState();
    filterInteractor.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          "$viewButtonText (${filterInteractor.filterSights.length})",
        ),
        onPressed: () {},
      ),
    );
  }
}
