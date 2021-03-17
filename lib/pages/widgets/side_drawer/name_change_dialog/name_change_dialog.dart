import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gym_tracker/pages/widgets/side_drawer/name_change_dialog/name_change_dialog_controller.dart';

class NameChangeDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return AlertDialog(
      title: Text("Change My Name"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _BuildForm(),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}

class _BuildForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final nameDialogController = watch(nameChangeDialogControllerProvider);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
              validator: RequiredValidator(errorText: 'Name cannot be empty'),
              controller: _controller,
              decoration: InputDecoration(labelText: "Name")),
          ElevatedButton(
            onPressed: () {
              nameDialogController.handleSubmitBtn(
                  context: context,
                  nameController: _controller,
                  formKey: _formKey);
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
