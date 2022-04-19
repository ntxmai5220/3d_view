class Hotspot {
  Hotspot({
    this.title,
    this.latitude,
    this.longitude,
    this.type,
    this.currentRoom,
    this.nextRoom,
  });

  String? title;

  /// The initial latitude, in degrees, between -90 and 90.
  /// y
  double? latitude;

  /// The initial longitude, in degrees, between -180 and 180.
  /// x
  double? longitude;
  int? type;
  String? currentRoom;
  String? nextRoom;

  factory Hotspot.fromJson(Map<String, dynamic> json) {
    return Hotspot(
      title: json['title'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      type: json['type']?.toInt(),
      currentRoom: json['currentRoom'],
      nextRoom: json['nextRoom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'latitude': latitude,
      'longitude': longitude,
      'type': type,
      'currentRoom': currentRoom,
      'nextRoom': nextRoom,
    };
  }
}