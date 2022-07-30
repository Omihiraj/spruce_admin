class LocationAdd {
  LocationAdd({
    required this.locationName,
    required this.altitude,
    required this.latitude,
    required this.price,
  });
  String locationName;
  String altitude;
  String latitude;
  String price;

  static LocationAdd fromJson(Map<String, dynamic> json) => LocationAdd(
        locationName: json["location-name"],
        altitude: json["img"],
        latitude: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "location-name": locationName,
        "img": altitude,
        "name": latitude,
        "price": price,
      };
}
