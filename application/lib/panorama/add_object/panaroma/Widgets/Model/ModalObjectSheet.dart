
import 'package:bk_3d_view/panorama/add_object/panaroma/Widgets/Image/DetailImage.dart';
import 'package:flutter/material.dart';


List<String> objectImagePath = ["assets/objects/chair/chair.jpg", "assets/objects/table/table.jpg","assets/objects/shelf/Shelving_origin.jpg"];
List<String> objectPath = ["assets/objects/chair/chair.obj", "assets/objects/table/table.obj","assets/objects/shelf/Shelving_origin.obj"];
List<String> getImageObjectPath(){
  return objectImagePath;
}

List<DetailImage> convertImagePathtoImage( List<String> imagePath){
  List<DetailImage> imageObjects =  imagePath.map((e) => 
    DetailImage(name: e,imageLink: e)
  ).toList();
  return imageObjects;
}

String convertImageObjtoObjPath(String imageObj){
  int imageIndex = objectPath.indexOf(imageObj);
  

  return objectPath[imageIndex];
}

String getFileName(String path){
  return path.split("/").last.split(".").first;
}

Future<String?> ModalObjectSheet (context) async{
  List<String> imageObjectPaths = getImageObjectPath();
  List<DetailImage> imageObjectImages = convertImagePathtoImage(imageObjectPaths);
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
                              // style: AppStyles.fillStyle,
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
                            itemCount: imageObjectImages.length,
                            itemBuilder: (context, index) {
                      
                              return ListTile(
                                onTap: (){Navigator.pop(context, objectPath[index]);},
                                leading: CircleAvatar(
                                  child: imageObjectImages[index].getImage(),
                                ),
                                title: Text(
                                  getFileName(imageObjectImages[index].name),
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