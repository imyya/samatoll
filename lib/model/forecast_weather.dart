// models/weather_forecast.dart
import 'weather.dart'; 

class WeatherForecast {
  final String cod;
  final int message;
  final int cnt;
  final List<ForecastItem> list;
  final City? city;

  WeatherForecast({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    this.city,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      cod: json['cod'].toString(),
      message: json['message'] ?? 0,
      cnt: json['cnt'] ?? 0,
      list: (json['list'] as List?)
              ?.map((item) => ForecastItem.fromJson(item))
              .toList() ??
          [],
      city: json['city'] != null ? City.fromJson(json['city']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list.map((item) => item.toJson()).toList(),
      'city': city?.toJson(),
    };
  }
}

class ForecastItem {
  final int dt;
  final MainWeather main; // Réutilisé depuis weather.dart
  final List<WeatherCondition> weather; // Réutilisé depuis weather.dart
  final Clouds clouds; // Réutilisé depuis weather.dart
  final Wind wind; // Réutilisé depuis weather.dart
  final int visibility;
  final double pop;
  final Rain? rain;
  final Sys sys;
  final String dtTxt;

  ForecastItem({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    this.rain,
    required this.sys,
    required this.dtTxt,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      dt: json['dt'] ?? 0,
      main: MainWeather.fromJson(json['main'] ?? {}),
      weather: (json['weather'] as List?)
              ?.map((item) => WeatherCondition.fromJson(item))
              .toList() ??
          [],
      clouds: Clouds.fromJson(json['clouds'] ?? {}),
      wind: Wind.fromJson(json['wind'] ?? {}),
      visibility: json['visibility'] ?? 0,
      pop: (json['pop'] ?? 0).toDouble(),
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      sys: Sys.fromJson(json['sys'] ?? {}),
      dtTxt: json['dt_txt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'main': main.toJson(),
      'weather': weather.map((item) => item.toJson()).toList(),
      'clouds': clouds.toJson(),
      'wind': wind.toJson(),
      'visibility': visibility,
      'pop': pop,
      'rain': rain?.toJson(),
      'sys': sys.toJson(),
      'dt_txt': dtTxt,
    };
  }

  // Helper pour obtenir la date
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(dt * 1000);

  // Helper pour l'heure formatée
  String get formattedTime {
    final time = dateTime;
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  // Helper pour la date formatée
  String get formattedDate {
    final date = dateTime;
    const months = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun',
      'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    return '${date.day} ${months[date.month - 1]}';
  }

  // Helper pour la date courte (juste jour)
  String get dayName {
    final date = dateTime;
    const days = ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'];
    return days[date.weekday % 7];
  }
}

// Classe Rain spécifique au forecast (n'existe pas dans weather.dart)
class Rain {
  final double? threeHour;

  Rain({this.threeHour});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      threeHour: json['3h'] != null ? (json['3h'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (threeHour != null) '3h': threeHour,
    };
  }
}

// Classe Sys spécifique au forecast (différente de SystemInfo)
class Sys {
  final String pod;

  Sys({required this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(pod: json['pod'] ?? '');
  }

  Map<String, dynamic> toJson() => {'pod': pod};

  // Helper pour savoir si c'est le jour
  bool get isDay => pod == 'd';
}

// Classe City pour les infos de localisation
class City {
  final int id;
  final String name;
  final Coordinates coord; // Réutilisé depuis weather.dart
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      coord: Coordinates.fromJson(json['coord'] ?? {}),
      country: json['country'] ?? '',
      population: json['population'] ?? 0,
      timezone: json['timezone'] ?? 0,
      sunrise: json['sunrise'] ?? 0,
      sunset: json['sunset'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coord': coord.toJson(),
      'country': country,
      'population': population,
      'timezone': timezone,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}

// Extensions utiles pour weather.dart
extension MainWeatherExtension on MainWeather {
  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity,
      'sea_level': seaLevel,
      'grnd_level': groundLevel,
    };
  }
}

extension WeatherConditionExtension on WeatherCondition {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  // Helper pour l'URL de l'icône
  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
}

extension WindExtension on Wind {
  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
    };
  }

  // Helper pour la direction du vent en texte
  String get direction {
    if (deg >= 337.5 || deg < 22.5) return 'N';
    if (deg >= 22.5 && deg < 67.5) return 'NE';
    if (deg >= 67.5 && deg < 112.5) return 'E';
    if (deg >= 112.5 && deg < 157.5) return 'SE';
    if (deg >= 157.5 && deg < 202.5) return 'S';
    if (deg >= 202.5 && deg < 247.5) return 'SO';
    if (deg >= 247.5 && deg < 292.5) return 'O';
    return 'NO';
  }

  // Niveau de danger pour pulvérisation
  String get sprayingSafety {
    if (speed < 3) return 'Idéal';
    if (speed < 5) return 'Bon';
    if (speed < 7) return 'Moyen';
    return 'Déconseillé';
  }
}

extension CloudsExtension on Clouds {
  Map<String, dynamic> toJson() => {'all': all};
}

extension CoordinatesExtension on Coordinates {
  Map<String, dynamic> toJson() => {'lat': lat, 'lon': lon};
}