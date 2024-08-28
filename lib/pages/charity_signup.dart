import 'package:flutter/material.dart';

class CharitySignupPage extends StatefulWidget {
  const CharitySignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<CharitySignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _charityNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _signupSuccessful = false;

  @override
  void dispose() {
    _charityNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
      // Handle signup logic here
      print('Charity Name: ${_charityNameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      setState(() {
        _signupSuccessful = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C H A R I T Y  - Sign Up'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _charityNameController,
                decoration: const InputDecoration(labelText: 'Charity Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Charity Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                child: const Text('Sign Up'),
              ),
              if (_signupSuccessful) //if successful show Textbutton
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/donor_login');
                    },
                    child: const Text('Go to Login Page'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
