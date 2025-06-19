import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/auth_notifier.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // TODO: Build your login form using ui/widgets
      appBar: AppBar(title: Text('Login')),
      body: Center(child: Text('Login Form Here')),
    );
  }
}
