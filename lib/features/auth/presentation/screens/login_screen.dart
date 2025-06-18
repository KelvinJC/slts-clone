import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slts_enforcer_app/core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../providers/auth_notifier.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: authState.when(
        // 1) Data: user successfully logged in
        data: (User? user) {
          if (user == null) {
            // no user yet—show form
            return _buildForm(context, isLoading: false);
          }
          // on success, navigate (or show welcome)
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/dashboard');
          });
          return const Center(child: Text('Logging in…'));
        },
        // 2) Loading: overlay spinner
        loading: () => const Center(child: CircularProgressIndicator()),
        // 3) Error: show form + error message
        error: (Object error, _) {
          final message = (error is Failure)
              ? error.displayMessage
              : 'Something went wrong';
          return _buildForm(context, isLoading: false, errorMessage: message);
        },
      ),
    );
  }

  Widget _buildForm(
    BuildContext context, {
    required bool isLoading,
    String? errorMessage,
  }) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (errorMessage != null) ...[
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 12),
              ],
              TextField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _pwCtrl,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          ref
                              .read(authNotifierProvider.notifier)
                              .login(_emailCtrl.text.trim(), _pwCtrl.text);
                        },
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
        if (isLoading)
          const Opacity(
            opacity: 0.6,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isLoading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
