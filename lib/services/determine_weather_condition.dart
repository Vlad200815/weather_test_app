import 'package:easy_localization/easy_localization.dart';

const String clearSky = "assets/weather_types/clear_sky.png";
const String cloudAndSun = "assets/weather_types/cloud_and_sun.png";
const String cloudy = "assets/weather_types/cloudy.png";
const String fog = "assets/weather_types/fog.png";
const String rain = "assets/weather_types/rain.png";
const String snow = "assets/weather_types/snow.png";
const String thunder = "assets/weather_types/thunder.png";

//TODO: try to make it as a service, use getIt and connect it to the blocs

class DetermineWeatherCondition {
  Map<String, String> weatherConditionDetermine({required int weatherCode}) {
    String weatherConditionImgPath = "";
    String weatherConditon = "";

    if (weatherCode == 0) {
      weatherConditionImgPath = clearSky;
      weatherConditon = "clear".tr();
    } else if (weatherCode == 3) {
      weatherConditionImgPath = cloudy;
      weatherConditon = "cloudy".tr();
    } else if (weatherCode == 45 || weatherCode == 48) {
      weatherConditionImgPath = fog;
      weatherConditon = "fog".tr();
    } else if (weatherCode > 60 && weatherCode < 71) {
      weatherConditionImgPath = rain;
      weatherConditon = "rain".tr();
    } else if (weatherCode > 70 && weatherCode <= 86) {
      weatherConditionImgPath = snow;
      weatherConditon = "snow".tr();
    } else if (weatherCode >= 95 && weatherCode <= 99) {
      weatherConditionImgPath = thunder;
      weatherConditon = "thunder".tr();
    } else {
      weatherConditionImgPath = cloudAndSun;
      weatherConditon = "cloudy".tr();
    }

    return {
      "weatherConditionImgPath": weatherConditionImgPath,
      "weatherConditon": weatherConditon,
    };
  }
}
