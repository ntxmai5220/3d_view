import 'package:bk_3d_view/values/app_colors.dart';
import 'package:flutter/material.dart';

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

enum PostType {
  sell,
  rent,
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

enum PanoramActionType {
  add,
  delete,
  none,
}

extension PanoramaActionTypeExtension on PanoramActionType {
  String get text {
    switch (this) {
      case PanoramActionType.add:
        return 'Thêm hotspot';
      case PanoramActionType.delete:
        return 'Xóa hotspot';
      default:
        return '';
    }
  }

  IconData? get icon {
    switch (this) {
      case PanoramActionType.add:
        return Icons.add_rounded;
      case PanoramActionType.delete:
        return Icons.delete_rounded;
      default:
        return Icons.close_rounded;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case PanoramActionType.add:
        return AppColors.black;
      case PanoramActionType.delete:
        return AppColors.red;
      default:
        return AppColors.white70;
    }
  }

  Color get iconColor {
    switch (this) {
      case PanoramActionType.none:
        return AppColors.black;
      default:
        return AppColors.white;
    }
  }
}
