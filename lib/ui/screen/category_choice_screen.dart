import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/interactor/filter/sight_interactor.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/common/widgets/back_button.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';

///Экран выбора категории
class CategoryChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(sightCategoryText),
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: categoryValues
                  .map(
                    (item) => _CategoryTile(name: item["name"]),
                  )
                  .toList(),
            ),
            const _SaveCategoryButton()
          ],
        ),
      ),
    );
  }
}

///Кнопка сохранения категории
class _SaveCategoryButton extends StatelessWidget {
  const _SaveCategoryButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        initialData: sightInteractor.categoryName,
        stream: sightInteractor.choicedCategoryControllerStream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Container(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: snapshot.data.isNotEmpty
                    ? () {
                        sightInteractor.validate();
                        Navigator.of(context).pop();
                      }
                    : null,
                child: Text(saveText.toUpperCase()),
              ),
            ),
          );
        });
  }
}

///Элемент списка категорий
class _CategoryTile extends StatelessWidget {
  final String name;
  const _CategoryTile({
    Key key,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      initialData: sightInteractor.categoryName,
      stream: sightInteractor.choicedCategoryControllerStream,
      builder: (context, snapshot) {
        return ListTile(
          onTap: () {
            sightInteractor.category = name;
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
