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
  "province": {"id": 263, "name": "Yên Bái"},
  "district": {"id": 2039, "name": "Huyện Trấn Yên", "provinceId": 263},
  "ward": {"code": 130715, "name": "Xã Nga Quán", "districtId": 2039},
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
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652512928/Thesis/627f58577214269308fee932/627f585b7214269308fee936/tc4djbgzthmaqj6johuj.png",
          "publicId":
              "Thesis/627f58577214269308fee932/627f585b7214269308fee936/tc4djbgzthmaqj6johuj",
          "_id": "627f58a17214269308fee944"
        }
      ]
    },
    {
      "_id": "627f585b7214269308fee938",
      "name": "Phòng 1",
      "thumbnail": [
        {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652512931/Thesis/627f58577214269308fee932/627f585b7214269308fee938/oi8ymazdj71ade08rans.png",
          "publicId":
              "Thesis/627f58577214269308fee932/627f585b7214269308fee938/oi8ymazdj71ade08rans",
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

const thumbnail = {
  "imgUrl":
      "http://res.cloudinary.com/dtnam302/image/upload/v1652512928/Thesis/627f58577214269308fee932/627f585b7214269308fee936/tc4djbgzthmaqj6johuj.png",
  "publicId":
      "Thesis/627f58577214269308fee932/627f585b7214269308fee936/tc4djbgzthmaqj6johuj",
  "_id": "627f58a17214269308fee944"
};

List<dynamic> rawPosts =  [
  {
    "province": {"id": 262, "name": "Bình Định"},
    "district": {"id": 1770, "name": "Huyện Phù Cát", "provinceId": 262},
    "ward": {"code": 370610, "name": "Xã Cát Nhơn", "districtId": 1770},
    "_id": "6280ce803a8880eb07e58fb6",
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
        "_id": "6280ce843a8880eb07e58fba",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652608641/Thesis/6280ce803a8880eb07e58fb6/jajrx4bxcskdaa0fs2wj.jpg"
      },
      {
        "_id": "6280ce843a8880eb07e58fbc",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652608644/Thesis/6280ce803a8880eb07e58fb6/hbirh6ar1d6i6ymnzmb6.jpg"
      }
    ],
    "favoriteCount": 0,
    "creatorId": "625bd0648e18145a85211945",
    "createdAt": "2022-05-15T09:57:20.158Z",
    "updatedAt": "2022-05-15T09:57:24.650Z",
    "__v": 1
  },
  {
    "province": {"id": 202, "name": "Hồ Chí Minh"},
    "district": {"id": 1447, "name": "Quận 5", "provinceId": 202},
    "ward": {"code": 20505, "name": "Phường 5", "districtId": 1447},
    "_id": "6280cc753a8880eb07e58faa",
    "area": 1356,
    "price": 12000,
    "desc": "nha 2 tang",
    "address": "duong so 1",
    "isUsed": false,
    "isFavorite": false,
    "isHidden": false,
    "isRent": false,
    "rooms": [
      {
        "_id": "6280cc793a8880eb07e58fae",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652608119/Thesis/6280cc753a8880eb07e58faa/buqgzcbei2ad8hx0rsor.jpg"
      },
      {
        "_id": "6280cc793a8880eb07e58fb0",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652608121/Thesis/6280cc753a8880eb07e58faa/ldfotifxz3t7br64xrgk.jpg"
      }
    ],
    "favoriteCount": 0,
    "creatorId": "625bd0648e18145a85211945",
    "createdAt": "2022-05-15T09:48:37.651Z",
    "updatedAt": "2022-05-15T09:48:41.472Z",
    "__v": 1
  },
  {
    "province": {"id": 265, "name": "Điện Biên"},
    "district": {"id": 1979, "name": "Huyện Mường Nhé", "provinceId": 265},
    "ward": {"code": 620804, "name": "Xã Mường Nhé", "districtId": 1979},
    "_id": "6280cb0c3a8880eb07e58f9c",
    "area": 200,
    "price": 20000,
    "desc": "nha 3 tang",
    "address": "12a/123",
    "isUsed": false,
    "isFavorite": false,
    "isHidden": false,
    "isRent": false,
    "rooms": [
      {
        "_id": "6280cb133a8880eb07e58fa0",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652607758/Thesis/6280cb0c3a8880eb07e58f9c/f6y5b13zawanky2s0ve8.jpg"
      },
      {
        "_id": "6280cb133a8880eb07e58fa2",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652607760/Thesis/6280cb0c3a8880eb07e58f9c/tl8ozz4h9e2kuvelmurs.jpg"
      },
      {
        "_id": "6280cb133a8880eb07e58fa4",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652607762/Thesis/6280cb0c3a8880eb07e58f9c/ckbdwa1bz1e28mwrwbl5.jpg"
      }
    ],
    "favoriteCount": 0,
    "creatorId": "625bd0648e18145a85211945",
    "createdAt": "2022-05-15T09:42:36.777Z",
    "updatedAt": "2022-05-15T09:42:43.394Z",
    "__v": 1
  },
  {
    "province": {"id": 267, "name": "Hòa Bình"},
    "district": {"id": 2146, "name": "Huyện Kim Bôi", "provinceId": 267},
    "ward": {"code": 230826, "name": "Xã Tú Sơn", "districtId": 2146},
    "_id": "6280c8573a8880eb07e58f86",
    "area": 200,
    "price": 10000,
    "desc": "can ho 3 phong ngu",
    "address": "12d/f",
    "isUsed": false,
    "isFavorite": false,
    "isHidden": false,
    "isRent": false,
    "rooms": [
      {
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652607374/Thesis/6280c8573a8880eb07e58f86/6280c85b3a8880eb07e58f8a/tegmhbtlrfmqcftvy7gd.png",
          "publicId":
              "Thesis/6280c8573a8880eb07e58f86/6280c85b3a8880eb07e58f8a/tegmhbtlrfmqcftvy7gd"
        },
        "_id": "6280c85b3a8880eb07e58f8a",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652607065/Thesis/6280c8573a8880eb07e58f86/imvi4d4vo97nua7p7pwk.jpg"
      },
      {
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652607377/Thesis/6280c8573a8880eb07e58f86/6280c85b3a8880eb07e58f8c/zqjqkf78p0mgkn4idswz.png",
          "publicId":
              "Thesis/6280c8573a8880eb07e58f86/6280c85b3a8880eb07e58f8c/zqjqkf78p0mgkn4idswz"
        },
        "_id": "6280c85b3a8880eb07e58f8c",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652607067/Thesis/6280c8573a8880eb07e58f86/yntya8fsfhqnz4r6pcj0.jpg"
      }
    ],
    "favoriteCount": 0,
    "creatorId": "625bd0648e18145a85211945",
    "createdAt": "2022-05-15T09:31:03.867Z",
    "updatedAt": "2022-05-15T09:31:07.992Z",
    "__v": 1
  },
  {
    "province": {"id": 264, "name": "Lai Châu"},
    "district": {"id": 2006, "name": "Huyện Sìn Hồ", "provinceId": 264},
    "ward": {"code": 70415, "name": "Xã Pa Tần", "districtId": 2006},
    "_id": "6280c7863a8880eb07e58f6f",
    "area": 200,
    "price": 1000,
    "desc": "can ho cao cap",
    "address": "123",
    "isUsed": false,
    "isFavorite": false,
    "isHidden": false,
    "isRent": false,
    "rooms": [
      {
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652606890/Thesis/6280c7863a8880eb07e58f6f/6280c78b3a8880eb07e58f74/hkvyyuo3vbjp6eacva1p.png",
          "publicId":
              "Thesis/6280c7863a8880eb07e58f6f/6280c78b3a8880eb07e58f74/hkvyyuo3vbjp6eacva1p"
        },
        "_id": "6280c78b3a8880eb07e58f74",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652606856/Thesis/6280c7863a8880eb07e58f6f/fjrf4sml5aweh9ozpuwc.jpg"
      },
      {
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652606893/Thesis/6280c7863a8880eb07e58f6f/6280c78b3a8880eb07e58f76/f0ldb3drfcqwdo4uybmw.png",
          "publicId":
              "Thesis/6280c7863a8880eb07e58f6f/6280c78b3a8880eb07e58f76/f0ldb3drfcqwdo4uybmw"
        },
        "_id": "6280c78b3a8880eb07e58f76",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652606859/Thesis/6280c7863a8880eb07e58f6f/tfcztcjz1hijmmzqkhq7.jpg"
      }
    ],
    "favoriteCount": 0,
    "creatorId": "625bd0648e18145a85211945",
    "createdAt": "2022-05-15T09:27:34.754Z",
    "updatedAt": "2022-05-15T09:27:39.806Z",
    "__v": 1
  },
  {
    "province": {"id": 35, "name": "TP HCM"},
    "district": {"id": 80, "name": "Thu Duc", "provinceId": 35},
    "ward": {"code": 77, "name": "Phuong 9", "districtId": 80},
    "_id": "6280c172c636e6e67f609de9",
    "area": 357,
    "price": 123,
    "desc": "cawn ho so 1",
    "address": "saacvd",
    "isUsed": false,
    "isFavorite": false,
    "isHidden": false,
    "isRent": false,
    "rooms": [
      {
        "_id": "6280c175c636e6e67f609dee",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652605300/Thesis/6280c172c636e6e67f609de9/t4wp86pgslhmg1ilskt2.webp"
      }
    ],
    "favoriteCount": 0,
    "creatorId": "625bd0648e18145a85211945",
    "createdAt": "2022-05-15T09:01:39.016Z",
    "updatedAt": "2022-05-15T09:01:41.198Z",
    "__v": 1
  },
  {
    "province": {"id": 263, "name": "Yên Bái"},
    "district": {"id": 2039, "name": "Huyện Trấn Yên", "provinceId": 263},
    "ward": {"code": 130715, "name": "Xã Nga Quán", "districtId": 2039},
    "_id": "6280ba3fdff11a1d84d75e9f",
    "area": 140,
    "price": 2750,
    "desc": "1 tret 1 lau",
    "address": "24a",
    "isUsed": false,
    "isFavorite": false,
    "isHidden": false,
    "isRent": false,
    "rooms": [
      {
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652603623/Thesis/6280ba3fdff11a1d84d75e9f/6280ba43dff11a1d84d75ea4/vsnjt5e0asq4pzobdn4a.png",
          "publicId":
              "Thesis/6280ba3fdff11a1d84d75e9f/6280ba43dff11a1d84d75ea4/vsnjt5e0asq4pzobdn4a"
        },
        "_id": "6280ba43dff11a1d84d75ea4",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652603457/Thesis/6280ba3fdff11a1d84d75e9f/ian5ojtsshnpq3k26ybk.jpg"
      },
      {
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652603626/Thesis/6280ba3fdff11a1d84d75e9f/6280ba43dff11a1d84d75ea6/smdetrj3hevx3ekany1y.png",
          "publicId":
              "Thesis/6280ba3fdff11a1d84d75e9f/6280ba43dff11a1d84d75ea6/smdetrj3hevx3ekany1y"
        },
        "_id": "6280ba43dff11a1d84d75ea6",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652603459/Thesis/6280ba3fdff11a1d84d75e9f/v9hpbl4vr6kavm9h0tyf.jpg"
      }
    ],
    "favoriteCount": 0,
    "creatorId": "625bd0648e18145a85211945",
    "createdAt": "2022-05-15T08:30:55.113Z",
    "updatedAt": "2022-05-15T08:30:59.808Z",
    "__v": 1
  },
  {
    "province": {"id": 202, "name": "Hồ Chí Minh"},
    "district": {"id": 1442, "name": "Quận 1", "provinceId": 202},
    "ward": {"code": 20106, "name": "Phường Đa Kao", "districtId": 1442},
    "_id": "6280ae35ffea6bfa096bcf17",
    "area": 150,
    "price": 2500,
    "desc": "nha mat tien",
    "address": "125 Mac Dinh Chi",
    "isUsed": false,
    "isFavorite": false,
    "isHidden": false,
    "isRent": false,
    "rooms": [
      {
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652600471/Thesis/6280ae35ffea6bfa096bcf17/6280ae3bffea6bfa096bcf1c/mohlkw7g3xohr7fppnas.png",
          "publicId":
              "Thesis/6280ae35ffea6bfa096bcf17/6280ae3bffea6bfa096bcf1c/mohlkw7g3xohr7fppnas"
        },
        "_id": "6280ae3bffea6bfa096bcf1c",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652600375/Thesis/6280ae35ffea6bfa096bcf17/un6s3kdqrvwnbhsc8mzt.jpg"
      },
      {
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652600475/Thesis/6280ae35ffea6bfa096bcf17/6280ae3bffea6bfa096bcf1e/dhc8cdwtb0sq5k1dyaua.png",
          "publicId":
              "Thesis/6280ae35ffea6bfa096bcf17/6280ae3bffea6bfa096bcf1e/dhc8cdwtb0sq5k1dyaua"
        },
        "_id": "6280ae3bffea6bfa096bcf1e",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652600377/Thesis/6280ae35ffea6bfa096bcf17/qv9wxsrpifkaikdhizqp.jpg"
      },
      {
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652600478/Thesis/6280ae35ffea6bfa096bcf17/6280ae3bffea6bfa096bcf20/y62pjtyhqttfotonnbwd.png",
          "publicId":
              "Thesis/6280ae35ffea6bfa096bcf17/6280ae3bffea6bfa096bcf20/y62pjtyhqttfotonnbwd"
        },
        "_id": "6280ae3bffea6bfa096bcf20",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652600379/Thesis/6280ae35ffea6bfa096bcf17/bwbe9nerxd5kexyhxgtk.jpg"
      }
    ],
    "favoriteCount": 0,
    "creatorId": "625bd0648e18145a85211945",
    "createdAt": "2022-05-15T07:39:33.210Z",
    "updatedAt": "2022-05-15T07:39:39.663Z",
    "__v": 1
  },
  {
    "province": {"id": 202, "name": "Hồ Chí Minh"},
    "district": {"id": 1460, "name": "Huyện Củ Chi", "provinceId": 202},
    "ward": {"code": 22118, "name": "Xã Thái Mỹ", "districtId": 1460},
    "_id": "6280a839478fad4a05a8965f",
    "area": 200,
    "price": 12000,
    "desc": "nha moi 2 phong ngu, 1 tret 1 lau",
    "address": "210b duong so 1",
    "isUsed": false,
    "isFavorite": false,
    "isHidden": false,
    "isRent": false,
    "rooms": [
      {
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652598920/Thesis/6280a839478fad4a05a8965f/6280a83e478fad4a05a89663/vqht2gqioo3qwagqtecz.png",
          "publicId":
              "Thesis/6280a839478fad4a05a8965f/6280a83e478fad4a05a89663/vqht2gqioo3qwagqtecz"
        },
        "_id": "6280a83e478fad4a05a89663",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652598843/Thesis/6280a839478fad4a05a8965f/octe1hwjonj6pwsyewkl.jpg"
      },
      {
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652598927/Thesis/6280a839478fad4a05a8965f/6280a83e478fad4a05a89665/qalxgdqd30hsw9ef2mts.png",
          "publicId":
              "Thesis/6280a839478fad4a05a8965f/6280a83e478fad4a05a89665/qalxgdqd30hsw9ef2mts"
        },
        "_id": "6280a83e478fad4a05a89665",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652598845/Thesis/6280a839478fad4a05a8965f/adiaizuznf8pb0pqi07q.jpg"
      }
    ],
    "favoriteCount": 0,
    "creatorId": "625bd0648e18145a85211945",
    "createdAt": "2022-05-15T07:14:01.981Z",
    "updatedAt": "2022-05-15T07:14:06.427Z",
    "__v": 1
  },
  {
    "province": {"id": 262, "name": "Bình Định"},
    "district": {"id": 1886, "name": "Huyện An Lão", "provinceId": 262},
    "ward": {"code": 370204, "name": "Xã An Hưng", "districtId": 1886},
    "_id": "62805845b0b0c32105430f3e",
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
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652578466/Thesis/62805845b0b0c32105430f3e/6280584ab0b0c32105430f43/vlxeecfxcizwksrwldja.png",
          "publicId":
              "Thesis/62805845b0b0c32105430f3e/6280584ab0b0c32105430f43/vlxeecfxcizwksrwldja"
        },
        "_id": "6280584ab0b0c32105430f43",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652578375/Thesis/62805845b0b0c32105430f3e/ciivqsjwscy0cvxwacmu.jpg"
      },
      {
        "mainThumbnail": {
          "imgUrl":
              "http://res.cloudinary.com/dtnam302/image/upload/v1652578470/Thesis/62805845b0b0c32105430f3e/6280584ab0b0c32105430f45/kqxkzzyggx9zvdpuallf.png",
          "publicId":
              "Thesis/62805845b0b0c32105430f3e/6280584ab0b0c32105430f45/kqxkzzyggx9zvdpuallf"
        },
        "_id": "6280584ab0b0c32105430f45",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652578377/Thesis/62805845b0b0c32105430f3e/wciiwzbawjsrytzg1iop.jpg"
      }
    ],
    "favoriteCount": 0,
    "creatorId": "625bd0648e18145a85211945",
    "createdAt": "2022-05-15T01:32:54.017Z",
    "updatedAt": "2022-05-15T01:32:58.211Z",
    "__v": 1
  }
];
List<Post> posts = rawPosts.map((post) => Post.fromJson(post)).toList();



