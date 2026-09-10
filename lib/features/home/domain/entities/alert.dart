import 'package:flutter/material.dart';

class Alert {
  final String id;
  final String title;
  final String timeAgo;
  final String severity;
  final Color severityColor;

  Alert({
    required this.id,
    required this.title,
    required this.timeAgo,
    required this.severity,
    required this.severityColor,
  });
}
