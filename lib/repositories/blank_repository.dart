import 'package:shopflut_blocv1/models/model.dart';

class DataDefault {
  static const int X4 = 200;
  static const double L6 = 14.4;
  static const int Z2 = 1000;
  static const double L7 = 11.00;
  static const double L8 = 13.10;
  static const double M6 = 1.10;
  static const double M10 = 12.0;
  static const double O10 = 27.0;
  static const double O11 = 22.7;
  static const double N8 = 38.2;
  static const double N9 = 42.3;
  static const double N11 = 28.7;
  static const double P6 = 19.0;
  static const double Q12 = 9.7;
  static const double Q7 = 9.0;
  static const double R9 = 18.0;
  static const double R12 = 12.8;
}

class BlankRepository {
  Future<ResultAll> result(
      BasicModel basicmodel,
      TotalConstantModel totalConstantModel,
      TANKCONSTANTModel tankconstantModel) async {
    ResultAll model = new ResultAll();
    model.result1 = Result1();
    model.result2 = Result2();

    //=X4*C30*B17
    model.result2.cANo3_2_4h2o =
        DataDefault.X4 * tankconstantModel.cANo3Nh4 * totalConstantModel.total;
    //=X15*B20*C30
    model.result2.mGNo3_2_6h2o = basicmodel.mgNo3_2_6H2o *
        tankconstantModel.mGSVl *
        totalConstantModel.total;
    //=X8*C30*B18
    model.result2.kNO3 =
        basicmodel.kNo3 * totalConstantModel.total * tankconstantModel.nNo3KMg;
    //K2SO4=X10*C30*B21
    model.result2.k2So4 =
        basicmodel.k2So4 * totalConstantModel.total * tankconstantModel.k;
    //(NH4)H2PO4==X11*C30*B19
    model.result2.nH4h2Po4 = basicmodel.nH4H2Po4 *
        totalConstantModel.total *
        tankconstantModel.nH4PK;
    //KH2PO4 = X13*B19*C30
    model.result2.kH2PO4 = basicmodel.kH2PO4 *
        tankconstantModel.cANo3Nh4 *
        totalConstantModel.total;
    //MgSO4.7H2O=X14*C30*B20
    model.result2.mGSO4_7H2o = basicmodel.mgSo4_7H2o *
        totalConstantModel.total *
        tankconstantModel.mGSVl;
    //Fe (EDTA)=X21*B20*C30
    model.result2.feEDTA =
        basicmodel.fEEDTA * tankconstantModel.mGSVl * totalConstantModel.total;
    //H3BO3=X16*C30*B20
    model.result2.h3BO3 =
        basicmodel.h3BO3 * totalConstantModel.total * tankconstantModel.mGSVl;
    //MnSO4=X17*C30*B20
    model.result2.mnSO4 =
        basicmodel.mNSO4 * totalConstantModel.total * tankconstantModel.mGSVl;
    //CuSO4=X18*C30*B20
    model.result2.cUSO4 =
        basicmodel.cUSO4 * totalConstantModel.total * tankconstantModel.mGSVl;
    //ZnSO4=X19*C30*B20
    model.result2.zNSO4 =
        basicmodel.zNSO4 * totalConstantModel.total * tankconstantModel.mGSVl;
    //(NH4)6Mo7O24·4H2O=X20*C30*B20
    model.result2.nH4_6Mo7o24_4H2o = basicmodel.nH4_6Mo_7O24_4H2O *
        totalConstantModel.total *
        tankconstantModel.mGSVl;
    /************************FORMULA ( cation/anion )**************************/
    // NO3 -=(B127*L6*10/Z$2)+(B129*L8*10/Z$2)+(B128*L7*10/Z$2)
    model.result1.nO3 = ((model.result2.cANo3_2_4h2o * DataDefault.L6 * 10) /
            DataDefault.Z2) +
        ((model.result2.kNO3 * DataDefault.L8 * 10) / DataDefault.Z2) +
        ((model.result2.mGNo3_2_6h2o * DataDefault.L7 * 10) / DataDefault.Z2);
    // NH4 += (B127*M6*10/Z$2)+(B131*M10*10/Z$2)
    model.result1.nH4 =
        ((model.result2.cANo3_2_4h2o * DataDefault.M6 * 10) / DataDefault.Z2) +
            ((model.result2.nH4h2Po4 * DataDefault.M10 * 10) / DataDefault.Z2);
    // P -=(B131*O10*10/Z$2)+(B132*O11*10/Z$2)
    model.result1.p =
        ((model.result2.nH4h2Po4 * DataDefault.O10 * 10) / DataDefault.Z2) +
            ((model.result2.kH2PO4 * DataDefault.O11 * 10) / DataDefault.Z2);
    //K + =(B129*N8*10/Z$2)+(B130*N9*10/Z$2)+(B132*N11*10/Z$2)
    model.result1.k =
        ((model.result2.kNO3 * DataDefault.N8 * 10) / DataDefault.Z2) +
            ((model.result2.k2So4 * DataDefault.N9 * 10) / DataDefault.Z2) +
            ((model.result2.kH2PO4 * DataDefault.N11 * 10) / DataDefault.Z2);
    //Ca ++ =B127*P6*10/Z$2
    model.result1.cA =
        ((model.result2.cANo3_2_4h2o * DataDefault.P6 * 10) / DataDefault.Z2);
    // Mg ++ =(B133*Q12*10/Z$2)+(B128*Q7*10/Z$2)
    model.result1.mG = ((model.result2.mGSO4_7H2o * DataDefault.Q12 * 10) /
            DataDefault.Z2) +
        ((model.result2.mGNo3_2_6h2o * DataDefault.Q7 * 10) / DataDefault.Z2);
    //S — =(B130*R9*10/Z$2)+(B133*R12*10/Z$2)
    model.result1.s = ((model.result2.k2So4 * DataDefault.R9 * 10) /
            DataDefault.Z2) +
        ((model.result2.mGSO4_7H2o * DataDefault.R12 * 10) / DataDefault.Z2);
    //N:K=(B3+B4)/B6
    model.result1.nk =
        (model.result1.nO3 + model.result1.nH4) / model.result1.k;
    //NH4:NO3=B4/B3
    model.result1.nH4nO3 = model.result1.nH4 / model.result1.nO3;
    //PPM:=B3+B4+((B5*(95/31))+B6+B7+B8+(B9*3))
    model.result1.pPM = model.result1.nO3 +
        model.result1.nH4 +
        ((model.result1.p * (95 / 31)) +
            model.result1.k +
            model.result1.cA +
            model.result1.mG +
            (model.result1.s * 3));
    //TOTAL N:=B3+B4
    model.result1.totalN = model.result1.nO3 + model.result1.nH4;

    return model;
  }
}
