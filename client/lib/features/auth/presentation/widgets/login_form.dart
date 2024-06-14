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
  final _pwController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    var email = '';
    var password = '';

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          if (authState.error != null) Text(authState.error!, style: TextStyle(color: Colors.red)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onSaved: (value) => email = value!,
              validator: (value) => value!.isEmpty ? 'Email is required' : null,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _pwController,
              onSaved: (value) => password = value!,
              onChanged: (value) => password = value,
              validator: (value) => value!.isEmpty ? 'Password is required' : null,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ref.read(authProvider.notifier).login(email, password);
              }
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
