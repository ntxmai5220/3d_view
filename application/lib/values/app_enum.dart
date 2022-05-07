import 'package:bk_3d_view/values/app_colors.dart';
import 'package:flutter/cupertino.dart';

enum NewPostStep {
  data,
  image,
  thumbnail,
  hotspot,
  remove,
}

enum HomeSection {
  banner,
  newest,
  recent,
}

enum DialogType {
  notification,
  warning,
}

extension DialogTypeExtension on DialogType {
  Color get color {
    switch (this) {
      case DialogType.notification:
        return AppColors.primary;
      case DialogType.warning:
        return AppColors.red;
    }
  }
}

extension NewPostStepExtension on NewPostStep {
  String get instruction {
    switch (this) {
      case NewPostStep.data:
        return 'Nhập thông tin';
      case NewPostStep.image:
        return 'Chụp ảnh panoram';
      case NewPostStep.thumbnail:
        return 'Chọn thumbnail';
      case NewPostStep.hotspot:
        return 'Tạo chuyển cảnh và chú thích';
      case NewPostStep.remove:
        return 'Xóa vật thể';
    }
  }
}
