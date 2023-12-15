import 'package:filmfolio/main.dart';
import 'package:filmfolio/models/movie.dart';
import 'package:filmfolio/screens/new_movie_screen.dart';
import 'package:filmfolio/widgets/movies_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoviesRoute extends StatefulWidget {
  const MoviesRoute({super.key});

  @override
  State<MoviesRoute> createState() => _MoviesRouteState();
}

class _MoviesRouteState extends State<MoviesRoute> {
  List<Movie> _movies = [];
  final session = supabase.auth.currentSession;

  Future<void> fetchMovies() async {
    _movies.clear();
    final movieData = await supabase.from('movie').select('*');
    print(movieData);
    movieData.forEach((movie) {
      final movie_item = Movie(title: movie['title'], year: movie['year'], genre: movie['genre'], uid: movie['post_owner'], context: context, movieid: movie['id']);
      _movies.add(movie_item);
    });
  }

  void logout() async {
    await supabase.auth.signOut();
    Navigator.pushReplacementNamed(context, "/login");
  }

  void _openAddMoviesModal(){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      builder: (ctx) => NewMovieScreen(onAddMovie: _addMovie,)
    );
  }

  void _addMovie(Movie movie){
    setState(() {

    });
  }

  void _updateMovie(){
    setState(() {

    });
  }

  void _removeMovie(Movie movie) async{
      await supabase
          .from('movie')
          .delete()
          .match({ 'id': movie.movieid });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text("Movie Deleted!"),
          )
      );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchMovies(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color(0xff051650),
                title: Text(
                  'filmfolio.',
                  style: GoogleFonts.leagueSpartan(
                      fontWeight: FontWeight.w800,
                      fontSize: 24
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: logout,
                      icon: const Icon(
                        Icons.logout,
                        size: 25,
                      )
                  )
                ],
              ),
              body: const Center(child: CircularProgressIndicator()),
            floatingActionButton: FloatingActionButton(
              onPressed: _openAddMoviesModal,
              child: Icon(Icons.add),
              ),
            );


        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Widget mainContent = Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'OOPS!',
                  style: GoogleFonts.leagueSpartan(
                      fontWeight: FontWeight.w900,
                      fontSize: 50
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                    'There are no available movies found. Try adding some!'
                )
              ],
            ),
          );

          if (_movies.isNotEmpty){
            mainContent = MoviesList(
              onRemoveMovie: _removeMovie,
              movies: _movies,
              onUpdateMovieList: _updateMovie,
            );
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xff051650),
              title: Text(
                'filmfolio.',
                style: GoogleFonts.leagueSpartan(
                    fontWeight: FontWeight.w800,
                    fontSize: 24
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: logout,
                    icon: const Icon(
                      Icons.logout,
                      size: 25,
                    )
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _movies.isNotEmpty ? Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                  child: Text(
                    'Movies',
                    style: GoogleFonts.assistant(
                      fontWeight: FontWeight.w800,
                      fontSize: 23
                    ),
                  ),
                ) : SizedBox.shrink(),
                Expanded(child: mainContent),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _openAddMoviesModal,
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }
}

