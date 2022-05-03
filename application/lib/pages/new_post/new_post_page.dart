import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/new_post/view/data_view/bloc/data_view_bloc.dart';
import 'package:bk_3d_view/pages/new_post/view/data_view/data_view.dart';
import 'package:bk_3d_view/pages/new_post/view/hotspot_view/hotspot_view.dart';
import 'package:bk_3d_view/pages/new_post/view/image_view/bloc/image_view_bloc.dart';
import 'package:bk_3d_view/pages/new_post/view/image_view/image_view.dart';
import 'package:bk_3d_view/pages/new_post/view/remove_view/remove_view.dart';
import 'package:bk_3d_view/pages/new_post/view/thumbnail_view/bloc/thumbnail_view_bloc.dart';
import 'package:bk_3d_view/pages/new_post/view/thumbnail_view/thumbnail_view.dart';
import 'package:bk_3d_view/repositories/new_post/new_post_repository.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/new_post_bloc.dart';

Province p = Province(id: 1, name: 'A');
District d = District(id: 1, name: 'district', provinceId: 1);
// var list= [1,2,3,4];

List<Province> provinces = List.filled(1, p);
List<District> districts = List.filled(20, d);

class NewPostPage extends StatelessWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var steps = NewPostStep.values;
    // Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: RepositoryProvider(
        create: (context) => NewPostRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => NewPostBloc(
                  repository:
                      RepositoryProvider.of<NewPostRepository>(context)),
            ),
            BlocProvider(
              create: (context) => DataViewBloc(
                  repository: RepositoryProvider.of<NewPostRepository>(context))
                ..add(DataViewInitEvent()),
            ),
            BlocProvider(
              create: (context) => ImageViewBloc(
                  repository:
                      RepositoryProvider.of<NewPostRepository>(context)),
            ),
            BlocProvider(
              create: (context) => ThumbnailViewBloc(
                  repository:
                      RepositoryProvider.of<NewPostRepository>(context)),
            ),
          ],
          child: BlocBuilder<NewPostBloc, NewPostState>(
            builder: (context, state) {
              NewPostBloc bloc = context.read<NewPostBloc>();
              debugPrint(bloc.state.currentStep.toString());
              return Scaffold(
                backgroundColor: AppColors.white,
                appBar: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.white,
                  centerTitle: true,
                  title: AppBarTextTitle(
                    title: 'Bước ${(state.currentStep + 1).toString()}',
                    color: AppColors.darkPrimary,
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: ActionButton(
                      label: 'Hủy',
                      labelColor: AppColors.red,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  actions: bloc.state.currentStep == steps.length - 1
                      ? [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: ActionButton(
                              label: 'Xong',
                              labelColor: AppColors.green,
                              onTap: () {},
                            ),
                          )
                        ]
                      : null,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(35),
                    child: buildStepControl(context, steps: steps),
                  ),
                ),
                body: IndexedStack(
                  index: bloc.state.currentStep,
                  children: steps.map((step) => getStepView(step)).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildStepControl(BuildContext context,
      {required List<NewPostStep> steps}) {
    NewPostBloc bloc = context.read<NewPostBloc>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 39,
      decoration: const BoxDecoration(color: AppColors.darkPrimary, boxShadow: [
        BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 4,
            color: AppColors.lightSecondary)
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bloc.state.currentStep != 0
              ? GestureDetector(
                  onTap: () => bloc.add(NewPostBackEvent()),
                  child: const Icon(
                    Icons.arrow_left_rounded,
                    size: 39,
                    color: AppColors.white80,
                  ),
                )
              : const SizedBox(width: 39),
          Expanded(
            child: Center(
              child: Text(
                steps[bloc.state.currentStep].instruction,
                style:
                    TextStyles.tinyContent.copyWith(color: AppColors.white80),
              ),
            ),
          ),
          bloc.state.currentStep != steps.length - 1
              ? GestureDetector(
                  onTap: () => bloc.add(NewPostNextEvent()),
                  child: const Icon(
                    Icons.arrow_right_rounded,
                    size: 39,
                    color: AppColors.white80,
                  ),
                )
              : const SizedBox(width: 39)
        ],
      ),
    );
  }

  Widget getStepView(NewPostStep step) {
    switch (step) {
      case NewPostStep.data:
        return const DataView();
      case NewPostStep.image:
        return const ImageView();
      case NewPostStep.thumbnail:
        return const ThumbnailView();
      case NewPostStep.hotspot:
        return const HotSpotView();
      case NewPostStep.remove:
        return const RemoveView();
    }
  }
}
