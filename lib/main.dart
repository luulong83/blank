import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopflut_blocv1/pages/splash_screen.dart';
import 'bloc/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: BlocProvider<AppinitialisationBloc>(
        //   builder: (context) => AppinitialisationBloc()..add(AppLaunched()),
        //   child: SplashPage(),
        // )
        home: BlocProvider(
          create: (context) => AppinitialisationBloc()..add(AppLaunched()),
          child: SplashPage(),
        ));
  }
}
