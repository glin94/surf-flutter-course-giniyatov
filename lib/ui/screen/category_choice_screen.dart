import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/new_place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/ui/common/widgets/back_button.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:provider/provider.dart';

/// Экран выбора категории
class CategoryChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(placeCategoryText),
        leading: const CustomBackButton(),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                context
                    .watch<SearchInteractor>()
                    .filterValues
                    .map((item) => _CategoryTile(name: item["name"]))
                    .toList(),
              ),
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
                  child: const _SaveCategoryButton(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Кнопка сохранения категории
class _SaveCategoryButton extends StatelessWidget {
  const _SaveCategoryButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeModel = context.watch<NewPlaceInteractor>();
    return StreamBuilder<String>(
        initialData: placeModel.categoryName,
        stream: placeModel.choicedCategoryControllerStream,
        builder: (context, snapshot) {
          return Container(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: snapshot.data.isNotEmpty
                  ? () {
                      placeModel.validate();
                      Navigator.of(context).pop();
                    }
                  : null,
              child: Text(saveText.toUpperCase()),
            ),
          );
        });
  }
}

/// Элемент списка категорий
class _CategoryTile extends StatelessWidget {
  final String name;
  const _CategoryTile({
    Key key,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeModel = context.watch<NewPlaceInteractor>();

    return StreamBuilder<String>(
      initialData: placeModel.categoryName,
      stream: placeModel.choicedCategoryControllerStream,
      builder: (context, snapshot) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {
            placeModel.category = name;
          },
          trailing: name == snapshot.data
              ? SvgPicture.asset(
                  icTickChoice,
                  height: 24,
                  width: 24,
                  color: colorLightGreen,
                )
              : null,
          title: Text(name),
        );
      },
    );
  }
}
