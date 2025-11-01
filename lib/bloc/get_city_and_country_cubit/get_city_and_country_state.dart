part of 'get_city_and_country_cubit.dart';

sealed class GetCityAndCountryState extends Equatable {
  const GetCityAndCountryState();

  @override
  List<Object> get props => [];
}

final class GetCityAndCountryInitial extends GetCityAndCountryState {}

final class GetCityAndCountryProgress extends GetCityAndCountryState {}

final class GetCityAndCountrySuccess extends GetCityAndCountryState {
  final double longitude;
  final double latitude;
  final String city;
  final String country;

  const GetCityAndCountrySuccess({
    required this.longitude,
    required this.latitude,
    required this.city,
    required this.country,
  });

  @override
  List<Object> get props => [longitude, latitude, city, country];
}

final class GetCityAndCountryFailure extends GetCityAndCountryState {
  final Object error;

  const GetCityAndCountryFailure({required this.error});

  @override
  List<Object> get props => [error];
}
