import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DropDownAddress<T> extends StatelessWidget {
  const DropDownAddress({
    Key? key,
    this.list,
    this.hint,
    this.onChange,
    this.display,
  }) : super(key: key);
  final List<T>? list;
  final String? hint;
  final Function(T?)? onChange;
  final int? display;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
                Radius.circular(AppConstants.borderRadius)),
            border: Border.all(color: AppColors.secondary)),
        child: DropdownButton<T>(
          elevation: 1,
          isExpanded: true,
          value: display != null ? list?.elementAt(display!) : null,
          underline: const SizedBox(),
          style: TextStyles.normalContent,
          menuMaxHeight: kMinInteractiveDimension * 10.5,
          borderRadius: const BorderRadius.all(
              Radius.circular(AppConstants.borderRadius)),
          items: list?.map<DropdownMenuItem<T>>((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                '${(e as Address).name}',
                style: TextStyles.normalLabel,
              ),
            );
          }).toList(),
          onChanged: onChange,
          hint: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child:
                  InputLabel(label: '$hint', isRequired: true, fontSize: 16)),
        ));
  }
}
