import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminAuthForm extends StatefulWidget {
  const AdminAuthForm(this.submitFn, this.isLoading, {super.key});

  final bool isLoading;
  final void Function(
    String username,
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  State<AdminAuthForm> createState() => _AdminAuthFormState();
}

class _AdminAuthFormState extends State<AdminAuthForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  dynamic _userName, _userEmail, _userPassword = '', _isLogin = true;
  // ignore: unused_field

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userName.toString().trim(),
        _userEmail.toString().trim(),
        _userPassword.toString().trim(),
        _isLogin,
        context,
      );
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("password", _userPassword);
    prefs.setString("Uemail", _userEmail);
  }

  checkPassword() async {
    SharedPreferences p = await SharedPreferences.getInstance();

    if (p.getString("password") != null && p.getString("Uemail") != null) {
      userEmail.text = p.getString("Uemail")!;
      userPassword.text = p.getString("password")!;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    checkPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin)
                    TextFormField(
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      key: const ValueKey('username'),
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (name) {
                        if (name!.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                      onSaved: (name) {
                        _userName = name;
                      },
                    ),
                  TextFormField(
                    controller: userEmail,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    key: const ValueKey('email address'),
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(labelText: 'Email Address'),
                    validator: (email) {
                      if (email!.isEmpty || !email.contains('@')) {
                        return 'Please enter email address';
                      }
                      return null;
                    },
                    onSaved: (email) {
                      _userEmail = email;
                    },
                  ),
                  TextFormField(
                    controller: userPassword,
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (password) {
                      if (password!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSaved: (password) {
                      _userPassword = password;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
