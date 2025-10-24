// import 'package:samatoll/model/weather.dart';

// class ForecastItem {
//   final MainWeather main;
//   final Wind wind;
//   final Rain? rain;
//   final double pop;
//   final String dtTxt;

//   ForecastItem({
//     required this.main,
//     required this.wind,
//     this.rain,
//     required this.pop,
//     required this.dtTxt,
//   });

//   factory ForecastItem.fromJson(Map<String, dynamic> json) {
//     return ForecastItem(
//       main: Main.fromJson(json['main']),
//       wind: Wind.fromJson(json['wind']),
//       rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
//       pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
//       dtTxt: json['dt_txt'] as String,
//     );
//   }
// }