import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/values/app_constants.dart';

Room room = Room(id: '1', imgUrl: AppConstants.imgTemp);
Province province = Province(name: 'Tien Giang');
District district = District(name: 'TP. My Tho');
Ward ward = Ward(name: 'Phuong 1');
Post post = Post(
  id: 'a',
  area: 120,
  price: 900,
  desc: 'description',
  address: '55/12 duong Hung Vuong',
  province: province,
  district: district,
  ward: ward,
  rooms: [room],
);
