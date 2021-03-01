import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/interactor/filter/new_sight_interactor.dart';
import 'package:places/ui/common/widgets/separator.dart';
import 'package:places/ui/common/widgets/text_form_field.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/strings/common_strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/category_choice_screen.dart';

/// Экран добавления нового места
class AddSightScreen extends StatefulWidget {
  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
        title: const Text(addSightTitle),
        leading: CupertinoButton(
          child: Text(
            cancelButtonText,
            style: textSubtitle1.copyWith(
              color: colorDarkSecondary2,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
              delegate: SliverChildListDelegate([
                const _GalleryWidget(),
                const _CategoryChoiceTile(),
                const SizedBox(height: 24),
                TextFormFieldWidget(
                  textController: sightInteractor.nameTextController,
                  label: sightNameText,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  maxLines: 1,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 8,
                      child: TextFormFieldWidget(
                        textController: sightInteractor.latTextController,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        label: sightLatText,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: const SizedBox(width: 16),
                    ),
                    Expanded(
                      flex: 8,
                      child: TextFormFieldWidget(
                        textController: sightInteractor.lonTextController,
                        maxLines: 1,
                        label: sightLonText,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const _GetMapCoordinates(),
                const SizedBox(height: 37),
                TextFormFieldWidget(
                  textController: sightInteractor.descTextController,
                  textInputAction: TextInputAction.done,
                  label: sightDescText,
                  maxLines: 3,
                  hintText: inputValueHintText,
                  textInputType: TextInputType.multiline,
                ),
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
                  child: const _AddSightButton(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///Кнопка добавления нового места
class _AddSightButton extends StatelessWidget {
  const _AddSightButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: false,
        stream: sightInteractor.isValidateStream,
        builder: (context, snapshot) {
          return Container(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: snapshot.data
                  ? () {
                      sightInteractor.createSight();
                      Navigator.of(context).pop();
                    }
                  : null,
              child: Text(
                createText.toUpperCase(),
              ),
            ),
          );
        });
  }
}

/// Выбор координат на карте
class _GetMapCoordinates extends StatelessWidget {
  const _GetMapCoordinates({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text(
          selectMapCoordinatesText,
          style: textSubtitle1.copyWith(
            fontWeight: FontWeight.bold,
            color: colorLightGreen,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}

///Форма выбора категории
class _CategoryChoiceTile extends StatelessWidget {
  const _CategoryChoiceTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CaptionText(title: sightCategoryText),
        ListTile(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (c) => CategoryChoiceScreen(),
            ),
          ),
          contentPadding: EdgeInsets.zero,
          focusColor: colorLightGreen,
          title: StreamBuilder<String>(
              initialData: sightInteractor.categoryName,
              stream: sightInteractor.choicedCategoryControllerStream,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data.isEmpty ? unSelectText : snapshot.data,
                  style: textSubtitle1.copyWith(
                    color: colorDarkSecondary2,
                  ),
                );
              }),
          trailing: SvgPicture.asset(
            icArrowRight,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
        Separator()
      ],
    );
  }
}

///Галерея картинок
class _GalleryWidget extends StatelessWidget {
  const _GalleryWidget({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(height: 72);
  }
}
