import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/auth_provider.dart';
import '../widgets/login_form.dart';
import '../widgets/register_form.dart';
import 'account_management.dart';

/// A screen for authenticating the user.
class AuthScreen extends StatefulWidget {
  /// Creates a new [AuthScreen] instance.
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _navigateBack(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AccountManagementScreen()),
      );
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

            if (authState.isAuthenticated) {
              _navigateBack(context);
            }

            return Center(
              child: Column(
                children: <Widget>[
                  _isLogin ? LoginForm() : RegistrationForm(),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: _toggleForm,
                    child: Text(
                      _isLogin ? 'Need to register? Create an account' : 'Have an account? Login',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
