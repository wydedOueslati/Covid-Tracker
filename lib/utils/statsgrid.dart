import 'package:flutter/material.dart';

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
      height: MediaQuery.of(context).size.height * 0.40,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Cases', tcase!, Colors.orange),
                _buildStatCard('Deaths', deaths!, Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Recovered', recovered!, Colors.green),
                _buildStatCard('Critical', critical!, Colors.purple),
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
