import 'package:bk_3d_view/blocs/blocs.dart';
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
      const NewPost(),
      const ManagePost(),
      const MyPage()
    ];
    const List<Map<String, dynamic>> tabs = [
      {'icon': Icons.home_rounded, 'name': 'Trang chủ'},
      {'icon': Icons.search_rounded, 'name': 'Tìm kiếm'},
      {'icon': Icons.star_border_rounded, 'name': 'Theo dõi'},
      {'icon': Icons.person_outline_rounded, 'name': 'Tôi'}
    ];
    List<BottomNavigationBarItem> items = tabs
        .map((tab) => BottomNavigationBarItem(
              icon: Icon(tab['icon'], size: 30),
              label: tab['name'],
            ))
        .toList();

    return BlocProvider(
      create: (context) => MainPageBloc(),
      child: Scaffold(
        body: BlocBuilder<MainPageBloc, int>(
          builder: (context, state) => Center(child: pages[state]),
        ),
        bottomNavigationBar: BlocBuilder<MainPageBloc, int>(
          builder: (context, state) {
            return BottomNavigationBar(
                selectedItemColor: AppColors.darkPrimary,
                unselectedItemColor: AppColors.secondary,
                selectedLabelStyle: AppStyles.selectedTab,
                unselectedLabelStyle: AppStyles.unselectedTab,
                showUnselectedLabels: true,
                currentIndex: state,
                onTap: (int index) {
                  BlocProvider.of<MainPageBloc>(context)
                      .add(OnChangePage(index));
                },
                items: items);
          },
        ),
      ),
    );
  }
}
