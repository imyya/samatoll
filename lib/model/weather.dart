import 'package:flutter/material.dart';

class Weather {
  final Coordinates coord;
  final List<WeatherCondition> weather;
  final String base;
  final MainWeather main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final SystemInfo sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  Weather({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      coord: Coordinates.fromJson(json['coord']),
      weather:
          (json['weather'] as List)
              .map((w) => WeatherCondition.fromJson(w))
              .toList(),
      base: json['base'],
      main: MainWeather.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: SystemInfo.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}

class Coordinates {
  final double lon;
  final double lat;

  Coordinates({required this.lon, required this.lat});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
    );
  }
}

class WeatherCondition {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class MainWeather {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int groundLevel;

  MainWeather({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.groundLevel,
  });

  factory MainWeather.fromJson(Map<String, dynamic> json) {
    return MainWeather(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      seaLevel: json['sea_level'],
      groundLevel: json['grnd_level'],
    );
  }
}

class Wind {
  final double speed;
  final int deg;

  Wind({required this.speed, required this.deg});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json['speed'].toDouble(), deg: json['deg']);
  }
}

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all']);
  }
}

class SystemInfo {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  SystemInfo({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory SystemInfo.fromJson(Map<String, dynamic> json) {
    return SystemInfo(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}



Map<String, IconData> weatherIcons = {
  'Clear': Icons.wb_sunny,
  'Clouds': Icons.cloud,
  'Rain': Icons.water_drop,
  'Drizzle': Icons.grain,
  'Thunderstorm': Icons.bolt,
  'Snow': Icons.ac_unit,
  'Mist': Icons.foggy,
  'Fog': Icons.foggy,
  'Haze': Icons.foggy,
  'Smoke': Icons.cloud,
  'Dust': Icons.cloud,
  'Sand': Icons.cloud,
  'Ash': Icons.cloud,
  'Squall': Icons.wind_power,
  'Tornado': Icons.warning,
};