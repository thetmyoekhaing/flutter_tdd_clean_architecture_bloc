class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = '2f40b6f112a43c4992273be8111a4edd';
  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
