import 'package:bk_service/theme/colors.dart';
import 'package:bk_service/theme/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animations/loading_animations.dart';

class AppFunction{

  notification(String s, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$s',
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Color(0xff898989),
      duration: Duration(milliseconds: 2500),
      shape: StadiumBorder(),
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    ));
  }

  LoadingDialog(BuildContext context){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return Center(
            child: LoadingBouncingGrid.square(
              inverted: true,
              backgroundColor: AppColors.app,
              borderSize: 3,
              size: 50,
              duration: Duration(milliseconds: 1350),
            )
          );
        });
  }

  RotateHor(){

    if (rotateScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
  }

  RotateVer(){
    rotateScreen = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}