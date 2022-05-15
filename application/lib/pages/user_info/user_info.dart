import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:bk_3d_view/widgets/button/icon_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String userId;

  const UserInfo({Key? key, required this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    Widget buildDataInfo(String label, dynamic data) => Padding(
    child:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$label: ', style: TextStyles.normalLabel.copyWith(color: AppColors.black)),
            Expanded(child: Wrap(children:[Text(data.toString(), style: TextStyles.normalContent,)]))
          ],
      ),
    padding: const EdgeInsets.symmetric(horizontal: AppConstants.pageMarginHorizontal, vertical: 10),
  );
    
    return Scaffold(
      appBar: AppBar(title: const Text("Thông tin cá nhân",),
        backgroundColor: AppColors.primary,
        actions: [IconActionButton(icon: Icons.edit, iconColor: AppColors.white,)],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: CircleAvatar(
              child: Text("N", style: TextStyles.buttonText.copyWith(fontSize: 24),),
              radius: 40,
            ),
          ),
          buildDataInfo("Họ và tên: ", user.username ),
          buildDataInfo("Số điện thoại: ", "09xxxxxxx"),
          buildDataInfo("Email: ", "nam.doan302@hcmut.edu.vn"),
         
        
        
        ],
      ),
    );
  }


}