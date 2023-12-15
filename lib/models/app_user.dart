import 'package:filmfolio/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppUser{
  const AppUser({
    required this.username,
    required this.email,
    required this.password,
    required this.context
  });

  final String username;
  final String email;
  final String password;
  final BuildContext context;

  void showError(String errorMessage){
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Authentication Error!'),
          content: Text(errorMessage),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ));
  }

  void login() async {
    try {
      try {
        await supabase.auth.signInWithPassword(
          password: password.trim(),
          email: email.trim(),
        );
      } on AuthException catch (error) {
        showError(error.message);
        return;
      }
        final user = supabase.auth.currentUser;
        Navigator.pushReplacementNamed(context, '/home');

    } catch (error) {
      showError(error.toString());
    }
  }

  void validateUser(){
    if(username.trim().isEmpty || username.length < 4){
      showError("Username is invalid. It should be atleast 4 characters");
    }
    else{
      register();
    }
  }

  void register() async {
    String? id;
    try {
      try {
        final response = await supabase
            .from("user")
            .select()
            .eq('username', username)
            .single();

        final userWithUsername = response;

        if (userWithUsername != null) {
          showError('Username Already Exists');
          return;
        }
      } on Exception catch (error) {

      }

      try {
        final result = await supabase.auth.signUp(
          password: password.trim(),
          email: email.trim(),
        );
        id = result.user?.id;
        print(result);
      } on AuthException catch (error) {
        showError(error.message);
        return;
      }
      

      try {
        await supabase.from("user").insert({
          'username': username,
          'email': email,
          'user_id': id
        });
      } on Exception catch (error) {
        showError(error.toString());
        return;
      }


      final user = supabase.auth.currentUser;
      Navigator.pushReplacementNamed(context, '/home');


    } catch (error) {
      showError(error.toString());
    }
  }
}