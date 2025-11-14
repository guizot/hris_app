import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hris_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hris_app/features/auth/presentation/pages/home_page.dart';
import 'package:hris_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:hris_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:hris_app/features/auth/presentation/widgets/custom_text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Image.asset('assets/icons/logo.png', height: 100),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Log in to your account',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'Work Email',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    obscureText: _obscureText,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Log In',
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            SignInEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Log In with Biometrics',
                    onPressed: () {},
                    isOutlined: true,
                    icon: const Icon(FontAwesomeIcons.fingerprint),
                  ),
                  const SizedBox(height: 32),
                  const Text('OR'),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: 'Continue with Google',
                    onPressed: () {},
                    isOutlined: true,
                    icon: const Icon(FontAwesomeIcons.google),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Continue with Microsoft',
                    onPressed: () {},
                    isOutlined: true,
                    icon: const Icon(FontAwesomeIcons.microsoft),
                  ),
                  const SizedBox(height: 32),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text('Don\'t have an account? Sign Up'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
