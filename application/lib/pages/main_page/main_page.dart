import 'package:bk_3d_view/pages/main_page/bloc/main_page_bloc.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePage(),
      const SearchPage(),
      const FollowedPage(),
      const MyPage()
    ];
    const List<Map<String, dynamic>> tabs = [
      {'icon': Icons.home_rounded, 'name': 'Trang chủ'},
      {'icon': Icons.search_rounded, 'name': 'Tìm kiếm'},
      {'icon': Icons.star_rounded, 'name': 'Theo dõi'},
      {'icon': Icons.person_outline_rounded, 'name': 'Tôi'}
    ];
    List<Tab> items = tabs
        .map((tab) => Tab(
              icon: Icon(tab['icon'], size: 25),
              iconMargin: const EdgeInsets.only(bottom: 1, top: 1),
              text: tab['name'],
            ))
        .toList();

    return BlocProvider(
      create: (context) => MainPageBloc(),
      child: Scaffold(
        backgroundColor: AppColors.lightPrimary,
        body: SafeArea(
          child: BlocBuilder<MainPageBloc, int>(
            builder: (context, state) => Center(child: pages[state]),
          ),
        ),
        bottomNavigationBar: BlocBuilder<MainPageBloc, int>(
          builder: (context, state) {
            return DefaultTabController(
              length: pages.length,
              child: Container(
                height: 52,
                decoration: const BoxDecoration(
                    color: AppColors.black,
                    boxShadow: [
                      BoxShadow(offset: Offset(0, 0), blurRadius: 3)
                    ]),
                child: TabBar(
                    labelStyle: TextStyles.selectedTab,
                    unselectedLabelStyle: TextStyles.unselectedTab,
                    labelColor: AppColors.white,
                    unselectedLabelColor: AppColors.darkSecondary,
                    indicatorWeight: 1,
                    indicatorColor: AppColors.white70,
                    onTap: (int index) {
                      BlocProvider.of<MainPageBloc>(context)
                          .add(OnChangePage(index));
                    },
                    tabs: items),
              ),
            );
          },
        ),
      ),
    );
  }
}
