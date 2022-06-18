import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_sdk/dynamsoft_barcode.dart';

class MyPainter extends CustomPainter {
  BarcodeResult? result;
  BuildContext context;
  MyPainter(this.result, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    double sizex = 0.57;
    double sizey = 0.5;
    Paint linePaint = Paint()..color = Color(0xffc81727)..strokeWidth = 1.5;

    canvas.drawLine(Offset(result!.x1.toDouble() * sizex, result!.y1.toDouble() * sizey),
        Offset(result!.x2.toDouble() * sizex, result!.y2.toDouble() * sizey), linePaint);

    canvas.drawLine(Offset(result!.x2.toDouble() * sizex, result!.y2.toDouble() * sizey),
        Offset(result!.x3.toDouble() * sizex, result!.y3.toDouble() * sizey), linePaint);

    canvas.drawLine(Offset(result!.x3.toDouble() * sizex, result!.y3.toDouble() * sizey),
        Offset( result!.x4.toDouble() * sizex, result!.y4.toDouble() * sizey), linePaint);

    canvas.drawLine(Offset(result!.x4.toDouble() * sizex, result!.y4.toDouble() * sizey),
        Offset(result!.x1.toDouble() * sizex, result!.y1.toDouble() * sizey), linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }

  printRe(){
    print('x1 = ${result!.x1.toDouble()}');
    print('y1 = ${result!.y1.toDouble()}');
    print('x2 = ${result!.x2.toDouble()}');
    print('y2 = ${result!.y2.toDouble()}');
    print('x3 = ${result!.x3.toDouble()}');
    print('y3 = ${result!.y3.toDouble()}');
    print('x4 = ${result!.x4.toDouble()}');
    print('y4 = ${result!.y4.toDouble()}');
  }
}