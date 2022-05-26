import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChooseRoomBS extends StatelessWidget {
  const ChooseRoomBS({
    Key? key,
    this.rooms = const [],

  }) : super(key: key);

  final List<Room>? rooms;


  @override
  Widget build(BuildContext context) {
    itemBuilder(BuildContext context, Room room) {
      return GestureDetector(
        onTap: () => Navigator.pop(context, room),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          child: Row(
            children: [
              NetImage(
                imageUrl: room.imgUrl ?? '',
                width: 150,
                height: 75,
                mini: true,
              ),
              const SizedBox(width: 20),
              Text(
                room.name ?? '',
                style: TextStyles.normalLabel.copyWith(color: AppColors.black),
              ),
            ],
          ),
        ),
      );
    }

    return BottomSheetWrap(
      child: Column(
        children: [
          const BottomSheetBar(
            title: 'Chọn phòng chuyển cảnh',
          ),
          const SizedBox(height: 10),
          ...rooms?.map((room) => itemBuilder(context, room)) ?? [],
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
