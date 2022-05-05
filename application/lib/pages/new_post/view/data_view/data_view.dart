import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/new_post/view/data_view/bloc/data_view_bloc.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataView extends StatelessWidget {
  const DataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // NewPostBloc bloc = context.read<NewPostBloc>();
    return BlocBuilder<DataViewBloc, DataViewState>(
      builder: (context, state) {
        DataViewBloc bloc = context.read<DataViewBloc>();
        return ListView(
          padding: const EdgeInsets.all(AppConstants.pageMarginHorizontal),
          children: [
            InputNewPost(
              controller: bloc.price,
              label: 'Giá',
              isRequired: true,
              inputNumber: true,
              suffixText: 'triệu',
            ),
            const SizedBox(height: 15),
            InputNewPost(
              controller: bloc.area,
              label: 'Diện tích',
              isRequired: true,
              inputNumber: true,
              suffixText: 'm2',
            ),
            const SizedBox(height: 15),
            InputNewPost(
              controller: bloc.address,
              label: 'Địa chỉ',
            ),
            // dropdown('Tỉnh', ),
            const SizedBox(height: 15),
            DropDownAddress<Province>(
              list: bloc.state.provinces,
              hint: 'Chọn tỉnh/thành phố',
              display: bloc.state.province,
              onChange: (p) {
                bloc.add(DataViewChangeAddressEvent<Province>(address: p!));
                debugPrint(p.toJson().toString());
              },
            ),
            const SizedBox(height: 15),
            DropDownAddress<District>(
              list: bloc.state.districts,
              hint: 'Chọn quận/huyện',
              display: bloc.state.district,
              onChange: (d) {
                bloc.add(DataViewChangeAddressEvent<District>(address: d!));
                debugPrint(d.toJson().toString());
              },
            ),
            const SizedBox(height: 15),
            DropDownAddress<Ward>(
              list: bloc.state.wards,
              hint: 'Chọn phường/xã',
              display: bloc.state.ward,
              onChange: (w) {
                bloc.add(DataViewChangeAddressEvent<Ward>(address: w!));
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: bloc.desc,
              style: TextStyles.normalContent,
              cursorColor: AppColors.primary,
              minLines: 4,
              maxLines: null,
              decoration: const InputDecoration(
                // labelText: label,
                label: InputLabel(label: 'Mô tả', isRequired: false),
                labelStyle: TextStyles.normalLabel,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                floatingLabelStyle: TextStyles.normalLabel,
                // suffixText: 'triệu',
                suffixStyle: TextStyles.normalContent,

                contentPadding: EdgeInsets.fromLTRB(15, 30, 5, 0),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondary),
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppConstants.borderRadius))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondary),
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppConstants.borderRadius))),
              ),
            ),
          ],
        );
      },
    );
  }
}
