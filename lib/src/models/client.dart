class Cliente {
  String nombre;
  double cantidadPrestada;
  int cuotasMensuales; // Cambié a int
  int cuotasPagadas; // Cambié a int
  String direccion;
  List<double> historialPagos;

  Cliente({
    required this.nombre,
    required this.cantidadPrestada,
    required this.cuotasMensuales,
    required this.direccion,
    this.cuotasPagadas = 0, // Inicializamos cuotasPagadas como 0
    List<double>? historialPagos,
  }) : historialPagos = historialPagos ?? [];

  void realizarPago(double amountPaid) {
    // Determina el valor de una cuota
    double cuotaActual = cantidadPrestada / cuotasMensuales;

    // Calcula cuántas cuotas se han pagado con el monto ingresado
    double cuotasRegistradas = amountPaid / cuotaActual;

    // Asegúrate de que no se pague más de las cuotas restantes
    int cuotasRestantes = cuotasMensuales - cuotasPagadas;
    if (cuotasRegistradas > cuotasRestantes) {
      cuotasRegistradas = cuotasRestantes.toDouble();
    }

    // Actualiza las cuotas pagadas
    cuotasPagadas += cuotasRegistradas.toInt();

    // No permitir que las cuotas pagadas excedan el total de cuotas
    if (cuotasPagadas > cuotasMensuales) {
      cuotasPagadas = cuotasMensuales;
    }

    // Agregar el pago al historial
    historialPagos.add(amountPaid);
  }
}
