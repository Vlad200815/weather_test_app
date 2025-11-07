import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

final analytics = FirebaseAnalytics.instance;

class Analytics {
  Future<void> logSelectedPeriod(String period) async {
    analytics.setAnalyticsCollectionEnabled(true);
    await analytics.logEvent(name: "period", parameters: {"period": period});
    log("-----------------Period is here $period ---------------");
  }

  Future<void> logSelectedCity(String cityName) async {
    analytics.setAnalyticsCollectionEnabled(true);

    await analytics.logEvent(name: 'city', parameters: {'city': cityName});
    log("-----------------Location is here $cityName---------------");
  }
}