List<Img> thumbnails = List.of([
  Img.fromJson(thumbnail),
  Img.fromJson(thumbnail),
  Img.fromJson(thumbnail),
  Img.fromJson(thumbnail)
]);

const user = {
  "_id": "625bd0648e18145a85211945",
  "username": "nam",
  "email": "nam@gmail.com",
  "isAdmin": false,
  "posts": [
    "625bd1c1fa9050c1dc04fd41",
    "625bd1c3fa9050c1dc04fd46",
    "6280ce803a8880eb07e58fb6"
  ],
  "createdAt": "2022-04-17T08:31:32.513Z",
  "updatedAt": "2022-05-15T09:57:20.218Z",
  "__v": 236,
  "follows": [
    "627e39ee5e5f54414032d654",
    "627e39ee5e5f54414032d654",
    "627e39ee5e5f54414032d654",
    "627e39ee5e5f54414032d654"
  ]
};

Post postDetail = Post.fromJson(postData);

List<dynamic> bannerRaw = [
            {
                "title": "Rever",
                "webUrl": "https://rever.vn/",
                "imgUrl": "https://res.cloudinary.com/dtnam302/image/upload/v1652590903/samples/photo-1582407947304-fd86f028f716_cj8hcc.jpg",
                "content": "Lựa chọn căn nhà ưng ý của bạn"
            },
            {
                "title": "VN Express",
                "webUrl": "https://vnexpress.net/kinh-doanh/bat-dong-san",
                "imgUrl": "https://res.cloudinary.com/dtnam302/image/upload/v1652591016/samples/22838-perspectives-in-todays-real-estate-market_gettyimages-1205029788_1380x800-2_s6zbcz.jpg",
                "content": "Thông tin bất động sản cập nhật mỗi ngày"
            },
            {
                "title": "Bách Khoa",
                "webUrl": "http://www.aao.hcmut.edu.vn/",
                "imgUrl": "https://chamsockhachang.com/wp-content/uploads/truong-dai-hoc-bach-khoa-tp.-ho-chi-minh.jpg",
                "content": "Giáo dục khai phóng, tiên phong trong chất lượng, sáng tạo và hội nhập"
            }
        ];
