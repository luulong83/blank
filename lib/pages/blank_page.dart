import 'package:card_settings/card_settings.dart';
import 'package:card_settings/widgets/action_fields/card_settings_button.dart';
import 'package:card_settings/widgets/card_settings_panel.dart';
import 'package:card_settings/widgets/information_fields/card_settings_header.dart';
import 'package:card_settings/widgets/numeric_fields/card_settings_double.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:shopflut_blocv1/bloc/blank_bloc.dart';
import 'package:shopflut_blocv1/models/model.dart';

import 'package:shopflut_blocv1/models/result2.dart';
import 'package:shopflut_blocv1/models/tank_constant_model.dart';
import 'package:shopflut_blocv1/models/total_constant_model.dart';
import 'package:shopflut_blocv1/utils/appkey.dart';
import 'package:shopflut_blocv1/utils/helpers.dart';
import 'package:shopflut_blocv1/widgets/loading_task.dart';
import '../bloc/bloc.dart';

class BlankPage extends StatefulWidget {
  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  BlankBloc _myBloc;

  var _basicModel = BasicModel();
  var _totalconstantModel = TotalConstantModel();
  var _tankconstantModel = TANKCONSTANTModel();

  @override
  void initState() {
    super.initState();
    _myBloc = BlocProvider.of<BlankBloc>(context);
  }

