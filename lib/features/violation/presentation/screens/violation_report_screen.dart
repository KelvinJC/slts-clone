import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/features/violation/domain/entities/violation.dart';

class ViolationReportScreen extends StatelessWidget {
  final Violation violation;
  const ViolationReportScreen({super.key, required this.violation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Violation Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Offence: ${violation.offence}',
              style: TextStyle(fontSize: 18),
            ),
            Text('Zone: ${violation.zone}', style: TextStyle(fontSize: 18)),
            Text(
              'Date: ${violation.date.toLocal()}'.split(' ')[0],
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'First Name: ${violation.firstName}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Surname: ${violation.surname}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
