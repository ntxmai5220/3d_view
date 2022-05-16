import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HotspotInforDialog extends StatelessWidget {
  const HotspotInforDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController content = TextEditingController();
    bool valid = true;
    const String error = 'Cần nhập đủ thông tin';
    return StatefulBuilder(builder: (context, setState) {
      return DialogWrap(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Thêm thông tin', style: TextStyles.normalContent),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.close,
                  size: 18,
                  color: AppColors.secondary,
                ),
              )
            ],
          ),
          const SizedBox(height: 7),
          !valid
              ? Text(error,
                  style: TextStyles.tinyLabel.copyWith(color: AppColors.red))
              : const SizedBox(),
          const SizedBox(height: 15),
          const Text('Tiêu đề', style: TextStyles.normalContent),
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: AppColors.lightSecondary45,
                borderRadius: BorderRadius.circular(5)),
            child: TextField(
              controller: title,
              style: TextStyles.normalContent
                  .copyWith(color: AppColors.darkSecondary),
              cursorColor: AppColors.darkSecondary,
              decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none
                  // filled: true,
                  // fillColor: AppColors.lightSecondary45,
                  ),
            ),
          ),
          const Text('Thông tin', style: TextStyles.normalContent),
          Container(
            height: 110,
            // padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                // color: AppColors.lightSecondary45,
                borderRadius: BorderRadius.circular(5)),
            child: TextField(
              controller: content,
              style: TextStyles.normalContent
                  .copyWith(color: AppColors.darkSecondary),
              maxLength: 100,
              minLines: 3,
              maxLines: 3,
              cursorColor: AppColors.darkSecondary,
              decoration: InputDecoration(
                  fillColor: AppColors.lightSecondary45,
                  filled: true,
                  isDense: true,
                  // contentPadding: EdgeInsets.all(0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(color: AppColors.lightSecondary45)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(color: AppColors.lightSecondary45)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(color: AppColors.lightSecondary45))
                  // filled: true,
                  // fillColor: AppColors.lightSecondary45,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          ActionButton(
            label: 'Lưu',
            labelColor: AppColors.primary,
            padding: 5,
            onTap: () {
              // if (onTapCancel != null) onTapCancel!();
              if (title.text.isNotEmpty && content.text.isNotEmpty) {
                Navigator.of(context).pop([title.text, content.text]);
              } else {
                setState(() {
                  valid = false;
                });
              }
            },
          ),
        ],
      ));
    });
  }
}
