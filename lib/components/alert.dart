import 'package:flutter/material.dart';
import 'package:besmart_traveler/components/text.dart';

Container alertDanger(String text) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.redAccent,
    ),
    child: Center(
      child: heading3(text),
    ),
  );
}

Container telegramAlert(String text) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.lightBlueAccent,
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
  );
}

class Alert{
  String type;
  String message;

  Alert({required this.type, required this.message});
}


Widget showAlerts(List<Alert> alerts){
  return Column(
    children: alerts.map<Widget>((alert) {
      if (alert.type == "danger") {
        return alertDanger(alert.message);
      };
      return Container();
    }
    ).toList()
  );
}