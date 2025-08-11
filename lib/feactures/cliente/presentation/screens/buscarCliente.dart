import 'package:cargaproductos/feactures/cliente/domain/entities/user.dart';
import 'package:cargaproductos/feactures/cliente/presentation/providers/buscarCliente_provider.dart';
import 'package:cargaproductos/feactures/shared/widget/custom_filled_button.dart';
import 'package:cargaproductos/feactures/shared/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class buscarCliente extends StatefulWidget {
  const buscarCliente({super.key});

  @override
  State<buscarCliente> createState() => _buscarClienteState();
}

class _buscarClienteState extends State<buscarCliente> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('Buscar Cliente')),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: _buscarClienteForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _buscarClienteForm extends ConsumerStatefulWidget {
  const _buscarClienteForm();

  @override
  ConsumerState<_buscarClienteForm> createState() => __buscarClienteFormState();
}

class __buscarClienteFormState extends ConsumerState<_buscarClienteForm> {
  late final TextEditingController phoneController;
  String telefonoBuscado = '';
  bool buscarRealizada = false;
  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void llamarProvider(String telefono) {
    ref.read(clienteInfoProvier.notifier).loadUser(telefono);
    setState(() {
      telefonoBuscado = telefono;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ref.watch(clienteInfoProvier)[telefonoBuscado];

    return Column(
      children: [
        CustomTextFormField(
          label: 'Número de Telefono',
          keyboardType: TextInputType.number,
          controller: phoneController,
          obscureText: false,
          //onChanged: ref.read(registryformProvider.notifier).onNameChanged,
          //errorMessage: registryForm.isFormPosted ? registryForm.name.errorMessage : null,
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: CustomFilledButton(
            text: 'Buscar',
            buttonColor: Colors.black,
            onPressed: () {
              final telefono = phoneController.text;
              llamarProvider(telefono);
               setState(() {
                buscarRealizada = true; // Marca que se intentó buscar
              });
            },
          ),
        ),
        if (user != null) _muestraInfromacion(user: user)
        else if(buscarRealizada && user == null && telefonoBuscado.isNotEmpty)
        Padding(padding: EdgeInsetsGeometry.all(20),
          child: Center(child: Text("No se encontró información", style: TextStyle(color: Colors.red, fontSize: 20))),
        ), 
      ],
    );
  }
}

class _muestraInfromacion extends StatefulWidget {
  final User user;

  const _muestraInfromacion({required this.user});

  @override
  State<_muestraInfromacion> createState() => __muestraInfromacionState();
}

class __muestraInfromacionState extends State<_muestraInfromacion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        widget.user.nombre.isEmpty 
        ? Center(
          child: Text("Sin Datos"),
        )
        : Row(
          children: [
            Text(
              'Nombre: ${widget.user.nombre}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Dinero: ${widget.user.dinero}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Direccion: ${widget.user.direccion}",
                style: TextStyle(fontSize: 20),
                maxLines: 3, // Puedes ajustar el número de líneas
                overflow: TextOverflow.ellipsis, // Muestra "..." si se excede
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        _descontarPuntos(user: widget.user) 
      ],
    );
  }
}

class _descontarPuntos extends StatefulWidget {
  final User user;
 const _descontarPuntos({required this.user});


  @override
  State<_descontarPuntos> createState() => __descontarPuntosState();
}

class __descontarPuntosState extends State<_descontarPuntos> {


  @override
  Widget build(BuildContext context) {

    final puntosController = TextEditingController(text: widget.user.dinero.toString());

    return Column(
      children: [
        CustomTextFormField(
          label: 'Dinero Electronico',
          keyboardType: TextInputType.number,
          controller: puntosController,
          obscureText: false,
          //onChanged: ref.read(registryformProvider.notifier).onNameChanged,
          //errorMessage: registryForm.isFormPosted ? registryForm.name.errorMessage : null,
        ),
       SizedBox(height: 30,),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: CustomFilledButton(
            text: 'Descontar',
            buttonColor: Colors.black,
            onPressed: () {
      
            },
          ),
        ),
      ],
    );
  }
}
