import 'package:filmfolio/main.dart';
import 'package:filmfolio/models/movie.dart';
import 'package:filmfolio/widgets/movie_item.dart';
import 'package:flutter/material.dart';


class MoviesList extends StatelessWidget {
  const MoviesList({
    required this.onRemoveMovie,
    required this.movies,
    required this.onUpdateMovieList,
    super.key
  });

  final void Function(Movie movie) onRemoveMovie;
  final List<Movie> movies;
  final Function() onUpdateMovieList;

  @override
  Widget build(BuildContext context) {
    final session = supabase.auth.currentSession;
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (ctx, index) =>
            Dismissible(
                confirmDismiss: (direction) async {
                  if (session?.user?.id != movies[index].uid){
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text("Deletion Prohibited! You cannot delete someone's post"),
                        ));
                    return false;
                  }
                  else{
                    return true;
                  }
                },
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).colorScheme.error.withOpacity(0.85),
                  ),

                  margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16

                  ),

                ),
                key: ValueKey(movies[index]),
                onDismissed: (direction){
                  onRemoveMovie(movies[index]);
                },
                child: MovieItem(
                  movie: movies[index],
                  onUpdateMovieList: onUpdateMovieList,
                )
            )
    );
  }
}
