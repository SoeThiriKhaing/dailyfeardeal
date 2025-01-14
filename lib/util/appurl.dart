class AppUrl {
  static var baseUrl = "http://api.dailyfairdeal.com/api";
  static var loginEndpoint = '${baseUrl}login';
  static var registerEndpoint = "${baseUrl}register";

  //Food Api
  static var getAllRestaurant = '${baseUrl}restaurant';
  static var getFavCuisines = '${baseUrl}favourite-cuisine';
  static var getFeatRestaurant = '${baseUrl}feature-restaurants';
  static var getOrderAgain = '${baseUrl}order-it-again';
  static var getPopularFood = '${baseUrl}popular-foods';
  static var getResTypes = '${baseUrl}restaurants-types';

  //Location Api

  static String getCountry = "${baseUrl}country";
  static String getDivision(String countryId) => '$baseUrl/state/$countryId';
  static String getCities(String divisionId) => '$baseUrl/city/$divisionId';
  static String getTownship(String cityId) => '$baseUrl/township/$cityId';
  static String getWard(String townshipId) => '$baseUrl/ward/$townshipId';
  static String getStreet(String wardId) => '$baseUrl/street/$wardId';
}
