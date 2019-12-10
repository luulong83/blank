import 'package:flutter/cupertino.dart';
import 'package:shopflut_blocv1/models/model.dart';

@immutable
abstract class BlankEvent {}

class InitBlankInfoEvent extends BlankEvent {}

class SubmitBlank extends BlankEvent {
  final BasicModel basicModel;
  final TotalConstantModel totalConstantModel;
  final TANKCONSTANTModel tankconstantModel;

  SubmitBlank(
      {@required this.basicModel,
      @required this.totalConstantModel,
      @required this.tankconstantModel});
}
