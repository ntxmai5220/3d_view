import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/list_user/bloc/list_user_bloc.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:bk_3d_view/widgets/app_bar/back_leading.dart';
import 'package:bk_3d_view/widgets/button/action_button.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUser extends StatelessWidget {
  const ListUser({Key? key}) : super(key: key);
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

    Widget buildNameCard(String name) => Padding(
          padding: const EdgeInsets.all(2),
          child: CircleAvatar(
            child: Text(
              name[0],
              style: TextStyles.buttonText.copyWith(fontSize: 15),
            ),
            radius: 20,
          ),
        );

    Widget buildUserCard({required User user}) => Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: buildNameCard(user.username?[0] ?? ''),
                title: Text(user.username ?? ''),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ActionButton(
                    label: "Xem chi tiết",
                    labelColor: AppColors.primary,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => MyProfile(userId: user.id))),
                  ),
                  const SizedBox(width: 8),
                  const ActionButton(
                    label: "Xóa",
                    labelColor: AppColors.red,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        );

    return Scaffold(
      appBar: MyAppBar(
        title: const AppBarTextTitle(
          title: 'Quản lý người dùng',
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primary,
      ),
      body: RepositoryProvider(
        create: (context) => ListUserRepository(),
        child: BlocProvider(
          create: (context) => ListUserBloc(
              repository: RepositoryProvider.of<ListUserRepository>(context))
            ..add(ListUserInitEvent()),
          child: BlocBuilder<ListUserBloc, ListUserState>(
            builder: (context, state) {
              if (state is ListUserLoaded) {
                return ListView.separated(
                  itemBuilder: (context, index) =>
                      buildUserCard(user: state.list[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: state.list.length,
                );
              } else if (state is ListUserError) {
                return MyErrorWidget(
                    onTap: () =>
                        context.read<ListUserBloc>().add(ListUserInitEvent()));
              } else {
                return const LoadingPlaceHolder(
                    width: double.maxFinite, height: double.maxFinite);
              }
            },
          ),
        ),
      ),
    );
  }
}
