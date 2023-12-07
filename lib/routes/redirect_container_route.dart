import 'package:filmfolio/main.dart';
import 'package:flutter/material.dart';


class RedirectContainerRoute extends StatefulWidget {
  const RedirectContainerRoute({super.key});

  @override
  State<RedirectContainerRoute> createState() => _RedirectContainerRouteState();
}

class _RedirectContainerRouteState extends State<RedirectContainerRoute> {

  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = supabase.auth.currentSession;
    if (session != null) {
      final user = supabase.auth.currentUser;
      Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pushNamed(context, '/register');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}

