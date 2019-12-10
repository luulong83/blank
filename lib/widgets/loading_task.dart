import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopflut_blocv1/widgets/scale_animation.dart';

class LoadingTask extends StatelessWidget {
  final Widget child;
  final dynamic bloc;

  LoadingTask({
    @required this.child,
    @required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
      value: bloc.loadingStream,
      initialData: false,
      child: Stack(
        children: <Widget>[
          child,
          Consumer<bool>(
            builder: (context, isLoading, child) => Center(
              child: isLoading
                  ? ScaleAnimation(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: new BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: SpinKitPouringHourglass(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
