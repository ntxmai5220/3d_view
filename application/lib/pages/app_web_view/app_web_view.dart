import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatelessWidget {
  const AppWebView({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppBarTextTitle(
          title: url,
          color: AppColors.white,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: url,
              onPageStarted: (value) {
                ShowMyDialog.show(context, dialog: const LoadingDialog());
              },
              onPageFinished: (value) {
                Navigator.of(context).pop();
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
