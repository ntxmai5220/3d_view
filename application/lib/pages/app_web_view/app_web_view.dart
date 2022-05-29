import 'dart:io';

import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {
  final String url;

  const AppWebView({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  var _isLoading = true;
  // // @override
  // // void initState() {
  // //   super.initState();
  // //   // Enable virtual display.
  // //   if (Platform.isAndroid) WebView.platform = AndroidWebView();
  // // }
  // @override
  // void initState() {
  //   if (Platform.isAndroid) {
  //     WebView.platform = SurfaceAndroidWebView();
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppBarTextTitle(
          title: widget.url,
          color: AppColors.white,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (value) {
                ShowMyDialog.show(context, dialog: const LoadingDialog());
              },
              onPageFinished: (value) {
                // setState(() {
                //   _isLoading = false;
                // });
              },
            ),
            // _isLoading
            //     ? const Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     : const SizedBox()
          ],
        ),
      ),
    );
  }
}

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter WebView'),
//       ),
//       body: const WebView(
//         initialUrl: 'https://flutter.dev',
//       ),
//     );
//   }
// }
