// 2. GRAPHIQUE COMBINÉ PLUIE (BARRES) + PROBABILITÉ (LIGNE)
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samatoll/controller/weather_controller.dart';
import 'package:samatoll/model/forecast_weather.dart';

class RainForecastChart extends StatelessWidget {
  const RainForecastChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherController>();

    return Obx(() {
      if (controller.forecast.value == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final List<ForecastItem> forecasts = controller.next5DaysAtNoon;
      if (forecasts.isEmpty) {
        return const Center(child: Text('Aucune donnée disponible'));
      }

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
         // color:Colors.white70,
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [Colors.blue.shade50, Colors.white],
          // ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.black.withOpacity(0.1),
            //   blurRadius: 10,
            //   offset: const Offset(0, 4),
            // ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.water_drop, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  'Prévisions de Pluie (5 jours)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final forecast = forecasts[group.x.toInt()];
                        return BarTooltipItem(
                          '${forecast.dayName}\n',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '${(forecast.pop * 100).toInt()}% pluie',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= forecasts.length) return const Text('');
                          final forecast = forecasts[value.toInt()];
                          return Column(
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                forecast.dayName,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                forecast.formattedDate.split(' ')[0],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}%',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.shade300,
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: forecasts.asMap().entries.map((e) {
                    final prob = e.value.pop * 100;
                    return BarChartGroupData(
                      x: e.key,
                      barRods: [
                        BarChartRodData(
                          toY: prob,
                          gradient: LinearGradient(
                            colors: prob > 70
                                ? [Colors.blue.shade700, Colors.blue.shade900]
                                : prob > 40
                                    ? [Colors.blue.shade400, Colors.blue.shade600]
                                    : [Colors.blue.shade200, Colors.blue.shade400],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          width: 35,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 100,
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildRainAdvice(forecasts),
          ],
        ),
      );
    });
  }

  Widget _buildRainAdvice(List<ForecastItem> forecasts) {
    final maxRainDay = forecasts.reduce((a, b) => a.pop > b.pop ? a : b);
    final hasHighRain = maxRainDay.pop > 0.6;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: hasHighRain ? Colors.blue.shade100 : Colors.green.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            hasHighRain ? Icons.umbrella : Icons.wb_sunny,
            color: hasHighRain ? Colors.blue.shade700 : Colors.green.shade700,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              hasHighRain
                  ? '⚠️ Forte probabilité de pluie ${maxRainDay.dayName}. Évitez les traitements.'
                  : '✅ Bonnes conditions pour les travaux aux champs.',
              style: TextStyle(
                fontSize: 12,
                color: hasHighRain ? Colors.blue.shade900 : Colors.green.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
