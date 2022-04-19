enum NewPostStep {
  data,
  image,
  thumbnail,
  hotspot,
}

enum HomeSection {
  banner,
  newest,
  recent,
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
    }
  }
}
