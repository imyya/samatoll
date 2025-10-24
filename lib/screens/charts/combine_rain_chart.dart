import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samatoll/controller/weather_controller.dart';

class CombinedRainChart extends StatelessWidget {
  const CombinedRainChart({Key? key}) : super(key: key);

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
            colors: [Colors.blue.shade50, Colors.white],
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
                Icon(Icons.water_drop, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  'Pluie et Probabilité (24h)',
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
              height: 300,
              child: Stack(
                children: [
                  // Bar chart for rainfall volume
                  BarChart(
                    BarChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 5,
                        getDrawingHorizontalLine: (value) {
                          Color lineColor = Colors.grey.shade300;
                          if (value == 5) {
                            lineColor = Colors.blue.shade300; // Significant rain threshold
                          }
                          return FlLine(
                            color: lineColor,
                            strokeWidth: value == 5 ? 2 : 1,
                            dashArray: value == 5 ? null : [5, 5],
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
                              String label = '${value.toInt()} mm';
                              Color color = Colors.grey.shade700;
                              if (value == 5) {
                                label = '5 mm 🌧️';
                                color = Colors.blue.shade700;
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
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false, // Right axis handled by LineChart
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minY: 0,
                      maxY: 15, // Adjusted for rainfall volume (mm)
                      barGroups: [
                        for (var i = 0; i < forecasts.length; i++)
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: forecasts[i].rain?.threeHour ?? 0,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.shade400,
                                    Colors.blue.shade700,
                                  ],
                                ),
                                width: 8,
                                borderRadius: BorderRadius.circular(4),
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: 15,
                                  color: Colors.grey.shade200.withOpacity(0.2),
                                ),
                              ),
                            ],
                          ),
                      ],
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.blue.shade700.withOpacity(0.8),
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final forecast = forecasts[group.x.toInt()];
                            return BarTooltipItem(
                              '${forecast.formattedTime}\n'
                              'Pluie: ${(forecast.rain?.threeHour ?? 0).toStringAsFixed(1)} mm',
                              TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Line chart for precipitation probability
                  LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: false, // Avoid duplicating grid
                        drawVerticalLine: false,
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 45,
                            getTitlesWidget: (value, meta) {
                              String label = '${value.toInt()} %';
                              Color color = Colors.grey.shade700;
                              if (value == 70) {
                                label = '70% ⚡';
                                color = Colors.purple.shade700;
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
                      ),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: (forecasts.length - 1).toDouble(),
                      minY: 0,
                      maxY: 100, // For probability (0-100%)
                      extraLinesData: ExtraLinesData(
                        horizontalLines: [
                          HorizontalLine(
                            y: 70,
                            color: Colors.purple.shade300,
                            strokeWidth: 2,
                            dashArray: null,
                          ),
                        ],
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: forecasts.asMap().entries.map((e) {
                            return FlSpot(e.key.toDouble(), e.value.pop * 100);
                          }).toList(),
                          isCurved: true,
                          gradient: LinearGradient(
                            colors: [Colors.purple.shade400, Colors.purple.shade700],
                          ),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              Color dotColor = Colors.purple.shade700;
                              if (spot.y >= 70) {
                                dotColor = Colors.purple.shade900;
                              }
                              return FlDotCirclePainter(
                                radius: 4,
                                color: dotColor,
                                strokeWidth: 1.5,
                                strokeColor: Colors.white,
                              );
                            },
                          ),
                        ),
                      ],
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          tooltipBgColor: Colors.purple.shade700.withOpacity(0.8),
                          getTooltipItems: (List<LineBarSpot> touchedSpots) {
                            return touchedSpots.map((spot) {
                              final forecast = forecasts[spot.x.toInt()];
                              return LineTooltipItem(
                                '${forecast.formattedTime}\n'
                                'Probabilité: ${(forecast.pop * 100).toStringAsFixed(0)}%',
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
                                color: Colors.purple.shade900,
                                strokeWidth: 2,
                                dashArray: [5, 5],
                              ),
                              FlDotData(
                                getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                  radius: 6,
                                  color: Colors.purple.shade700,
                                  strokeWidth: 1.5,
                                  strokeColor: Colors.white,
                                ),
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}