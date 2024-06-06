import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgregarNotaCardWidget extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final Color color;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const AgregarNotaCardWidget({
    Key? key,
    required this.titulo,
    required this.descripcion,
    required this.color,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style:
                      CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                ),
                SizedBox(height: 8),
                Text(
                  descripcion,
                  style:
                      CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                            fontSize: 16,
                          ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 1,
                  color: CupertinoColors.separator,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete,
              ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: onEdit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
