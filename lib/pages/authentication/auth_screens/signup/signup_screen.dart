import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gym_tracker/pages/authentication/auth_screens/signup/signup_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _BuildHeading(),
              SizedBox(height: 15),
              _BuildSignupForm(),
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
      "Sign Up Here.",
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
    );
  }
}

class _BuildSignupForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstPasswordController = TextEditingController();
  final _secondPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'New Email',
                  hintText: 'Enter the email you wish to register'),
              validator:
                  EmailValidator(errorText: "Please enter a valid email"),
            ),
            TextFormField(
              obscureText: true,
              controller: _firstPasswordController,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter the password you wish to register'),
              validator: MinLengthValidator(8,
                  errorText:
                      "Please enter a password at least 8 characters long"),
            ),
            TextFormField(
              obscureText: true,
              controller: _secondPasswordController,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Please re-enter your password'),
              validator: (val) => MatchValidator(
                      errorText: "Please make sure the passwords match")
                  .validateMatch(val, _firstPasswordController.text),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => context
                  .read(signUpScreenController)
                  .validateAndSubmitForm(
                      emailController: _emailController,
                      firstPassController: _firstPasswordController,
                      secondPassController: _secondPasswordController,
                      formKey: _formKey,
                      context: context),
              child: Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}
