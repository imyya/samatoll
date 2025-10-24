import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samatoll/controller/navigation_controller.dart';
import 'package:samatoll/controller/weather_controller.dart';
import 'package:samatoll/model/weather.dart';
import 'package:samatoll/screens/home_screen.dart';
import 'package:samatoll/widgets/my_map.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);
  final WeatherController _weatherController = Get.put(WeatherController());
  @override
  Widget build(BuildContext context) {
    return Obx(()
      => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header avec info utilisateur
              _buildUserHeader(),
              SizedBox(height: 20),
      
              // Stats cards
              _buildStatsCards(),
              SizedBox(height: 20),
      
              // Section meteo
              _buildWeatherSection(),
              SizedBox(height: 20),
      
              // Actions rapides
              _buildQuickActions(),
              SizedBox(height: 20),
      
              _buildMapSection(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[700]!, Colors.green[500]!],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Text(
              'AS',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bonjour, Amadou',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Richard-Toll, Senegal',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.wb_sunny, color: Colors.yellow[300], size: 32),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            '450 ha',
            'Surface Totale',
            Icons.landscape,
            Colors.blue,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('5', 'Cultures', Icons.eco, Colors.green),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            '${ _weatherController.weather.value?.main.temp.round()}°C',
            'Temperature',
            Icons.thermostat,
            Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 200,
      // width: 800,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MyMap(),
    );
  }

  Widget _buildWeatherSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meteo Aujourd\'hui',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildWeatherItem(Icons.water_drop,
              _weatherController.weather.value?.main.humidity !=null ? '${_weatherController.weather.value?.main.humidity}%':' ' , 'Humidite'),
              _buildWeatherItem( _weatherController.weather.value?.weather[0].main !=null ? weatherIcons[_weatherController.weather.value!.weather[0].main]?? Icons.cloud :Icons.cloud,  _weatherController.weather.value?.weather[0].main !=null ? '${_weatherController.weather.value!.weather[0].main}':' ', 'Météo'),
              _buildWeatherItem(Icons.air,  _weatherController.weather.value?.wind.speed !=null ? '${(_weatherController.weather.value!.wind.speed * 3.6).toStringAsFixed(1)} Km/h':' ', 'Vent'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue[600], size: 32),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions Rapides',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'Voir Graphiques',
                Icons.trending_up,
                Colors.blue,
                () => Get.find<NavigationController>().changePage(1),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                'Mes Cultures',
                Icons.eco,
                Colors.green,
                () => Get.find<NavigationController>().changePage(3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
