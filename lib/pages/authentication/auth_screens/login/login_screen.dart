import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:gym_tracker/pages/authentication/auth_screens/login/login_screen_controller.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _BuildHeading(),
              _BuildForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Login.",
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
    );
  }
}

class _BuildForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    Widget _sizedBox = SizedBox(height: 10);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              validator: EmailValidator(errorText: "enter a valid address"),
              decoration: InputDecoration(
                  labelText: "Email", hintText: "enter your email"),
            ),
            _sizedBox,
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: MinLengthValidator(8,
                  errorText: "Minimum 8 characters required"),
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "enter your password",
              ),
            ),
            _sizedBox,
            ElevatedButton(
                child: Text("Submit"),
                onPressed: () => context
                    .read(loginScreenController)
                    .validateAndSubmit(_emailController, _passwordController,
                        _formKey, context))
          ],
        ),
      ),
    );
  }
}
