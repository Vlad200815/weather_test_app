const String clearSky = "assets/weather_types/clear_sky.png";
const String cloudAndSun = "assets/weather_types/cloud_and_sun.png";
const String cloudy = "assets/weather_types/cloudy.png";
const String fog = "assets/weather_types/fog.png";
const String rain = "assets/weather_types/rain.png";
const String snow = "assets/weather_types/snow.png";
const String thunder = "assets/weather_types/thunder.png";

class DetermineWeatherCondition {
  void weatherConditionDetermine(int weatherCode) {
    if (weatherCode == 0) {
      weatherConditionImgPath = clearSky;
      weatherConditon = "Clear";
    } else if (weatherCode == 3) {
      weatherConditionImgPath = cloudy;
      weatherConditon = "Cloudy";
    } else if (weatherCode == 45 || weatherCode == 48) {
      weatherConditionImgPath = fog;
      weatherConditon = "Fog";
    } else if (weatherCode > 60 && weatherCode < 71) {
      weatherConditionImgPath = rain;
      weatherConditon = "Rain";
    } else if (weatherCode > 70 && weatherCode <= 86) {
      weatherConditionImgPath = snow;
      weatherConditon = "Snow";
    } else if (weatherCode >= 95 && weatherCode <= 99) {
      weatherConditionImgPath = thunder;
      weatherConditon = "Thunder";
    } else {
      weatherConditionImgPath = cloudAndSun;
      weatherConditon = "Cloudy";
    }
  }
}
