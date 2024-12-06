import 'package:flutter/foundation.dart';
import '../models/client.dart';

class ClientProvider with ChangeNotifier {
  List<Cliente> _clientes = [];

  List<Cliente> get clientes => _clientes;

  void agregarCliente(Cliente cliente) {
    _clientes.add(cliente);
    notifyListeners();
  }

  void realizarPago(Cliente cliente) {
    if (cliente.cuotasPagadas < cliente.cuotasMensuales) {
      cliente.cuotasPagadas++;
      notifyListeners();
    }
  }
}
