import 'package:filmfolio/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  bool showPassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login(){
    AppUser user = AppUser(username: "", email: _emailController.text, password: _passwordController.text, context: context);
    user.login();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
                top: 50,
                left: 25,
                right: 25
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'filmfolio.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xff051650),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Welcome Back!',
                      style: GoogleFonts.assistant(
                          fontSize: 26,
                          fontWeight: FontWeight.w800
                      ),
                    ),
                    Text(
                      'Please login here to continue',
                      style: GoogleFonts.assistant(
                          fontSize: 16
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: showPassword,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                                showPassword ? Icons.visibility : Icons.visibility_off
                            ),
                            onPressed: (){
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          )
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            backgroundColor: const Color(0xff051650)
                        ),
                        onPressed: login,
                        child: Text(
                          'Login',
                          style: GoogleFonts.assistant(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('New to filmfolio?'),
                        TextButton(
                            onPressed: (){
                              Navigator.pushReplacementNamed(context, '/register');
                            },
                            child: const Text('Register here!')
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
