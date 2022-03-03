import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NewPost extends StatelessWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String label = 'Địa chỉ';
    TextEditingController controller = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            InputNewPost(
              controller: controller,
              label: label,
            ),
            const SizedBox(height: 15),
            InputNewPost(
              controller: controller,
              label: label,
              isRequired: true,
              suffixText: 'triệu',
            ),
            const SizedBox(height: 15),
            InputNewPost(
              controller: controller,
              label: label,
              suffixText: 'm2',
            ),
          ],
        ),
      ),
    );
  }
}
