import 'package:flutter/material.dart';
import 'package:hantera/presentation/core/constant/routes_values.dart';
import 'package:hantera/presentation/core/widget/text_field_item.dart';
import 'package:hantera/presentation/core/handler/dialog_handler.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    // Validate fields
    if (_nameController.text.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: 'Please enter your name',
      );
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: 'Please enter your email',
      );
      return;
    }

    if (_passwordController.text.isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: 'Please enter a password',
      );
      return;
    }


    // For now, just navigate to home
    Navigator.of(context).pushNamedAndRemoveUntil(RoutesValues.home, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign up to get started',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  TextFieldItem(
                    controller: _nameController,
                    title: 'Name',
                    inputType: TextInputType.name,
                  ),
                  TextFieldItem(
                    controller: _emailController,
                    title: 'Email',
                    inputType: TextInputType.emailAddress,
                  ),
                  TextFieldItem(
                    controller: _passwordController,
                    title: 'Password',
                    isObscure: true,
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _onRegisterPressed,
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).iconTheme.color,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).iconTheme.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
