import 'package:bk_3d_view/widgets/text/m_square.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget typeItem(String text) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 36,
            child: Center(child: Text(text)),
          ),
        );
    Widget buildFilterType() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [typeItem('Thue'), typeItem('Ban'), typeItem('Tat ca')],
        );

    Widget buildRangeInput(String label) => Flexible(
            child: Row(
              children: [
                Text(label),
                const SizedBox(width: 2,),
                Flexible(
                  child:TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder()
                  ),
                ),
                ),
                const SizedBox(width: 2)
              ],
            )
          
        );

    Widget buildFilterInRange(String title, Widget unit) => Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(title)],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildRangeInput("Từ: "),
                const Text("  "),
                buildRangeInput("Đến: "),
                unit,
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );

    Widget buildFilterAccept() => Center(
          child: ElevatedButton(child: const Text("Lọc"), onPressed: () {}),
        );
    return Drawer(
      width: size.width/2,
      child: ListView(
        children: [
          buildFilterType(),
          buildFilterInRange("Diện tích", const MSquare()),
          buildFilterInRange("Giá", const Text("  tỷ ")),
          buildFilterAccept()
        ],
      ),
    );
  }
}