  // once the form submits, this is flipped to true, and fields can then go into autovalidate mode.
  bool _showMaterialIOS = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
          title: Text('Phần mềm blank'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _onReset();
                Helpers().showToast(context, "Thông báo",
                    "Khởi tạo thành công giá trị ban đầu");
              },
            ),
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _onSave();
        },
        icon: Icon(Icons.star),
        label: Text("Kết Quả"),
      ),
      body: LoadingTask(
        bloc: _myBloc,
        child: BlocBuilder<BlankBloc, BlankState>(builder: (context, state) {
          if (state is InitialBlankState) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(new Color(0xfff5a623)),
                ),
              ),
              color: Colors.white.withOpacity(0.8),
            );
          } else if (state is ResultBlankInfo) {
            _basicModel = state.basicModelSubmit;
            _tankconstantModel = state.tankconstantModelSubmit;
            _totalconstantModel = state.totalConstantModelSubmit;
            return SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Container(
                  child: ResponsiveGridRow(children: [
                    ResponsiveGridCol(
                      xs: 12,
                      sm: 4,
                      md: 4,
                      lg: 4,
                      child: Container(
                          height: 450,
                          alignment: Alignment.center,
                          child: _buildMacroelement()),
                    ),
                    ResponsiveGridCol(
                      xs: 12,
                      sm: 4,
                      md: 4,
                      lg: 4,
                      child: Container(
                        height: 450,
                        alignment: Alignment.center,
                        child: _buildMicroelement(),
                      ),
                    ),
                    ResponsiveGridCol(
                      xs: 12,
                      sm: 4,
                      md: 4,
                      lg: 4,
                      child: Container(
                        height: 450,
                        alignment: Alignment.topCenter,
                        child: _buildBang3(),
                      ),
                    ),
                    ResponsiveGridCol(
                      child: Container(
                        height: 80,
                        alignment: Alignment.center,
                        child: _buildCardSettingsButtonSave(),
                      ),
                    ),
                    ResponsiveGridCol(
                      xs: 12,
                      sm: 6,
                      md: 6,
                      lg: 6,
                      child: Container(
                        height: 750,
                        alignment: Alignment.center,
                        child: _buildResult1(state.result1),
                      ),
                    ),
                    ResponsiveGridCol(
                      xs: 12,
                      sm: 6,
                      md: 6,
                      lg: 6,
                      child: Container(
                        height: 750,
                        alignment: Alignment.center,
                        child: _buildResult2(state.result2),
                      ),
                    )
                  ]),
                ),
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }

  _buildMacroelement() {
    return CardSettings(
      padding: 17.0,
      cardElevation: 20.0,
      children: <Widget>[
        CardSettingsHeader(
          label: 'Macroelement (Basic:gam/1000L)',
          labelAlign: TextAlign.left,
          height: 60.0,
        ),
        CardSettingsDouble(
          key: Appkey.caNo3_2_4H2oKey,
          label: 'Ca(No3)2.4H2o',
          unitLabel: 'gam',
          contentAlign: TextAlign.center,
          showMaterialIOS: _showMaterialIOS,
          initialValue: _basicModel.caNo3_2_4H2o,
          onSaved: (value) => _basicModel.caNo3_2_4H2o = value,
          onChanged: (value) {
            _basicModel.caNo3_2_4H2o = value;
          },
        ),
        CardSettingsDouble(
          key: Appkey.mgNo3_2_6H2oKey,
          label: 'Mg(NO3)2.6H2O',
          unitLabel: 'gam',
          contentAlign: TextAlign.center,
          showMaterialIOS: _showMaterialIOS,
          initialValue: _basicModel.mgNo3_2_6H2o,
          onSaved: (value) => _basicModel.mgNo3_2_6H2o = value,
          onChanged: (value) {
            _basicModel.mgNo3_2_6H2o = value;
          },
        ),
        CardSettingsDouble(
          key: Appkey.kN03Key,
          label: 'KNO3',
          unitLabel: 'gam',
          contentAlign: TextAlign.center,
          showMaterialIOS: _showMaterialIOS,
          initialValue: _basicModel.kNo3,
          onSaved: (value) => _basicModel.kNo3 = value,
          onChanged: (value) {
            _basicModel.kNo3 = value;
          },
        ),
        CardSettingsDouble(
          key: Appkey.k2So4Key,
          label: 'K2SO4',
          unitLabel: 'gam',
          contentAlign: TextAlign.center,
          showMaterialIOS: _showMaterialIOS,
          initialValue: _basicModel.k2So4,
          onSaved: (value) => _basicModel.k2So4 = value,
          onChanged: (value) {
            _basicModel.k2So4 = value;
          },
        ),
        CardSettingsDouble(
          key: Appkey.nH4H2Po4Key,
          label: '(NH4)H2PO4',
          unitLabel: 'gam',
          contentAlign: TextAlign.center,
          showMaterialIOS: _showMaterialIOS,
          initialValue: _basicModel.nH4H2Po4,
          onSaved: (value) => _basicModel.nH4H2Po4 = value,
          onChanged: (value) {
            _basicModel.nH4H2Po4 = value;
          },
        ),
        CardSettingsDouble(
          key: Appkey.kH2PO4Key,
          label: 'KH2PO4',
          unitLabel: 'gam',
          contentAlign: TextAlign.center,
          showMaterialIOS: _showMaterialIOS,
          initialValue: _basicModel.kH2PO4,
          onSaved: (value) => _basicModel.kH2PO4 = value,
          onChanged: (value) {
            _basicModel.kH2PO4 = value;
          },
        ),
        CardSettingsDouble(
          key: Appkey.mgSo47H2oKey,
          label: 'MgSO4.7H2O',
          unitLabel: 'gam',
          contentAlign: TextAlign.center,
          showMaterialIOS: _showMaterialIOS,
          initialValue: _basicModel.mgSo4_7H2o,
          onSaved: (value) => _basicModel.mgSo4_7H2o = value,
          onChanged: (value) {
            _basicModel.mgSo4_7H2o = value;
          },
        ),
      ],
    );
  }

  _buildMicroelement() {
    return CardSettings(padding: 17.0, cardElevation: 20.0, children: <Widget>[
      CardSettingsHeader(
        label: 'Microelement (Basic:gam/1000L)',
        labelAlign: TextAlign.left,
        height: 60.0,
      ),
      CardSettingsDouble(
        key: Appkey.fEEDTAKey,
        label: 'Fe(EDTA)',
        unitLabel: 'gam',
        contentAlign: TextAlign.center,
        showMaterialIOS: _showMaterialIOS,
        initialValue: _basicModel.fEEDTA,
        onSaved: (value) => _basicModel.fEEDTA = value,
        onChanged: (value) {
          _basicModel.fEEDTA = value;
        },
      ),
      CardSettingsDouble(
        key: Appkey.h3BO3Key,
        label: 'H3BO3',
        unitLabel: 'gam',
        contentAlign: TextAlign.center,
        showMaterialIOS: _showMaterialIOS,
        initialValue: _basicModel.h3BO3,
        onSaved: (value) => _basicModel.h3BO3 = value,
        onChanged: (value) {
          _basicModel.h3BO3 = value;
        },
      ),
      CardSettingsDouble(
        key: Appkey.mNSO4Key,
        label: 'MnSO4',
        unitLabel: 'gam',
        contentAlign: TextAlign.center,
        showMaterialIOS: _showMaterialIOS,
        initialValue: _basicModel.mNSO4,
        onSaved: (value) => _basicModel.mNSO4 = value,
        onChanged: (value) {
          _basicModel.mNSO4 = value;
        },
      ),
      CardSettingsDouble(
        key: Appkey.cUSO4Key,
        label: 'CuSO4',
        unitLabel: 'gam',
        contentAlign: TextAlign.center,
        showMaterialIOS: _showMaterialIOS,
        initialValue: _basicModel.cUSO4,
        onSaved: (value) => _basicModel.cUSO4 = value,
        onChanged: (value) {
          _basicModel.cUSO4 = value;
        },
      ),
      CardSettingsDouble(
        key: Appkey.zNSO4Key,
        label: 'ZnSO4',
        unitLabel: 'gam',
        contentAlign: TextAlign.center,
        showMaterialIOS: _showMaterialIOS,
        initialValue: _basicModel.zNSO4,
        onSaved: (value) => _basicModel.zNSO4 = value,
        onChanged: (value) {
          _basicModel.zNSO4 = value;
        },
      ),
      CardSettingsDouble(
        key: Appkey.nH4_6Mo_7O24_4H2OKey,
        label: '(NH4)6Mo7O24·4H2O',
        unitLabel: 'gam',
        contentAlign: TextAlign.center,
        showMaterialIOS: _showMaterialIOS,
        initialValue: _basicModel.nH4_6Mo_7O24_4H2O,
        onSaved: (value) => _basicModel.nH4_6Mo_7O24_4H2O = value,
        onChanged: (value) {
          _basicModel.nH4_6Mo_7O24_4H2O = value;
        },
      ),
    ]);
  }

  _buildBang3() {
    return CardSettings(padding: 17.0, cardElevation: 20.0, children: <Widget>[
      CardSettingsHeader(
        label: 'Fertilizer constant',
        labelAlign: TextAlign.left,
        height: 60.0,
      ),
      CardSettingsDouble(
        showMaterialIOS: _showMaterialIOS,
        key: Appkey.mtotalconstantKey,
        label: 'BLOCK',
        labelAlign: TextAlign.center,
        contentAlign: TextAlign.center,
        initialValue: _totalconstantModel.total,
        onSaved: (value) => _totalconstantModel.total = value,
        onChanged: (value) {
          _totalconstantModel.total = value;
        },
      ),
      CardSettingsHeader(
        label: 'Each tank constant',
        labelAlign: TextAlign.left,
        height: 60.0,
      ),
      CardSettingsDouble(
        showMaterialIOS: _showMaterialIOS,
        key: Appkey.cANo3Nh4Key,
        label: 'Ca; NO3; NH4',
        labelAlign: TextAlign.center,
        contentAlign: TextAlign.center,
        initialValue: _tankconstantModel.cANo3Nh4,
        onSaved: (value) => _tankconstantModel.cANo3Nh4 = value,
        onChanged: (value) {
          _tankconstantModel.cANo3Nh4 = value;
        },
      ),
      CardSettingsDouble(
        showMaterialIOS: _showMaterialIOS,
        key: Appkey.nNo3KMgKey,
        label: 'NO3; K; Mg',
        labelAlign: TextAlign.center,
        contentAlign: TextAlign.center,
        initialValue: _tankconstantModel.nNo3KMg,
        onSaved: (value) => _tankconstantModel.nNo3KMg = value,
        onChanged: (value) {
          _tankconstantModel.nNo3KMg = value;
        },
      ),
      CardSettingsDouble(
        showMaterialIOS: _showMaterialIOS,
        key: Appkey.nH4PKKey,
        label: 'NH4; P; K',
        labelAlign: TextAlign.center,
        contentAlign: TextAlign.center,
        initialValue: _tankconstantModel.nH4PK,
        onSaved: (value) => _tankconstantModel.nH4PK = value,
        onChanged: (value) {
          _tankconstantModel.nH4PK = value;
        },
      ),
      CardSettingsDouble(
        showMaterialIOS: _showMaterialIOS,
        key: Appkey.mGSVlKey,
        label: 'Mg; S; VL',
        labelAlign: TextAlign.center,
        contentAlign: TextAlign.center,
        initialValue: _tankconstantModel.mGSVl,
        onSaved: (value) => _tankconstantModel.mGSVl = value,
        onChanged: (value) {
          _tankconstantModel.mGSVl = value;
        },
      ),
      CardSettingsDouble(
        showMaterialIOS: _showMaterialIOS,
        key: Appkey.kKey,
        label: 'K',
        labelAlign: TextAlign.center,
        contentAlign: TextAlign.center,
        initialValue: _tankconstantModel.k,
        onSaved: (value) => _tankconstantModel.k = value,
        onChanged: (value) {
          _tankconstantModel.k = value;
        },
      )
    ]);
  }

  CardSettingsButton _buildCardSettingsButtonSave() {
    return CardSettingsButton(
      showMaterialIOS: _showMaterialIOS,
      label: 'KẾT QUẢ',
      onPressed: () {
        _onSave();
      },
    );
  }

  _buildResult1(Result1 model) {
    return CardSettings(padding: 17.0, cardElevation: 20.0, children: <Widget>[
      CardSettingsHeader(label: 'ION'),
      CardSettingsField(
        label: 'NO3 -',
        unitLabel: 'ppm',
        labelAlign: TextAlign.end,
        content: Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child: Text(
            model.nO3.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
          ),
        ),
      ),
      CardSettingsField(
        label: 'NH4 +',
        unitLabel: 'ppm',
        labelAlign: TextAlign.end,
        content: Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child: Text(
            model.nH4.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
          ),
        ),
      ),
      CardSettingsField(
        label: 'P -',
        unitLabel: 'ppm',
        labelAlign: TextAlign.end,
        content: Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child: Text(
            model.p.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
          ),
        ),
      ),
      CardSettingsField(
        label: 'K +',
        unitLabel: 'ppm',
        labelAlign: TextAlign.end,
        content: Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child: Text(
            model.k.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
          ),
        ),
      ),
      CardSettingsField(
        label: 'Ca ++',
        unitLabel: 'ppm',
        labelAlign: TextAlign.end,
        content: Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child: Text(
            model.cA.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
          ),
        ),
      ),
      CardSettingsField(
        label: 'Mg ++',
        unitLabel: 'ppm',
        labelAlign: TextAlign.end,
        content: Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child: Text(
            model.mG.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
          ),
        ),
      ),
      CardSettingsField(
        label: 'S --',
        unitLabel: 'ppm',
        labelAlign: TextAlign.end,
        content: Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child: Text(
            model.s.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
          ),
        ),
      ),
      CardSettingsHeader(label: "TỶ LỆ ION"),
      CardSettingsField(
        label: 'N:H',
        unitLabel: 'ppm',
        labelAlign: TextAlign.end,
        content: Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child: Text(
            model.nk.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
          ),
        ),
      ),
      CardSettingsField(
        label: 'NH4:NO3',
        unitLabel: 'ppm',
        labelAlign: TextAlign.end,
        content: Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child: Text(
            model.nH4nO3.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
          ),
        ),
      ),
      CardSettingsField(
        label: 'PPM',
        unitLabel: 'ppm',
        labelAlign: TextAlign.end,
        content: Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child: Text(
            model.pPM.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
          ),
        ),
      ),
      CardSettingsField(
        label: 'TOTAL N',
        unitLabel: 'ppm',
        labelAlign: TextAlign.end,
        content: Padding(
          padding: const EdgeInsets.only(right: 70.0),
          child: Text(
            model.totalN.toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
          ),
        ),
      ),
    ]);
  }

  _buildResult2(Result2 model) {
    return CardSettings(padding: 17.0, cardElevation: 20.0, children: <Widget>[
      CardSettingsHeader(label: 'Loại phân (Basic: gam/1000L)'),
      CardSettingsField(
        label: 'Ca(NO3)2.4H2O',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.cANo3_2_4h2o.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
      CardSettingsField(
        label: 'Mg(NO3)2.6H2O',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.mGNo3_2_6h2o.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
      CardSettingsField(
        label: 'KNO3',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.kNO3.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
      CardSettingsField(
        label: 'K2SO4',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.k2So4.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
      CardSettingsField(
        label: '(NH4)H2PO4',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.nH4h2Po4.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
      CardSettingsField(
        label: 'KH2PO4',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.kH2PO4.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
      CardSettingsField(
        label: 'MgSO4.7H2O',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.mGSO4_7H2o.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
      CardSettingsField(
        label: 'Fe (EDTA)',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.feEDTA.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
      CardSettingsField(
        label: 'H3BO3',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.h3BO3.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
      CardSettingsField(
        label: 'MnSO4',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.mnSO4.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
      CardSettingsField(
        label: 'CuSO4',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.cUSO4.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
      CardSettingsField(
        label: 'ZnSO4',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.zNSO4.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
      CardSettingsField(
        label: '(NH4)6Mo7O24·4H2O',
        unitLabel: 'gam',
        labelAlign: TextAlign.end,
        content: Text(
          model.nH4_6Mo7o24_4H2o.toStringAsFixed(2),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.red),
        ),
      ),
    ]);
  }

  _onReset() {
    _myBloc.add(InitBlankInfoEvent());
  }

  _onSave() {
    _myBloc.add(SubmitBlank(
        basicModel: _basicModel,
        totalConstantModel: _totalconstantModel,
        tankconstantModel: _tankconstantModel));
  }
}
