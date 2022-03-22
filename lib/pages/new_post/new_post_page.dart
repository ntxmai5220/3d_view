import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/new_post/view/data_view/bloc/data_view_bloc.dart';
import 'package:bk_3d_view/pages/new_post/view/data_view/data_view.dart';
import 'package:bk_3d_view/pages/new_post/view/image_view/image_view.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/values.dart';
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
    Size size = MediaQuery.of(context).size;
    return RepositoryProvider(
      create: (context) => NewPostRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewPostBloc(
                repository: RepositoryProvider.of<NewPostRepository>(context)),
          ),
          BlocProvider(
            create: (context) => DataViewBloc(
                repository: RepositoryProvider.of<NewPostRepository>(context))
              ..add(DataViewInitEvent()),
          )
        ],
        child: BlocBuilder<NewPostBloc, NewPostState>(
          builder: (context, state) {
            NewPostBloc bloc = context.read<NewPostBloc>();
            debugPrint(bloc.state.currentStep.toString());
            return SafeArea(
              child: Scaffold(
                body: IndexedStack(
                  index: bloc.state.currentStep,
                  children: AppConstants.newPostSteps
                      .map((step) => getStepView(step))
                      .toList(),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: buildStepControl(context),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildStepControl(BuildContext context) {
    NewPostBloc bloc = context.read<NewPostBloc>();
    return Padding(
      padding: const EdgeInsets.all(AppConstants.pageMarginHorizontal * 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: bloc.state.currentStep != 0,
            child: FloatingActionButton(
              backgroundColor: AppColors.lightPrimary,
              child: const Icon(
                Icons.chevron_left_rounded,
                size: 28,
              ),
              onPressed: () => bloc.add(NewPostBackEvent()),
            ),
          ),
          bloc.state.currentStep == AppConstants.newPostSteps.length - 1
              ? FloatingActionButton(
                  backgroundColor: AppColors.green,
                  child: const Icon(
                    Icons.done_rounded,
                    size: 28,
                  ),
                  onPressed: () => bloc.add(NewPostDoneEvent()),
                )
              : FloatingActionButton(
                  backgroundColor: AppColors.lightPrimary,
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    size: 30,
                  ),
                  onPressed: () => bloc.add(NewPostNextEvent()),
                ),
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
    }
  }
}
