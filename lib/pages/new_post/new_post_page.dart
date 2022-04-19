import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/new_post/view/data_view/bloc/data_view_bloc.dart';
import 'package:bk_3d_view/pages/new_post/view/data_view/data_view.dart';
import 'package:bk_3d_view/pages/new_post/view/image_view/bloc/image_view_bloc.dart';
import 'package:bk_3d_view/pages/new_post/view/image_view/image_view.dart';
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
          ),
          BlocProvider(
            create: (context) => ImageViewBloc(
                repository: RepositoryProvider.of<NewPostRepository>(context)),
          )
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
                backgroundColor: AppColors.darkPrimary,
                centerTitle: true,
                title: AppBarTextTitle(
                  title: 'Bước ${(state.currentStep + 1).toString()}',
                  color: AppColors.white,
                ),
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
    );
  }

  Widget buildStepControl(BuildContext context,
      {required List<NewPostStep> steps}) {
    NewPostBloc bloc = context.read<NewPostBloc>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 39,
      decoration: const BoxDecoration(color: AppColors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, -1),
            blurRadius: 4,
            color: AppColors.lightSecondary88)
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
                    color: AppColors.secondary,
                  ),
                )
              : const SizedBox(width: 39),
          Expanded(
            child: Center(
              child: Text(
                steps[bloc.state.currentStep].instruction,
                style: TextStyles.tinyContent,
              ),
            ),
          ),
          bloc.state.currentStep != steps.length - 1
              ? GestureDetector(
                  onTap: () => bloc.add(NewPostNextEvent()),
                  child: const Icon(
                    Icons.arrow_right_rounded,
                    size: 39,
                    color: AppColors.darkPrimary,
                  ),
                )
              : GestureDetector(
                  // onTap: () => bloc.add(NewPostNextEvent()),
                  child: Stack(
                    children: [
                      Container(
                        width: 39,
                        height: 39,
                        padding: const EdgeInsets.all(1),
                        child: const Icon(
                          Icons.circle,
                          size: 30,
                          color: AppColors.green,
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.done_rounded,
                          size: 22,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
                )
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
      case NewPostStep.hotspot:
        return const SizedBox();
    }
  }
}
