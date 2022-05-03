class MapUtility {
  static Map<String, dynamic> getNonNull(Map<String, dynamic> map){
    return map..removeWhere((key, value) => value == null);
  }
}