import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_isr_project/screens/ListaNotasScreen.dart';
import 'package:flutter_isr_project/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    print(_emailController.text);
    print(_passwordController.text);

    try {
      final success = await _authService.login(
        _emailController.text,
        _passwordController.text,
      );

      if (success) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => const ListaNotasScreen(usuarioID: 1),
          ),
        );
      } else {
        _showErrorDialog('Email o contraseña incorrectos');
      }
    } catch (e) {
      _showErrorDialog('Error al iniciar sesión: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Iniciar Sesión"),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: 96,
              color: Colors.grey,
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoTextField(
                controller: _emailController,
                placeholder: "Correo Electrónico",
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoTextField(
                controller: _passwordController,
                placeholder: "Contraseña",
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CupertinoActivityIndicator()
            else
              CupertinoButton.filled(
                onPressed: _login,
                child: const Text("Iniciar Sesión"),
              ),
          ],
        ),
      ),
    );
  }
}
