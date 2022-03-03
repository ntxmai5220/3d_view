import 'package:bk_3d_view/apis/apis.dart';

class NewPostRepository {
  NewPostRepository({ApiExecute? apiExecute})
      : _apiExecute = apiExecute ?? ApiExecute.address();
  final ApiExecute _apiExecute;
}
