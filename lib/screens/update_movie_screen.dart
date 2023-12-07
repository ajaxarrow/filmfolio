import 'package:filmfolio/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class UpdateMovieScreen extends StatefulWidget {
  const UpdateMovieScreen({required this.movie, required this.onUpdateMovieList, super.key});

  final Movie movie;
  final Function() onUpdateMovieList;


  @override
  State<UpdateMovieScreen> createState() => _UpdateMovieScreenState();
}

class _UpdateMovieScreenState extends State<UpdateMovieScreen> {


  @override
  Widget build(BuildContext context) {
    final session = supabase.auth.currentSession;
    var titleInput = widget.movie.title;
    var yearInput = widget.movie.year.toString();
    var genreInput = widget.movie.genre;
    var _movieTitleController = TextEditingController(text: titleInput);
    var _movieYearController = TextEditingController(text: yearInput);
    var _movieGenreController = TextEditingController(text: genreInput);

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

    void submitMovie(){
      final year = int.tryParse(_movieYearController.text);
      if(_movieTitleController.text.trim().isEmpty){
        showError("Title is Empty");
        return;
      }
      else if(_movieGenreController.text.trim().isEmpty){
        showError("Genre is Empty");
        return;
      }
      else if(year == null){
        showError("Year must be an integer");
        return;
      }
      else{
        titleInput = _movieTitleController.text;
        yearInput = year.toString();
        genreInput = _movieGenreController.text;
        Movie movie = Movie(title: _movieTitleController.text, year: int.parse(_movieYearController.text), genre: _movieGenreController.text, context: context, uid: session?.user?.id, movieid: widget.movie.movieid);
        movie.updateMovie();
        Navigator.pop(context);
        widget.onUpdateMovieList();
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 2),
              content: Text("Movie Updated!"),
            )
        );
      }
    }

      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: 30
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Update Movie',
                          style: GoogleFonts.assistant(
                              fontWeight: FontWeight.w700,
                              fontSize: 20
                          ),
                        ),
                        IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close_rounded))
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text('Title:', style: GoogleFonts.assistant(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _movieTitleController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.movie_filter),
                          hintText: 'Enter Movie Title'
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text('Year:', style: GoogleFonts.assistant(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _movieYearController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.date_range_rounded),
                          hintText: 'Enter Movie Year'
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text('Genre:', style: GoogleFonts.assistant(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _movieGenreController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.local_movies_outlined),
                          hintText: 'Enter Movie Genre'
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffdae2f3),
                                  padding: const EdgeInsets.symmetric(vertical: 19)
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text(
                                  'Cancel',
                                  style: GoogleFonts.assistant(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: const Color(0xff3b5ba9)
                                  )
                              )
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 19)
                              ),
                              onPressed: submitMovie,
                              child: Text(
                                  'Update',
                                  style: GoogleFonts.assistant(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  )
                              )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
        ),
      );
  }
}
