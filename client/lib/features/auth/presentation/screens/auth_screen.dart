import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/logger.dart';
import '../../application/providers/auth_provider.dart';
import '../widgets/login_form.dart';
import '../widgets/register_form.dart';
import 'account_management.dart';

/// A screen for authenticating the user.
class AuthScreen extends ConsumerStatefulWidget {
  /// Creates a new [AuthScreen] instance.
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool _isLogin = true;

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(
          builder: (context, ref, child) {
            final authState = ref.watch(authProvider);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (authState.isAuthenticated) {
                logger.d('User is authenticated');
                logger.d('User: ${authState.user.toString()}');
                // ToastService.message(context, 'Logged in');
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const AccountManagementScreen(),
                  ),
                );
              }
            });

            if (authState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (authState.error != null) {
              // ToastService.error(context, authState.error.toString());
              return Center(
                child: Column(
                  children: [
                    Text('Error: ${authState.error}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () =>
                          ref.read(authProvider.notifier).clearError(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _isLogin ? LoginForm() : RegistrationForm(),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: _toggleForm,
                      child: Text(
                        _isLogin
                            ? 'Need to register? Create an account'
                            : 'Have an account? Login',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
