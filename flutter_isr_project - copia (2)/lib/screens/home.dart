import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_isr_project/services/isr_services.dart';
import 'package:flutter_isr_project/utils/input_formatter.dart';
import 'package:flutter_isr_project/models/rango_isr.dart';
import 'package:intl/intl.dart';

class HomeISR extends StatefulWidget {
  const HomeISR({super.key});

  @override
  State<HomeISR> createState() => _HomeISRState();
}

class _HomeISRState extends State<HomeISR> {
  final _ingresoController = TextEditingController();
  double _impuestoCalculado = 0.0;
  RangoISR? _rangoSeleccionado;

  List<RangoISR> _rangoISR = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarRangosISR();
  }

  void _calcularISR() async {
    final ingreso = double.tryParse(_ingresoController.text) ?? 0.0;
    var servicio = ISRService();

    try {
      var rango = await servicio.obtenerRangoISRPorCantidad(ingreso);
      setState(() {
        _impuestoCalculado = rango.calcularImpuesto(ingreso);
        _rangoSeleccionado = rango;
      });
    } catch (e) {
      print('Error al calcular el ISR: $e');
    }
  }

  void _cargarRangosISR() async {
    try {
      final servicio = ISRService();
      var rangos = await servicio.obtenerRangoISR();
      setState(() {
        _rangoISR = rangos;
        _isLoading = false;
      });
    } catch (e) {
      print('Error al obtener la lista de ISR: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Calculadora ISR"),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      controller: _ingresoController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [decimalInputFormatter],
                    ),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton(
                    onPressed: _calcularISR,
                    child: const Icon(CupertinoIcons.doc),
                  ),
                ],
              ),
              const Divider(height: 2),
              if (_isLoading) const Center(child: CupertinoActivityIndicator()),
              if (!_isLoading)
                Expanded(
                  child: ListView.builder(
                    itemCount: _rangoISR.length,
                    itemBuilder: (context, index) {
                      return CupertinoListTile(
                        backgroundColor: _rangoISR[index].limiteInferior ==
                                _rangoSeleccionado?.limiteInferior
                            ? CupertinoColors.lightBackgroundGray
                            : null,
                        title: Text(
                          'De ${NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(_rangoISR[index].limiteInferior)}'
                          ' a ${NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(_rangoISR[index].limiteSuperior)}',
                        ),
                        subtitle: Text(
                          'Cuota fija: ${NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(_rangoISR[index].cuotaFija)}, '
                          'Porcentaje Excedente: ${_rangoISR[index].porcentajeExcedente}%',
                        ),
                      );
                    },
                  ),
                ),
              const Divider(height: 2),
              const SizedBox(height: 8),
              Text(
                'ISR a Pagar: ${NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(_impuestoCalculado)}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
