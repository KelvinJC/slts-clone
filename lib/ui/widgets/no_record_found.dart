import 'package:flutter/material.dart';
import 'package:slts_enforcer_app/ui/utils/responsive.dart';

class NoRecordFound extends StatelessWidget {
  final String title;
  final double sepearatorHeight;
  final String subtitle;

  const NoRecordFound({
    super.key,
    this.title = 'No record found',
    this.sepearatorHeight = 3,
    this.subtitle = 'Once there is a record, we would\nupdate it here...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: context.hp(sepearatorHeight)),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
