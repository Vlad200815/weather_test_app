import 'package:firebase_analytics/firebase_analytics.dart';

final analytics = FirebaseAnalytics.instance;

class Analytics {
  Future<void> logSelectedPeriod(String period) async {
    await analytics.logEvent(
      name: "selected_period",
      parameters: {"period": period},
    );
  }

  Future<void> logSelectedCity(String cityName) async {
    await analytics.logEvent(
      name: 'selected_city',
      parameters: {'city': cityName},
    );
  }
}
