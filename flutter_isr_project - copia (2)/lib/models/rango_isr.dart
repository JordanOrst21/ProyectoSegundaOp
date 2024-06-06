class RangoISR {
  double limiteInferior;
  double limiteSuperior;
  double cuotaFija;
  double porcentajeExcedente;

  RangoISR(
      {required this.limiteInferior,
      required this.limiteSuperior,
      required this.cuotaFija,
      required this.porcentajeExcedente});

  bool estaDentroDelRango(double ingreso) {
    return ingreso >= limiteInferior && ingreso <= limiteSuperior;
  }

  double calcularImpuesto(double ingreso) {
    if (estaDentroDelRango(ingreso)) {
      return cuotaFija +
          ((ingreso - limiteInferior) * (porcentajeExcedente / 100));
    }
    return 0.0;
  }

  factory RangoISR.fromJson(Map<String, dynamic> json) {
    return RangoISR(
        limiteInferior: json['limiteInferior'],
        limiteSuperior: json['limiteSuperior'],
        cuotaFija: json['cuotaFija'],
        porcentajeExcedente: json['porcentajeExcedente']);
  }
}
