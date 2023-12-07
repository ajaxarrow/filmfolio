import 'package:filmfolio/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum Genre{
  action, comedy, scifi, horror, romance
}


class Movie{
  Movie({
    required this.title,
    required this.year,
    required this.genre,
    required this.uid,
    this.movieid,
    required this.context
  });

  final String title;
  final int year;
  final String genre;
  final BuildContext context;
  final String? uid;
  final int? movieid;

  void showError(String errorMessage){
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Something Went Wrong!'),
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

  void updateMovie() async{
    try {
      await supabase
          .from('movie')
          .update({
        'title': title,
        'year': year,
        'genre': genre,
      }).match({ 'id': movieid });
    } on AuthException catch (error) {
      showError(error.message);
      return null;
    }

  }





}