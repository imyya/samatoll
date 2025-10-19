import 'package:flutter/material.dart';

class CulturesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cultures = [
    {
      'name': 'Mais',
      'area': 120,
      'stage': 'Croissance',
      'health': 'Bon',
      'color': Colors.orange,
    },
    {
      'name': 'Riz',
      'area': 95,
      'stage': 'Floraison',
      'health': 'Excellent',
      'color': Colors.green,
    },
    {
      'name': 'Mil',
      'area': 80,
      'stage': 'Mature',
      'health': 'Moyen',
      'color': Colors.blue,
    },
    {
      'name': 'Arachide',
      'area': 70,
      'stage': 'Semis',
      'health': 'Bon',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: cultures.length,
      itemBuilder: (context, index) {
        return _buildCultureCard(cultures[index]);
      },
    );
  }

  Widget _buildCultureCard(Map<String, dynamic> culture) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: culture['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.eco,
              color: culture['color'],
              size: 32,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  culture['name'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${culture['area']} hectares',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    _buildTag('Stage: ${culture['stage']}', Colors.blue),
                    _buildTag('Sante: ${culture['health']}', Colors.green),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color.withOpacity(0.85),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
