import 'package:bk_3d_view/drawer/filter/bloc/filter_drawer_bloc.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterType extends StatefulWidget {
  const FilterType({Key? key}) : super(key: key);

  @override
  State<FilterType> createState() => _FilterTypeState();
}

class _FilterTypeState extends State<FilterType> {
  @override
  Widget build(BuildContext context) {
    var list = PostType.values;
    itemBuilder(BuildContext context, int index) => InkWell(
          onTap: () => context
              .read<FilterDrawerBloc>()
              .add(FilterChangeTypeEvent(type: list[index])),
          child: Container(
            // height: 48,
            decoration: BoxDecoration(
                color: list[index].isRent ==
                        context.read<FilterDrawerBloc>().state.params.isRentEQ
                    ? AppColors.darkPrimary
                    : AppColors.secondary,
                borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            child: Text(
              list[index].title,
              style: TextStyles.tinyLabel.copyWith(
                  color: list[index].isRent ==
                          context.read<FilterDrawerBloc>().state.params.isRentEQ
                      ? AppColors.white
                      : AppColors.darkSecondary),
            ),
          ),
        );
    return BlocBuilder<FilterDrawerBloc, FilterDrawerState>(
      builder: (context, state) {
        return SizedBox(
          height: 58,
          child: ListView.separated(
            padding:
                const EdgeInsets.all(AppConstants.pageMarginHorizontal / 3),
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: itemBuilder,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
          ),
        );
      },
    );
  }
}
