import 'package:isr_dart24/isr_dart24.dart';
import 'package:isr_dart24/models/rango_isr.dart';

@Table(name: 'rango')
class _RangoISR {
  @primaryKey
  int? id;

  @Column(nullable: false)
  late double limiteInferior;

  @Column(nullable: false)
  late double limiteSuperior;

  @Column(nullable: false)
  late double cuotaFija;

  @Column(nullable: false, name: 'porcentajeExcendentes')
  late double porcentajeExcedente;
}

class RangoISR extends ManagedObject<_RangoISR> implements _RangoISR {
  bool estaDentroDelRango(double ingreso) {
    return ingreso >= limiteInferior && ingreso <= limiteInferior;
  }

  double calcularImpuestp(double ingreso) {
    if (estaDentroDelRango(ingreso)) {
      return cuotaFija +
          ((ingreso - limiteInferior) * (porcentajeExcedente / 100));
    }
    return 0.0;
  }

  Map<String, dynamic> toJSON() {
    return {
      'limiteInferior': limiteInferior,
      'limiteSuperior': limiteSuperior,
      'cuotaFija': cuotaFija,
      'porcentajeExcedente': porcentajeExcedente
    };
  }
}
