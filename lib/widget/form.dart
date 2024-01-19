
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authbloc.dart';
import '../blocs/autstat.dart';

class AuthForm extends StatefulWidget {
  final bool isSignIn;

  AuthForm({required this.isSignIn});

  @override
  _AuthFormState createState() => _AuthFormState();
}
// class _AuthFormState extends State<AuthForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state is AuthSuccess) {
//           Navigator.pushReplacementNamed(context, '/home');
//         } else if (state is AuthError) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(state.errorMessage),
//             duration: Duration(seconds: 3),
//           ));
//
//           if (state.errorMessage.contains('Email is already in use')) {
//             Navigator.pushReplacementNamed(context, '/home');
//           }
//         }
//       },
//       builder: (context, state) {
//         return Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 30.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Login', // Your title here
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Center(
//                     child: Image.asset(
//                       'images/21601.png', // Replace with your image URL
//                       width: 100, // Adjust the width as needed
//                       height: 100, // Adjust the height as needed
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(labelText: 'Email'),
//                     validator: (value) {
//                       if (value!.isEmpty || !value.contains('@')) {
//                         return 'Invalid email';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(labelText: 'Password'),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value!.isEmpty || value.length < 6) {
//                         return 'Password must be at least 6 characters';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 50),
//                   Center(
//                     child: Container(
//                       height: 50,
//                       width: 400,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             if (widget.isSignIn) {
//                               context.read<AuthCubit>().signIn(
//                                 email: _emailController.text.trim(),
//                                 password: _passwordController.text.trim(),
//                               );
//                             } else {
//                               context.read<AuthCubit>().signUp(
//                                 email: _emailController.text.trim(),
//                                 password: _passwordController.text.trim(),
//                               );
//                             }
//                           }
//                         },
//                         child: Text(widget.isSignIn ? 'Sign up' : 'Login'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isReauthenticating = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            duration: Duration(seconds: 3),
          ));

          if (state.errorMessage.contains('Email is already in use')) {
            _showReauthenticationDialog(context);
          }
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login', // Your title here
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      'images/21601.png', // Replace with your image URL
                      width: 100, // Adjust the width as needed
                      height: 100, // Adjust the height as needed
                    ),
                  ),
                  SizedBox(height: 20),
                  _isReauthenticating
                      ? _buildReauthenticationForm()
                      : Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50),
                      Center(
                        child: Container(
                          height: 50,
                          width: 400,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (widget.isSignIn) {
                                  context.read<AuthCubit>().signIn(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );
                                } else {
                                  context.read<AuthCubit>().signUp(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );
                                }
                              }
                            },
                            child: Text(widget.isSignIn ? 'Sign up' : 'Login'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showReauthenticationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reauthentication Required'),
          content: Text('Please enter your email again to confirm your identity.'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  _isReauthenticating = true;
                });

                // Clear the text fields after the dialog is closed
                _emailController.clear();
                _passwordController.clear();

                // Reauthenticate logic goes here...
                // For now, let's simulate a delay with Future.delayed
                await Future.delayed(Duration(seconds: 2));

                // After successful reauthentication, navigate to the home page
                if (_isReauthenticating) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReauthenticationForm() {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
          validator: (value) {
            if (value!.isEmpty || !value.contains('@')) {
              return 'Invalid email';
            }
            return null;
          },
        ),
        SizedBox(height: 50),
        Center(
          child: Container(
            height: 50,
            width: 400,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Proceed with reauthentication logic
                  await context.read<AuthCubit>().reauthenticate(
                    email: _emailController.text.trim(),
                  );

                  // After reauthentication, navigate to the home page
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: Text('Reauthenticate'),
            ),
          ),
        ),
      ],
    );
  }
}