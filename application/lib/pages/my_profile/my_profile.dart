import 'package:bk_3d_view/pages/my_profile/bloc/my_profile_bloc.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:bk_3d_view/widgets/app_bar/app_bar_text_title.dart';
import 'package:bk_3d_view/widgets/button/icon_action_button.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfile extends StatelessWidget {
  final String userId;

  const MyProfile({Key? key, required this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget buildDataInfo(String label, dynamic data) => Padding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$label: ',
                  style:
                      TextStyles.normalLabel.copyWith(color: AppColors.black)),
              Expanded(
                  child: Wrap(children: [
                Text(
                  data.toString(),
                  style: TextStyles.normalContent,
                )
              ]))
            ],
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.pageMarginHorizontal, vertical: 10),
        );

    return Scaffold(
      appBar: MyAppBar(
        title: const AppBarTextTitle(
          title: 'Thông tin cá nhân',
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primary,
        actions: [
          IconActionButton(
            icon: Icons.edit,
            iconColor: AppColors.white,
          )
        ],
      ),
      body: RepositoryProvider(
        create: (context) => MyProfileRepository(),
        child: BlocProvider(
          create: (context) => MyProfileBloc(repository: RepositoryProvider.of(context)),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox.square(
                  dimension: 75,
                  child: CircleAvatar(
                    backgroundColor: null,
                    // user.username == null ? AppColors.lightSecondary45 : null,
                    child: Text(
                      'N',
                      // user.username?[0].toUpperCase() ?? '',
                      style: TextStyles.screenTitle
                          .copyWith(color: AppColors.white, fontSize: 28),
                    ),
                    radius: 24,
                  ),
                ),
              ),
              buildDataInfo("Họ và tên: ", 'Nam'),
              buildDataInfo("Số điện thoại: ", "09xxxxxxx"),
              buildDataInfo("Email: ", "nam.doan302@hcmut.edu.vn"),
            ],
          ),
        ),
      ),
    );
  }
}
