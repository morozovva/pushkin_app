import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/http_exception.dart';
import '../provider/auth_provider.dart';

enum AuthMode { signup, login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey mailKey = GlobalKey();
  GlobalKey passKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  bool _obscureText = true;
  var _isLoading = false;
  final _passwordController = TextEditingController();

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Ошибка входа",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              content: Text(message),
            ));
  }

  Future<void> _submit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
            _authData["email"] as String, _authData["password"] as String);
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
            _authData["email"] as String, _authData["password"] as String);
      }
    } on HttpException catch (e) {
      var errorMessage = "Извините, не удалось войти";
      if (e.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "Такая почта уже занята";
      } else if (e.toString().contains("INVALID_EMAIL")) {
        errorMessage = "Неверный формат почты";
      } else {
        errorMessage =
            "Неизвестная ошибка, попробуйте повторить запрос позднее";
      }
      _showErrorDialog(errorMessage);
    } on Exception catch (_) {
      _showErrorDialog("Проверьте подключение к интернету и повторите попытку");
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  List<Widget> buildTextInputs() {
    return [
      TextFormField(
        enabled: _authMode == AuthMode.signup,
        decoration: const InputDecoration(labelText: 'Фамилия'),
      ),
      TextFormField(
        enabled: _authMode == AuthMode.signup,
        decoration: const InputDecoration(labelText: 'Имя'),
      ),
      TextFormField(
        enabled: _authMode == AuthMode.signup,
        decoration: const InputDecoration(labelText: 'Номер телефона'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Card(
      color: isDarkMode ? Colors.black : Colors.white,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (_authMode == AuthMode.signup) ...buildTextInputs(),
              AutofillGroup(
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Электронная почта'),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      autofocus: false,
                      key: mailKey,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Неверная почта!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value!;
                      },
                    ),
                    TextFormField(
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                          labelText: 'Пароль',
                          suffixIcon: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: IconButton(
                                icon: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () => _toggleObscure(),
                              ))),
                      obscureText: _obscureText,
                      autofillHints: const [AutofillHints.password],
                      key: passKey,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Пароль должен содержать не менее 6 символов';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['password'] = value!;
                      },
                    ),
                  ],
                ),
              ),
              if (_authMode == AuthMode.signup)
                TextFormField(
                  obscuringCharacter: "*",
                  enabled: _authMode == AuthMode.signup,
                  decoration: const InputDecoration(
                    labelText: 'Повторите пароль',
                  ),
                  obscureText: true,
                  validator: _authMode == AuthMode.signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Пароли не совпадают!';
                          }
                          return null;
                        }
                      : null,
                ),
              const SizedBox(
                height: 20,
              ),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text(
                      _authMode == AuthMode.login
                          ? 'Войти'
                          : 'Зарегистрироваться',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                    onPressed: () {
                      _submit();
                    },
                  ),
                ),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  _authMode == AuthMode.login ? 'Зарегистрироваться' : 'Войти',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
