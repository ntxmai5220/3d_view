import 'package:bk_3d_view/panorama/add_object/panaroma/Widgets/Image/DetailImage.dart';
import 'package:flutter/material.dart';


Future<int?> roomSheet (context, List<DetailImage> reactions) async{
  return await showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (builder) {
                return Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  height: 250,
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reactions',
                            ),
                            InkWell(
                              child: Icon(Icons.close),
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 5,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: reactions.length,
                            itemBuilder: (context, index) {
                      
                              return ListTile(
                                onTap: (){Navigator.pop(context, index);},
                                leading: CircleAvatar(
                                  child: reactions[index].getImage(),
                                ),
                                title: Text(
                                  reactions[index].name,
                                  style: TextStyle(
                                    color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                                trailing: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
              });
}