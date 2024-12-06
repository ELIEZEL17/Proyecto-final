import 'package:flutter/material.dart';
import '../providers/client_provider.dart';
import 'package:provider/provider.dart';
import '../models/client.dart';

class PaymentHistoryScreen extends StatelessWidget {
  final Cliente cliente;

  PaymentHistoryScreen({required this.cliente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historial de Pagos de ${cliente.nombre}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: cliente.historialPagos.isEmpty
          ? Center(
              child: Text(
                'No hay pagos registrados',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: cliente.historialPagos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Acción al tocar el pago (puedes agregar detalles del pago si lo deseas)
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 6.0,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        tileColor: Colors.blueGrey[50],
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.attach_money,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        title: Text(
                          'Pago: \$${cliente.historialPagos[index].toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          'Cuota ${index + 1}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
