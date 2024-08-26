import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/auth_provider.dart';

/// A form for logging in.
class LoginForm extends ConsumerStatefulWidget {
  /// Creates a new [LoginForm] instance.
  const LoginForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();

  @override
  void dispose() {
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _emailController.text = 'test@test.com';
    _pwController.text = 'test@test.com';

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              onSaved: (value) => _emailController.text = value!,
              validator: (value) => _emailController.text.isEmpty ? 'Email is required' : null,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _pwController,
              onSaved: (value) => _pwController.text = value!,
              onChanged: (value) => _pwController.text = value,
              validator: (value) => value!.isEmpty ? 'Password is required' : null,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final email = _emailController.text;
              final password = _pwController.text;
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ref.read(authProvider.notifier).login(email, password);
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
