class RestaurantData {
  int id;
  String name;
  String restaurantType;
  double? avgRating;
  String openTime;
  String closeTime;
  String phoneNumber;
  String userName;
  String streetName;
  String wardName;
  String townshipName;
  String cityName;
  String countryName;
  String latitude;
  String longitude;

  RestaurantData({
    required this.id,
    required this.name,
    required this.restaurantType,
    this.avgRating,
    required this.openTime,
    required this.closeTime,
    required this.phoneNumber,
    required this.userName,
    required this.streetName,
    required this.wardName,
    required this.townshipName,
    required this.cityName,
    required this.countryName,
    required this.latitude,
    required this.longitude,
  });

  /// Factory constructor to create a RestaurantData object from JSON
  factory RestaurantData.fromJson(Map<String, dynamic> json) {
    return RestaurantData(
      id: json['id'],
      name: json['name'],
      restaurantType: json['restaurant_type'],
      avgRating: json['avg_rating'] != null ? (json['avg_rating'] as num).toDouble() : null,
      openTime: json['open_time'],
      closeTime: json['close_time'],
      phoneNumber: json['phone_number'],
      userName: json['user_name'],
      streetName: json['Street_Name'],
      wardName: json['Ward_Name'],
      townshipName: json['TownShip_Name'],
      cityName: json['City_Name'],
      countryName: json['Country_Name'],
      latitude: json['Latitude'],
      longitude: json['Longitude'],
    );
  }

  /// Method to convert a RestaurantData object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'restaurant_type': restaurantType,
      'avg_rating': avgRating,
      'open_time': openTime,
      'close_time': closeTime,
      'phone_number': phoneNumber,
      'user_name': userName,
      'Street_Name': streetName,
      'Ward_Name': wardName,
      'TownShip_Name': townshipName,
      'City_Name': cityName,
      'Country_Name': countryName,
      'Latitude': latitude,
      'Longitude': longitude,
    };
  }
}
