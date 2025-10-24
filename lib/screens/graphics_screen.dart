import 'package:flutter/material.dart';
import 'package:samatoll/screens/charts/temp_humidity_chart.dart';

class GraphiquesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
       SingleChildScrollView(
         child: Container(
          color: const Color.fromARGB(255, 234, 247, 234),
           child: Padding(
             padding: const EdgeInsets.only(top: 25.0),
             child: Column(
              //mainAxisAlignment: MainAxisAlignment,
                   //  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Graphe de predictions",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  
                ),),
                SizedBox(height: 30,),
             
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Temperature + Humidité",
                  // textAlign: TextAlign.left,
                  style:  TextStyle(
                    fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Colors.black87,
                  
                ),),
                TempHumidityChart()
                ],
                )
                // Icon(Icons.trending_up, size: 80, color: Colors.green[700]),
                // SizedBox(height: 16),
                // Text(
                //   'Graphiques Detailles',
                //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                // ),
                // SizedBox(height: 8),
                // Text(
                //   'Visualisations avancees',
                //   style: TextStyle(color: Colors.grey[600]),
               // ),
             
              ],
                   
                 ),
           ),
         ),
       );
  }
}
