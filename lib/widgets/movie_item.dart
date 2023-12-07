import 'package:filmfolio/main.dart';
import 'package:filmfolio/models/movie.dart';
import 'package:filmfolio/screens/update_movie_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MovieItem extends StatelessWidget {
  const MovieItem({required this.movie, required this.onUpdateMovieList, super.key});

  final Movie movie;
  final Function() onUpdateMovieList;

  @override
  Widget build(BuildContext context) {
    final session = supabase.auth.currentSession;

    void _openUpdateMoviesModal(){
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))
          ),
          builder: (ctx) => UpdateMovieScreen(movie: movie, onUpdateMovieList: onUpdateMovieList,)
      );
    }
    return Card(
      margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                    movie.title,
                    style: GoogleFonts.assistant(
                      fontWeight: FontWeight.w700,
                      fontSize: 16
                    )
                ),
                const Spacer(),
                session?.user?.id == movie.uid ? TextButton.icon(
                  onPressed: _openUpdateMoviesModal,
                  label: const Text('Edit'),
                  icon: const Icon(Icons.edit_rounded,
                  size: 16)
                ) : Container()
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(movie.year.toString()),
                const Spacer(),
                Text(movie.genre)
              ],
            )
          ],
        ),
      ),
    );
  }
}
