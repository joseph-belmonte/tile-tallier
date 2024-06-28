import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/auth_provider.dart';

/// A form for registering.
class RegistrationForm extends ConsumerStatefulWidget {
  /// Creates a new [RegistrationForm] instance.
  const RegistrationForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmedPassword = '';

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onSaved: (value) => _email = value!,
              validator: (value) => value!.isEmpty ? 'Email is required' : null,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passwordController,
              onSaved: (value) => _password = value!,
              onChanged: (value) => _password = value,
              validator: (value) =>
                  value!.isEmpty ? 'Password is required' : null,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _confirmedPasswordController,
              onSaved: (value) => _confirmedPassword = value!,
              onChanged: (value) => _confirmedPassword = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please confirm your password';
                }

                if (_passwordController.text != value) {
                  return 'Passwords do not match';
                } else {
                  return null;
                }
              },
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ref
                    .read(authProvider.notifier)
                    .register(_email, _password, _confirmedPassword);
              }
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
