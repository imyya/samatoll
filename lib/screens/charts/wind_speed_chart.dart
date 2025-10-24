import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samatoll/controller/weather_controller.dart';

class WindSpeedChart extends StatelessWidget {
  const WindSpeedChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherController>();

    return Obx(() {
      if (controller.forecast.value == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final forecasts = controller.next24Hours;
      if (forecasts.isEmpty) {
        return const Center(child: Text('Aucune donnée disponible'));
      }

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal.shade50, Colors.white],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.air, color: Colors.teal.shade700),
                const SizedBox(width: 8),
                Text(
                  'Vitesse du Vent (24h)',
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
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 2,
                    getDrawingHorizontalLine: (value) {
                      Color lineColor = Colors.grey.shade300;
                      if (value == 7) {
                        lineColor = Colors.red.shade300;
                      } else if (value == 5) {
                        lineColor = Colors.orange.shade300;
                      } else if (value == 3) {
                        lineColor = Colors.green.shade300;
                      }
                      return FlLine(
                        color: lineColor,
                        strokeWidth: value == 7 || value == 5 || value == 3 ? 2 : 1,
                        dashArray: value == 7 || value == 5 || value == 3 ? null : [5, 5],
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= forecasts.length) return const Text('');
                          final forecast = forecasts[value.toInt()];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              forecast.formattedTime,
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 45,
                        getTitlesWidget: (value, meta) {
                          String label = '${value.toInt()} m/s';
                          Color color = Colors.grey.shade700;
                          if (value == 7) {
                            label = '7 m/s ⚠️';
                            color = Colors.red.shade700;
                          } else if (value == 5) {
                            label = '5 m/s ⚡';
                            color = Colors.orange.shade700;
                          } else if (value == 3) {
                            label = '3 m/s ✓';
                            color = Colors.green.shade700;
                          }
                          return Text(
                            label,
                            style: TextStyle(
                              fontSize: 9,
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
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
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: (forecasts.length - 1).toDouble(),
                  minY: 0,
                  maxY: 12,
                  lineBarsData: [
                    LineChartBarData(
                      spots: forecasts.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value.wind.speed);
                      }).toList(),
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [Colors.teal.shade400, Colors.cyan.shade600],
                      ),
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          Color dotColor = Colors.green.shade700;
                          if (spot.y >= 7) {
                            dotColor = Colors.red.shade700;
                          } else if (spot.y >= 5) {
                            dotColor = Colors.orange.shade700;
                          }
                          return FlDotCirclePainter(
                            radius: 5,
                            color: dotColor,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.teal.shade400.withOpacity(0.3),
                            Colors.cyan.shade600.withOpacity(0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.teal.shade700.withOpacity(0.8),
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((spot) {
                          final forecast = forecasts[spot.x.toInt()];
                          return LineTooltipItem(
                            '${forecast.formattedTime}\n${spot.y.toStringAsFixed(1)} m/s',
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        }).toList();
                      },
                    ),
                    handleBuiltInTouches: true,
                    getTouchedSpotIndicator: (barData, spotIndices) {
                      return spotIndices.map((index) {
                        return TouchedSpotIndicatorData(
                          FlLine(
                            color: Colors.teal.shade900,
                            strokeWidth: 2,
                            dashArray: [5, 5],
                          ),
                          FlDotData(
                            getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                              radius: 8,
                              color: Colors.teal.shade700,
                              strokeWidth: 2,
                              strokeColor: Colors.white,
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}