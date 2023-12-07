import 'package:filmfolio/routes/login_route.dart';
import 'package:filmfolio/routes/movies_route.dart';
import 'package:filmfolio/routes/redirect_container_route.dart';
import 'package:filmfolio/routes/register_route.dart';
import 'package:filmfolio/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://srtekwvfwygkoyzjbwsh.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNydGVrd3Zmd3lna295empid3NoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE3NDk4MTUsImV4cCI6MjAxNzMyNTgxNX0.EGrlCMORFRa7wOdfgWVovvPX6q3GN5HhRJf5EoW33AI"
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: '/redirect',
      routes: {
        '/redirect': (context) => const RedirectContainerRoute(),
        '/login': (context) => const LoginRoute(),
        '/register': (context) => const RegisterRoute(),
        '/home': (context) => const MoviesRoute(),
      },
    );
  }
}

PageRouteBuilder _routeWithAnimation(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}



final supabase = Supabase.instance.client;


