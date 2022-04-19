import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DownloadDialog extends StatelessWidget {
  const DownloadDialog(
      {Key? key, this.title = 'Đang tải...', required this.percent})
      : super(key: key);
  final String title;
  final double percent;
  @override
  Widget build(BuildContext context) {
    return DialogWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.normalContent,
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(value: percent),
          const SizedBox(height: 15),
          Align(
              alignment: Alignment.centerRight,
              child: percent != 1
                  ? ActionButton(
                      label: '${(percent * 100).toStringAsFixed(0)}%',
                      labelStyle: TextStyles.tinyContent.copyWith(fontSize: 14),
                    )
                  : ActionButton(
                      label: 'Cài đặt',
                      labelColor: AppColors.primary,
                      onTap: () => Navigator.pop(context, true),
                    )
           
              ),
        ],
      ),
    );
  }
}
