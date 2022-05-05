class MapUtility {
  static Map<String, String?> getNonNull(Map<String, String?> map){
    return map..removeWhere((key, value) => value == null);
  }
}