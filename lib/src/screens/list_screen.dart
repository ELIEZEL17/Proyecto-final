import 'package:flutter/material.dart';
import '../providers/client_provider.dart';
import 'package:provider/provider.dart';
import 'payment_history_screen.dart'; // Importar la nueva pantalla

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes Actuales',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: clientProvider.clientes.length,
          itemBuilder: (context, index) {
            final cliente = clientProvider.clientes[index];
            return GestureDetector(
              onTap: () {
                // Acción al tocar el cliente
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PaymentHistoryScreen(cliente: cliente),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 6.0,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  tileColor: Colors.blueGrey[50],
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, color: Colors.white, size: 35),
                  ),
                  title: Text(
                    cliente.nombre,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Cuotas Pagadas: ${cliente.cuotasPagadas} de ${cliente.cuotasMensuales}',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600])),
                      SizedBox(height: 5),
                      Text(
                          'Monto Pendiente: \$${(cliente.cantidadPrestada - (cliente.cuotasPagadas * (cliente.cantidadPrestada / cliente.cuotasMensuales))).toStringAsFixed(2)}',
                          style:
                              TextStyle(fontSize: 14, color: Colors.red[600])),
                    ],
                  ),
                  trailing: Icon(
                    Icons.history,
                    color: Colors.blueAccent,
                    size: 28,
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
