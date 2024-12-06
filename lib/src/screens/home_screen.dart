import 'package:flutter/material.dart';
import 'register_screen.dart'; // Asegúrate de que esté correctamente importado
import 'payment_screen.dart'; // Asegúrate de que esté correctamente importado
import 'list_screen.dart'; // Asegúrate de que esté correctamente importado

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sistema de Prestamos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAnimatedButton(
                context,
                'Registrar Cliente',
                RegisterScreen(),
              ),
              SizedBox(height: 20),
              _buildAnimatedButton(
                context,
                'Realizar Pago',
                PaymentScreen(),
              ),
              SizedBox(height: 20),
              _buildAnimatedButton(
                context,
                'Listado de Clientes',
                ListScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Botón animado
  Widget _buildAnimatedButton(
      BuildContext context, String text, Widget nextPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold, // Agregado para mayor énfasis
          ),
        ),
      ),
    );
  }
}
