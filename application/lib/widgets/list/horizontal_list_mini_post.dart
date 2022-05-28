// import 'package:bk_3d_view/data/mock.dart';
// import 'package:bk_3d_view/values/values.dart';
// import 'package:flutter/material.dart';

// import '../post_item.dart';

// class HorizontalListMiniPost extends StatelessWidget {
//   const HorizontalListMiniPost({
//     Key? key,
//     this.pageController,
//     this.list = const [],
//     this.title,
//     this.onToggleFavorite,
//     this.onTapPost,
//   }) : super(key: key);

//   final PageController? pageController;
//   final List<dynamic> list;
//   final String? title;
//   final Function(String)? onToggleFavorite;
//   final Function(String)? onTapPost;

//   @override
//   Widget build(BuildContext context) {
//     return list.isNotEmpty
//         ? Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               title != null
//                   ? Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: AppConstants.pageMarginHorizontal,
//                       ),
//                       child: Text(
//                         title!,
//                         style: TextStyles.labelTopic,
//                       ),
//                     )
//                   : const SizedBox(
//                       height: AppConstants.pageMarginHorizontal / 2),
//               SizedBox(
//                 height: 365,
//                 child: PageView.builder(
//                   controller: PageController(
//                       viewportFraction:
//                           350 / MediaQuery.of(context).size.width * 0.9),
//                   itemCount: list.length,
//                   itemBuilder: (context, index) => Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 13,
//                         horizontal: AppConstants.pageMarginHorizontal / 3),
//                     child: PostItem(
//                       mini: true,
//                       post: post,
//                       onToggleFavorite: (id) {},
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )
//         : const SizedBox();
//   }
// }
