import 'package:bk_3d_view/drawer/filter/bloc/filter_drawer_bloc.dart';
import 'package:bk_3d_view/drawer/filter/filter_type.dart';
import 'package:bk_3d_view/models/filter_param/filter_param.dart';
import 'package:bk_3d_view/pages/search/bloc/search_bloc.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:bk_3d_view/widgets/button/action_button.dart';

import 'package:bk_3d_view/widgets/text/m_square.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({
    Key? key,
    required this.onTapFilter,
  }) : super(key: key);

  final Function(FilterParam) onTapFilter;

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<FilterDrawerBloc>();

    Widget buildRangeInput(String label,
            {required TextEditingController controller}) =>
        Flexible(
            child: Row(
          children: [
            Text(
              label,
              style: TextStyles.normalContent,
            ),
            const SizedBox(width: 2),
            Flexible(
              child: TextFormField(
                controller: controller,
                style: TextStyles.normalContent,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(width: 2)
          ],
        ));

    Widget buildFilterInRange(String title, Widget unit,
            {required TextEditingController controller1,
            required TextEditingController controller2}) =>
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyles.normalLabel
                      .copyWith(color: AppColors.darkSecondary),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildRangeInput("Từ ", controller: controller1),
                buildRangeInput(" - ", controller: controller2),
                unit,
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );

    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.pageMarginHorizontal / 2),
          children: [
            // buildFilterType(),
            const FilterType(),
            buildFilterInRange(
              "Diện tích",
              const SizedBox(
                width: 50,
                child: MSquare(style: TextStyles.normalContent),
              ),
              controller1: bloc.area1,
              controller2: bloc.area2,
            ),
            buildFilterInRange(
              "Giá",
              const SizedBox(
                width: 50,
                child: Text(" triệu", style: TextStyles.normalContent),
              ),
              controller1: bloc.price1,
              controller2: bloc.price2,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.pageMarginHorizontal),
              child: ActionButton(
                  background: AppColors.primary,
                  labelColor: AppColors.white,
                  labelStyle: TextStyles.normalLabel,
                  padding: 6,
                  label: 'Lọc',
                  onTap: () {
                    context.read<FilterDrawerBloc>().add(FilterSaveEvent());
                    onTapFilter.call(context.read<FilterDrawerBloc>().state.params);
                    // context.read<SearchBloc>().add(SearchLoadEvent(
                    //     params: context.read<FilterDrawerBloc>().state.params));
                    Navigator.of(context).pop();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
