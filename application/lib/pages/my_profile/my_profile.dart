import 'package:bk_3d_view/pages/manage_post/manage_post.dart';
import 'package:bk_3d_view/pages/my_profile/bloc/my_profile_bloc.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfile extends StatelessWidget {
  final String? userId;

  const MyProfile({
    Key? key,
    this.userId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget buildDataInfo(String label, dynamic data) => Padding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style:
                      TextStyles.buttonText.copyWith(color: AppColors.black)),
              Expanded(
                  child: Wrap(children: [
                Text(
                  data.toString(),
                  style: TextStyles.normalLabel,
                )
              ]))
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
        );

    return Scaffold(
      appBar: MyAppBar(
        title: const AppBarTextTitle(
          title: 'Thông tin cá nhân',
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primary,
        actions: userId == null
            ? [
                IconActionButton(
                  icon: Icons.edit,
                  iconColor: AppColors.white,
                  onTap: () {},
                )
              ]
            : null,
      ),
      body: RepositoryProvider(
        create: (context) => MyProfileRepository(),
        child: BlocProvider(
          create: (context) =>
              MyProfileBloc(repository: RepositoryProvider.of(context))
                ..add(MyProfileInitEvent(userId)),
          child: BlocBuilder<MyProfileBloc, MyProfileState>(
            builder: (context, state) {
              if (state is Error) {
                return const MyErrorWidget();
              }
              return ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.pageMarginHorizontal),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox.square(
                      dimension: 75,
                      child: CircleAvatar(
                        backgroundColor: state.user == null
                            ? AppColors.lightSecondary45
                            : null,
                        child: Text(
                          state.user?.username?[0].toUpperCase() ?? '',
                          style: TextStyles.screenTitle
                              .copyWith(color: AppColors.white, fontSize: 28),
                        ),
                        radius: 24,
                      ),
                    ),
                  ),
                  state.user != null
                      ? buildDataInfo("Tên: ", state.user!.username)
                      : tempWidget(),
                  state.user != null
                      ? buildDataInfo("Số điện thoại: ", state.user!.phone)
                      : tempWidget(),
                  state.user != null
                      ? buildDataInfo("Email: ", state.user!.email)
                      : tempWidget(),
                  state.user != null
                      ? InkWell(
                          onTap: () => userId == null
                              ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const ManagePost()))
                              : null,
                          child: Container(
                            // color: AppColors.primary,
                            // height: 50,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${state.user!.posts?.length ?? 0} bài viết',
                                    style: TextStyles.buttonText.copyWith(
                                        fontSize: 20,
                                        color: AppColors.darkPrimary,
                                        height: 1)),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  color: AppColors.darkPrimary,
                                )
                              ],
                            ),
                          ),
                        )
                      : tempWidget(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  tempWidget() => Container(
        height: 28,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: AppColors.lightSecondary45,
            borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
      );
}
