import 'package:flutter/material.dart';
class BotonesAccion extends StatelessWidget {
  final VoidCallback onPrimario;
  final VoidCallback onSecundario;
  final String textoPrimario;
  final String textoSecundario;
  final Color colorPrimario;
  final Color colorSecundario;

  const BotonesAccion({super.key, 
    required this.onPrimario,
    required this.onSecundario,
    this.textoPrimario = 'Guardar',
    this.textoSecundario = 'Cancelar',
    this.colorPrimario = Colors.blue,
    this.colorSecundario = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: onPrimario,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorPrimario,
          ),
          child: Text(textoPrimario),
        ),
        ElevatedButton(
          onPressed: onSecundario,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorSecundario,
          ),
          child: Text(textoSecundario, style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}