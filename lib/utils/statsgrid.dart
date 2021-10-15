import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsGrid extends StatelessWidget {
  String? tcase;
  String? deaths;
  String? recovered;
  String? critical;


  StatsGrid({
    Key? key,
    required this.tcase,
    this.deaths,
    this.recovered,
    this.critical,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
                decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(20),
                 boxShadow: [
                   BoxShadow(
                    color: Colors.grey,
                    blurRadius:6,
                    offset: Offset(4,4), // Shadow position
                   ),
                 ],
               ),
              width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.40,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Cases', NumberFormat.compact().format(double.parse(tcase!)), Colors.orange),
                _buildStatCard('Deaths',  NumberFormat.compact().format(double.parse(deaths!)), Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Recovered', NumberFormat.compact().format(double.parse(recovered!)), Colors.green),
                _buildStatCard('Critical',  NumberFormat.compact().format(double.parse(critical!)), Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
