import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        // flexibleSpace: Container(height: 250, color: AppColors.green),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.only(
              left: AppConstants.pageMarginHorizontal / 2),
          decoration: BoxDecoration(
              color: AppColors.lightSecondary45,
              borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
          height: 50,
          child: const TextField(
            style: TextStyles.normalContent,
            cursorColor: AppColors.darkSecondary,
            decoration: InputDecoration(
                hintText: 'Tìm kiếm',
                hintStyle: TextStyles.normalContent,

                // filled: true,
                // fillColor: AppColors.lightSecondary45,
                border: InputBorder.none),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(
                  right: AppConstants.pageMarginHorizontal,
                  left: AppConstants.pageMarginHorizontal / 2),
              child: Icon(
                Icons.filter_alt_outlined,
                size: kToolbarHeight - 30,
                color: AppColors.secondary,
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            children: [
              ChoiceChip(
                selectedColor: AppColors.lightPrimary,
                label: Text('Tất cả'),
                selected: true,
              ),
              ChoiceChip(
                disabledColor: Colors.transparent,
                label: Text('Bán'),
                selected: false,
              ),
              ChoiceChip(
                label: Text('Thuê'),
                selected: true,
              )
            ],
          ),
        ),
      ),
      body: ListView(children: [Container(height: 1000)]),
    );
  }
}
