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
  rooms: rooms,
);
