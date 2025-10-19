import 'package:flutter/material.dart';

class GraphiquesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.trending_up, size: 80, color: Colors.green[700]),
          SizedBox(height: 16),
          Text(
            'Graphiques Detailles',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Visualisations avancees',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
