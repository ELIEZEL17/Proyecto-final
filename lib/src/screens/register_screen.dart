import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart'; // Widget de campo de texto reutilizable
import '../widgets/custom_button.dart'; // Widget de botón reutilizable
import '../models/client.dart';
import '../providers/client_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController installmentsController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Cliente'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Encabezado del formulario
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Registrar Nuevo Cliente',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),

                // Campo de texto para el nombre del cliente
                CustomTextField(
                  controller: nameController,
                  hint: 'Nombre del Cliente',
                ),
                SizedBox(height: 20),

                // Campo de texto para la cantidad prestada
                CustomTextField(
                  controller: amountController,
                  hint: 'Cantidad Prestada',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),

                // Campo de texto para las cuotas mensuales
                CustomTextField(
                  controller: installmentsController,
                  hint: 'Cuotas Mensuales',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),

                // Campo de texto para la dirección
                CustomTextField(
                  controller: addressController,
                  hint: 'Dirección',
                ),
                SizedBox(height: 40),

                // Botón para guardar el cliente
                CustomButton(
                  text: 'Guardar Cliente',
                  onPressed: () {
                    final cliente = Cliente(
                      nombre: nameController.text,
                      cantidadPrestada:
                          double.tryParse(amountController.text) ?? 0,
                      cuotasMensuales:
                          (double.tryParse(installmentsController.text) ?? 0)
                              .toInt(),
                      direccion: addressController.text,
                    );

                    // Validación de los campos
                    if (cliente.nombre.isNotEmpty &&
                        cliente.cantidadPrestada > 0 &&
                        cliente.cuotasMensuales > 0 &&
                        cliente.direccion.isNotEmpty) {
                      Provider.of<ClientProvider>(context, listen: false)
                          .agregarCliente(cliente);

                      // Limpia los campos después de guardar
                      nameController.clear();
                      amountController.clear();
                      installmentsController.clear();
                      addressController.clear();

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Cliente registrado con éxito')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Por favor, complete todos los campos')));
                    }
                  },
                ),

                // Espacio adicional al final
                SizedBox(height: 40),

                // Sección para ver los detalles del cliente
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Detalles del Cliente (Historial)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),

                // Caja con detalles de ejemplo (esto solo es un diseño de muestra)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDetailRow('Nombre', nameController.text),
                      _buildDetailRow(
                          'Cantidad Prestada', '\$${amountController.text}'),
                      _buildDetailRow(
                          'Cuotas Mensuales', installmentsController.text),
                      _buildDetailRow('Dirección', addressController.text),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para mostrar cada detalle en formato de fila
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            value.isNotEmpty ? value : 'N/A',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
