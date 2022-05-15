import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/values/app_constants.dart';

Room room = Room(id: '1', imgUrl: AppConstants.imgTemp);
List<String> rooms = ['abc', 'sef'];
Province province = Province(name: 'Tien Giang', id: 160);
District district = District(name: 'TP. My Tho', id: 10, provinceId: 160);
Ward ward = Ward(name: 'Phuong 1', code: '5', districtId: 10);
Post post = Post(
  id: 'a',
  area: 120,
  price: 900,
  isUsed: false,
  isHidden: false,
  isFavorite: false,
  desc: 'description',
  address: '55/12 duong Hung Vuong',
  province: province,
  district: district,
  ward: ward,
  rooms: [room],
);


const postData = {
  "province": {
                "id": 263,
                "name": "Yên Bái"
            },
            "district": {
                "id": 2039,
                "name": "Huyện Trấn Yên",
                "provinceId": 263
            },
            "ward": {
                "code": 130715,
                "name": "Xã Nga Quán",
                "districtId": 2039
            },
            "_id": "627f58577214269308fee932",
            "area": 1,
            "price": 1,
            "desc": "1",
            "address": "1",
            "isUsed": false,
            "isFavorite": false,
            "isHidden": false,
            "isRent": false,
            "rooms": [
                {
                    "_id": "627f585b7214269308fee936",
                    "name": "Phòng 0",
                    "thumbnail": [
                        {
                            "imgUrl": "http://res.cloudinary.com/dtnam302/image/upload/v1652512928/Thesis/627f58577214269308fee932/627f585b7214269308fee936/tc4djbgzthmaqj6johuj.png",
                            "publicId": "Thesis/627f58577214269308fee932/627f585b7214269308fee936/tc4djbgzthmaqj6johuj",
                            "_id": "627f58a17214269308fee944"
                        }
                    ]
                },
                {
                    "_id": "627f585b7214269308fee938",
                    "name": "Phòng 1",
                    "thumbnail": [
                        {
                            "imgUrl": "http://res.cloudinary.com/dtnam302/image/upload/v1652512931/Thesis/627f58577214269308fee932/627f585b7214269308fee938/oi8ymazdj71ade08rans.png",
                            "publicId": "Thesis/627f58577214269308fee932/627f585b7214269308fee938/oi8ymazdj71ade08rans",
                            "_id": "627f58a37214269308fee949"
                        }
                    ]
                }
            ],
            "favoriteCount": 0,
            "creatorId": "625bd0648e18145a85211945",
            "createdAt": "2022-05-14T07:20:55.075Z",
            "updatedAt": "2022-05-14T07:20:59.136Z",
            "__v": 1
};

const thumbnail =  {
                            "imgUrl": "http://res.cloudinary.com/dtnam302/image/upload/v1652512928/Thesis/627f58577214269308fee932/627f585b7214269308fee936/tc4djbgzthmaqj6johuj.png",
                            "publicId": "Thesis/627f58577214269308fee932/627f585b7214269308fee936/tc4djbgzthmaqj6johuj",
                            "_id": "627f58a17214269308fee944"
                        };
                    
List<Img> thumbnails = List.of([Img.fromJson(thumbnail),Img.fromJson(thumbnail),Img.fromJson(thumbnail),Img.fromJson(thumbnail)]);

Post postDetail = Post.fromJson(
  postData
);
