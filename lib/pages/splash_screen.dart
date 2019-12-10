import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopflut_blocv1/bloc/blank_bloc.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shopflut_blocv1/repositories/blank_repository.dart';
import '../bloc/bloc.dart';
import 'blank_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green,
      body: BlocListener<AppinitialisationBloc, AppinitialisationState>(
          listener: (context, state) {
        print(state);
        if (state is InitialisationComplete) {
          BlankRepository blankRepository = BlankRepository();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
            return BlocProvider(
              create: (context) => BlankBloc(blankRepository: blankRepository)
                ..add(InitBlankInfoEvent()),
              child: BlankPage(),
            );
          }));
          // Find the Scaffold in the widget tree and use it to show a SnackBar.
          //Scaffold.of(context).showSnackBar(snackBar);
        }
      }, child: BlocBuilder<AppinitialisationBloc, AppinitialisationState>(
        builder: (context, state) {
          if (state is Initialising) {
            // return Center(
            //   child: Container(
            //     height: 20,
            //     width: MediaQuery.of(context).size.width * 0.9,
            //     child: LiquidLinearProgressIndicator(
            //       value: state.progress / 100,
            //       direction: Axis.horizontal,
            //       center: Text('${state.progress} %'),
            //     ),
            //   ),
            // );
            return Stack(
              children: <Widget>[
                Center(
                  child: new Image.asset(
                    'assets/images/logo.png',
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.none,
                  ),
                ),
                Positioned(
                  bottom: 100,
                  left: 0.3,
                  right: 0.3,
                  child: Center(
                    child: Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: LiquidLinearProgressIndicator(
                        value: state.progress / 100,
                        direction: Axis.horizontal,
                        center: Text('${state.progress} %'),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return Container();
        },
      )),
    );
  }
}
