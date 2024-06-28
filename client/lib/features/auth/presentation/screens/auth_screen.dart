// presentation/screens/auth_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/auth_provider.dart';
import '../widgets/login_form.dart';
import '../widgets/register_form.dart';
import 'account_management.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool _isLogin = true;

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _navigateToAccountManagement(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AccountManagementScreen(),
        ),
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

            if (authState.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (authState.isAuthenticated) {
              _navigateToAccountManagement(context);
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
