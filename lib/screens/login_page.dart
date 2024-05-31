import 'package:flutter/material.dart';
import 'package:flutter_starter/models/user_model.dart';
import 'package:flutter_starter/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";
  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Connexion",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    initialValue: "juste.leblanc@mail.com",
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Champ requis";
                      } else if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                          .hasMatch(value)) {
                        return "Doit être un email";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.7, // 70% de la largeur de l'écran
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      initialValue: "1MotdePasse?",
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Champ requis';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    )),
              ),
              SizedBox(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () => _connect(context),
                        child: Text('Se connecter'),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  void _connect(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserModel(email: _email, password: _password);
      Provider.of<AuthService>(context, listen: false)
          .login(_email, _password)
          .then(
        (snackBar) {
          return snackBar.display(context);
        },
      );
    }
  }
}
