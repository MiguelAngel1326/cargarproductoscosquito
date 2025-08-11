import 'package:cargaproductos/feactures/cliente/presentation/providers/registry_form_provider.dart';
import 'package:cargaproductos/feactures/shared/widget/custom_filled_button.dart';
import 'package:cargaproductos/feactures/shared/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';

class registrarCliente extends StatefulWidget {
  const registrarCliente({super.key});

  @override
  State<registrarCliente> createState() => _registrarClienteState();
}

class _registrarClienteState extends State<registrarCliente> {
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Registrar cliente nuevo'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: _RegistryForm(),
              )
          ),
        ),
      ),
    );
  }
}

class _RegistryForm extends ConsumerStatefulWidget {
  const _RegistryForm();

  @override
  ConsumerState<_RegistryForm> createState() => _RegistryFormState();
}

class _RegistryFormState extends ConsumerState<_RegistryForm> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context) {
    final registryForm = ref.watch(registryformProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.responseOk.isNotEmpty) {
        showSnackbar(context, next.responseOk);
        // Limpiar campos y estado del formulario después de éxito
        nameController.clear();
        phoneController.clear();
        addressController.clear();
        ref.read(registryformProvider.notifier).clearForm();
      } else if (next.errorMessage.isNotEmpty) {
        showSnackbar(context, next.errorMessage);
      }
    });

    return Column(
      children: [
        CustomTextFormField(
          label: 'Nombre',
          controller: nameController,
          obscureText: false,
          onChanged: ref.read(registryformProvider.notifier).onNameChanged,
          errorMessage: registryForm.isFormPosted ? registryForm.name.errorMessage : null,
        ),
        SizedBox(height: 20),
        CustomTextFormField(
          label: 'Telefono',
          controller: phoneController,
          obscureText: false,
          onChanged: ref.read(registryformProvider.notifier).onPhoneChanged,
          errorMessage: registryForm.isFormPosted ? registryForm.phone.errorMessage : null,
        ),
        SizedBox(height: 20),
        CustomTextFormField(
          label: 'Direccion',
          controller: addressController,
          obscureText: false,
          onChanged: ref.read(registryformProvider.notifier).onAddressChanged,
          errorMessage: registryForm.isFormPosted ? registryForm.address.errorMessage : null,
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: CustomFilledButton(
            text: 'Registrar',
            buttonColor: Colors.black,
            onPressed: () {
              ref.read(registryformProvider.notifier).onFormSubmit();
            },
          ),
        ),
      ],
    );
  }
}