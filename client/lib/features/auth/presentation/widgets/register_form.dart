import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/auth_provider.dart';

/// A form for logging in.
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
  final TextEditingController _confirmedPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          if (authState.error != null) Text(authState.error!),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onSaved: (value) => _email = value!,
              validator: (value) => value!.isEmpty ? 'Email is required' : null,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passwordController,
              onSaved: (value) => _password = value!,
              onChanged: (value) => _password = value,
              validator: (value) => value!.isEmpty ? 'Password is required' : null,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _confirmedPasswordController,
              onSaved: (value) => _confirmedPassword = value!,
              onChanged: (value) => _confirmedPassword = value,
              validator: (value) => value!.isEmpty ? 'Passwords must match' : null,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ref.read(authProvider.notifier).register(_email, _password, _confirmedPassword);
              }
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
