import 'package:flutter/cupertino.dart';
import 'package:flutter_isr_project/screens/ImagenNotaScreen.dart';
import 'package:flutter_isr_project/screens/ListaNotasScreen.dart';
import 'package:flutter_isr_project/screens/UsuariosListadoScreen.dart';
import 'package:flutter_isr_project/screens/login.dart';
import 'package:flutter_isr_project/screens/notadetail.dart';
import 'package:flutter_isr_project/services/nota_service.dart';

class ISRApp extends StatelessWidget {
  const ISRApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "Aplicacion ISR",
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      //home: LoginScreen(),
      home: UsuariosListadoScreen(),
      //home: ListaNotasScreen(usuarioID: 1),
      //home: ImagenNotaScreen(),
    );
  }
}
