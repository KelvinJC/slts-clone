import 'package:flutter/material.dart';

class HomeCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const HomeCardWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(title, style: Theme.of(context).textTheme.labelSmall),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
