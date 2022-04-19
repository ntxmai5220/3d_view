import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EditImageDialog extends StatelessWidget {
  const EditImageDialog({
    Key? key,
    this.onTapDelete,
    this.onTapRename,
    this.name,
  }) : super(key: key);

  final String? name;
  final Function()? onTapDelete;
  final Function()? onTapRename;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: name);
    return DialogWrap(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tên phòng', style: TextStyles.normalContent),
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
        const SizedBox(height: 15),
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: AppColors.lightSecondary45,
              borderRadius: BorderRadius.circular(5)),
          child: TextField(
            controller: controller,
            style: TextStyles.normalContent
                .copyWith(color: AppColors.darkSecondary),
            cursorColor: AppColors.darkSecondary,
            decoration: const InputDecoration(
                prefixText: 'Phòng ',
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                border: InputBorder.none
                // filled: true,
                // fillColor: AppColors.lightSecondary45,
                ),
          ),
        ),
        const SizedBox(height: 15),
        ActionButton(
          label: 'Đổi tên',
          labelColor: AppColors.primary,
          padding: 5,
          onTap: () {
            // if (onTapCancel != null) onTapCancel!();
            Navigator.of(context).pop(controller.text);
          },
        ),
      ],
    ));
  }
}
