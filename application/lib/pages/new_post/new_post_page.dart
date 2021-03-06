import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/new_post/blocs.dart';
import 'package:bk_3d_view/pages/new_post/view/view.dart';

import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/repositories/new_post/new_post_repository.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var steps = NewPostStep.values;

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
          child: BlocConsumer<NewPostBloc, NewPostState>(
            listenWhen: (previous, current) {
              return (previous is NewPostLoading &&
                      current is! NewPostLoading) ||
                  (previous is! NewPostLoading && current is NewPostLoading);
            },
            listener: (context, state) {
              if (state is NewPostLoading) {
                ShowMyDialog.show(context, dialog: const LoadingDialog());
              } else {
                Navigator.pop(context);
                if (state is NewPostDiscard) {
                  Navigator.pop(context);
                } else if (state is NewPostError) {
                  ShowMyDialog.show(context,
                      dialog: NotificationDialog(
                        content: ValidatorError.defaultError.error,
                        type: DialogType.warning,
                      ));
                }
              }
            },
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
                    title: 'B??????c ${(state.currentStep + 1).toString()}',
                    color: AppColors.darkPrimary,
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: ActionButton(
                      label: 'Hu??y',
                      labelColor: AppColors.red,
                      onTap: () async {
                        var result = await ShowMyDialog.show(context,
                            dialog: const ConfirmDialog(
                                content: 'B???n mu???n h???y vi???c t???o b??i vi???t'));
                        if (result == true) {
                          state.post?.id != null
                              ? bloc.add(NewPostDiscardEvent())
                              : Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                  actions: bloc.state.currentStep == steps.length - 1
                      ? [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: ActionButton(
                                label: 'Xong',
                                labelColor: AppColors.green,
                                onTap: () => Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (_) => PostDetail(
                                            id: bloc.state.post?.id ?? '')))),
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
          bloc.state.currentStep != 0 && bloc.state.currentStep != 2
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
                  onTap: () => nextStep(context,
                      currentStep: steps[bloc.state.currentStep]),
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

  nextStep(BuildContext context, {required NewPostStep currentStep}) async {
    NewPostBloc bloc = context.read<NewPostBloc>();
    DataViewBloc dataViewBloc = context.read<DataViewBloc>();
    FocusManager.instance.primaryFocus?.unfocus();
    switch (currentStep) {
      case NewPostStep.image:
        //call api create post
        // FocusManager.instance.primaryFocus?.unfocus();
        if (context.read<ImageViewBloc>().state.rooms.isEmpty) {
          ShowMyDialog.show(context,
              dialog: const NotificationDialog(
                content: 'B???n ph???i t???o ???nh.',
                type: DialogType.warning,
              ));
        } else {
          var result = await ShowMyDialog.show(context,
              dialog: const ConfirmDialog(
                  content:
                      'B???n s??? kh??ng ???????c quay l???i b?????c n??y. B???n v???n mu???n ti???p t???c b?????c 3.'));
          if (result == true) {
            Post post = Post(
              area: double.tryParse(dataViewBloc.area.text),
              price: double.tryParse(dataViewBloc.price.text),
              isUsed: false,
              isHidden: false,
              isFavorite: false,
              isRent: dataViewBloc.state.type == 1,
              desc: dataViewBloc.desc.text,
              address: dataViewBloc.address.text,
              ward: dataViewBloc.state.wards?[dataViewBloc.state.ward!],
              district:
                  dataViewBloc.state.districts?[dataViewBloc.state.district!] ,
              province:
                  dataViewBloc.state.provinces?[dataViewBloc.state.province!] ,

              // rooms: ,
              // creatorId: '625bd0648e18145a85211945'
            );
            bloc.add(NewPostCreateEvent(
              post: post,
              rooms: context.read<ImageViewBloc>().state.rooms,
            ));
          }
        }
        break;
      case NewPostStep.data:
        dataViewBloc.add(DataViewCheckDataEvent());
        // if(context.read<DataViewBloc>().state.isValid??false){

        // }
        break;
      case NewPostStep.thumbnail:
        //call api

        bloc.add(NewPostUploadThumbnailsEvent(
            thumbnails: context.read<ThumbnailViewBloc>().state.capture));

        break;
      default:
        bloc.add(NewPostNextEvent());
    }
  }
}
