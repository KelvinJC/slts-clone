import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // Watch the AuthNotifier’s AsyncValue<User?>
    final authState = ref.watch(authNotifierProvider);

    // Derive a simple bool: are we currently loading?
    final isLoading = authState.isLoading;

    // You can also detect error or success:
    // final hasError = authState.hasError;
    // final user     = authState.value;

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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

                // Show error if any
                // ?authState.whenOrNull(
                //   error: (err, _) => Padding(
                //     padding: const EdgeInsets.only(bottom: 12),
                //     child: Text(
                //       err.toString(),
                //       style: const TextStyle(color: Colors.red),
                //     ),
                //   ),
                // ),

                // Login button, disabled when loading
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            // Trigger the login call
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

          // Full‑screen loader overlay
          if (isLoading)
            const Opacity(
              opacity: 0.6,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
