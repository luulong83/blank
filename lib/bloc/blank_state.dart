import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopflut_blocv1/models/model.dart';
import 'package:shopflut_blocv1/models/result2.dart';

@immutable
abstract class BlankState {}

class InitialBlankState extends BlankState {}

class LoadingBlankState extends BlankState {}

class ResultBlankInfo extends BlankState {
  final BasicModel basicModelSubmit;
  final TotalConstantModel totalConstantModelSubmit;
  final TANKCONSTANTModel tankconstantModelSubmit;
  final Result1 result1;
  final Result2 result2;

  ResultBlankInfo(
      {@required this.basicModelSubmit,
      @required this.totalConstantModelSubmit,
      @required this.tankconstantModelSubmit,
      @required this.result1,
      @required this.result2});
}
