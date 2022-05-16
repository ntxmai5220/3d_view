import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:bk_3d_view/widgets/app_bar/back_leading.dart';
import 'package:bk_3d_view/widgets/button/action_button.dart';
import 'package:bk_3d_view/widgets/button/icon_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Admin extends StatelessWidget {

  const Admin({Key? key}) : super(key: key);
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

  Widget buildNameCard(String name) => Padding(
            padding: const EdgeInsets.all(2),
            child: CircleAvatar(
              child: Text(name[0], style: TextStyles.buttonText.copyWith(fontSize: 15),),
              radius: 20,
            ),
          );

        
    Widget buildUserCard(String name) => Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: buildNameCard(name),
              title: Text(name),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ActionButton(label: "Xem chi tiết", labelColor: AppColors.primary,),
                const SizedBox(width: 8),
                ActionButton(label: "Xóa", labelColor: AppColors.red,),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Quản lý người dùng",),
        backgroundColor: AppColors.primary,
        leading: BackLeading(),
      ),
      body: ListView(
        children: [
          buildUserCard("Đoàn Thanh Nam"),
          buildUserCard("Nguyễn Công Minh"),
          buildUserCard("Nguyễn Thị Xuân Mai"),
          buildUserCard("Phan Lê Tuấn Anh"),
          buildUserCard("Nguyễn Thị Xuân Mai"),
          buildUserCard("Nguyễn Mai Hiền Trinh"),
          buildUserCard("Nguyễn Thị Anh Nhi"),
          
         
        
        
        ],
      ),
    );
  }


}