import 'package:flutter/material.dart';
import '../providers/client_provider.dart';
import 'package:provider/provider.dart';
import '../models/client.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Cliente? selectedClient;
  final TextEditingController paymentAmountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Realizar Pago',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown to select client
              DropdownButton<Cliente>(
                hint: Text('Selecciona un cliente',
                    style: TextStyle(fontSize: 16)),
                value: selectedClient,
                onChanged: (Cliente? newValue) {
                  setState(() {
                    selectedClient = newValue;
                  });
                },
                items: clientProvider.clientes.map((Cliente cliente) {
                  return DropdownMenuItem<Cliente>(
                    value: cliente,
                    child: Text(cliente.nombre, style: TextStyle(fontSize: 16)),
                  );
                }).toList(),
                isExpanded: true,
              ),
              SizedBox(height: 20),
              // Display client details
              if (selectedClient != null) ...[
                Text('Nombre: ${selectedClient!.nombre}',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                Text('Cantidad Prestada: \$${selectedClient!.cantidadPrestada}',
                    style: TextStyle(fontSize: 18)),
                Text('Cuotas Totales: ${selectedClient!.cuotasMensuales}',
                    style: TextStyle(fontSize: 18)),
                Text('Cuotas Pagadas: ${selectedClient!.cuotasPagadas}',
                    style: TextStyle(fontSize: 18)),
                Text(
                    'Cuota Actual: \$${(selectedClient!.cantidadPrestada / selectedClient!.cuotasMensuales).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),

                // Payment Amount Input
                TextField(
                  controller: paymentAmountController,
                  decoration: InputDecoration(
                    labelText: 'Cantidad Pagada',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),

                // Description Input
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción/Condición',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (selectedClient != null) {
                      double amountPaid =
                          double.tryParse(paymentAmountController.text) ?? 0;

                      double cuotaActual = selectedClient!.cantidadPrestada /
                          selectedClient!.cuotasMensuales;

                      // Verificar que el monto ingresado sea múltiplo de la cuota exacta
                      if (amountPaid != cuotaActual) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'El pago debe ser exactamente \$${cuotaActual.toStringAsFixed(2)} por cuota')));
                        return;
                      }

                      // Verificar si el monto ingresado no supera lo que queda por pagar
                      double totalRestante = selectedClient!.cantidadPrestada -
                          (selectedClient!.cuotasPagadas * cuotaActual);

                      if (amountPaid > totalRestante) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'El monto ingresado no puede superar la deuda restante (\$${totalRestante.toStringAsFixed(2)})')));
                        return;
                      }

                      selectedClient!.historialPagos.add(amountPaid);
                      clientProvider.realizarPago(selectedClient!);

                      if (selectedClient!.cuotasPagadas ==
                          selectedClient!.cuotasMensuales) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                '${selectedClient!.nombre} ha pagado todas las cuotas.')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Pago realizado con éxito.')));
                      }

                      paymentAmountController.clear();
                      descriptionController.clear();
                      setState(() {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: Text('Pagar'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
