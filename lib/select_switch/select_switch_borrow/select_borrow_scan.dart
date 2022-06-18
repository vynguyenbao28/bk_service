import 'package:bk_service/theme/colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_sdk/dynamsoft_barcode.dart';
import 'package:flutter_barcode_sdk/flutter_barcode_sdk.dart';

import '../../theme/app_function.dart';
import 'my_painter.dart';

class SelectBorrowScan extends StatefulWidget{
  SelectBorrowScan({
    required this.camera,
  });
  final CameraDescription camera;
  @override
  State<StatefulWidget> createState() {
    return SelectBorrowScanPage();
  }
}

class SelectBorrowScanPage extends State<SelectBorrowScan>{

  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  FlutterBarcodeSdk? _barcodeReader;
  bool cameraValue = false;

  bool _isScanAvailable = true;
  bool _isScanRunning = false;

  bool flashButton = false;
  bool cameraButton = false;
  bool videoButton = false;

  List<double> x = [];

  String _barcodeResults = '';
  List<BarcodeResult> barcodeResultsList = [];

  int resultLength = 0;

  firstCamera(CameraDescription camera) async {
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller!.initialize();
    _initializeControllerFuture.then((_) {
      setState(() {});
    });
    _barcodeReader = FlutterBarcodeSdk();
    await _barcodeReader!.setLicense('DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTE2NDk4Mjk3OTI2MzUiLCJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSIsInNlc3Npb25QYXNzd29yZCI6IndTcGR6Vm05WDJrcEQ5YUoifQ==');
    await _barcodeReader!.init();
  }

  videoScan() async {
    if (!_isScanRunning) {
      _isScanRunning = true;
      await _controller!.startImageStream((CameraImage availableImage) async {
        assert(defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS);
        int format = FlutterBarcodeSdk.IF_UNKNOWN;
        switch (availableImage.format.group) {
          case ImageFormatGroup.yuv420:
            format = FlutterBarcodeSdk.IF_YUV420;
            break;
          case ImageFormatGroup.bgra8888:
            format = FlutterBarcodeSdk.IF_BRGA8888;
            break;
          default:
            format = FlutterBarcodeSdk.IF_UNKNOWN;
        }
        if (!_isScanAvailable) {
          return;
        }
        _isScanAvailable = false;
        _barcodeReader!
            .decodeImageBuffer(
            availableImage.planes[0].bytes,
            availableImage.width,
            availableImage.height,
            availableImage.planes[0].bytesPerRow,
            format)
            .then((results) {
          if (_isScanRunning) {
            setState(() {
              _barcodeResults = getBarcodeResults(results);
              barcodeResultsList = results;
            });
          }
          _isScanAvailable = true;
        }).catchError((error) {
          _isScanAvailable = false;
        });
      });
    }
    else {
      setState(() {
        _barcodeResults = '';
      });
      _isScanRunning = false;
      await _controller!.stopImageStream();
    }
  }

  String getBarcodeResults(List<BarcodeResult> results) {
    StringBuffer sb = new StringBuffer();
    for (BarcodeResult result in results) {
      sb.write(result.format);
      sb.write('\n|x1 ${result.x1}');
      sb.write('|y1 ${result.y1}\n');
      sb.write('|x2 ${result.x2}');
      sb.write('|y2 ${result.y2}\n');
      sb.write('|x3 ${result.x3}');
      sb.write('|y3 ${result.y3}\n');
      sb.write('|x4 ${result.x4}');
      sb.write('|y4 ${result.y4}\n');
      sb.write('tỷ lệ ${MediaQuery.of(context).size.width}/${MediaQuery.of(context).size.height} ');
      sb.write("\n");
      sb.write(result.text);
      sb.write("\n\n");
    }
    if (results.isEmpty) sb.write("Không tìm thấy");
    return sb.toString();
  }

  @override
  void initState() {
    AppFunction().RotateHor();
    firstCamera(widget.camera);
    super.initState();
  }

  @override
  void dispose() {
    AppFunction().RotateVer();
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (BarcodeResult result in barcodeResultsList) {
      for (int i = 0; i<1; i++){
        MyPainter(result, context).printRe();
      }

    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: RotatedBox(
                quarterTurns: 4,
                child: CameraPreview(_controller!)
            ),
          ),
          // LayoutBuilder(
          //   builder: (BuildContext context, BoxConstraints constraints) {
          //     return CustomPaint(
          //       painter: MyPainter(context),
          //       size: Size(constraints.maxWidth, constraints.maxHeight),
          //     );
          //   },
          // ),
          for (BarcodeResult result in barcodeResultsList)
            (_barcodeResults == '')
                ? Container()
                : Container(
                    padding: EdgeInsets.all(20),
                    child: SquareScan(result),
                  ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Row(children: <Widget>[
              Text(
                _barcodeResults,
                style: TextStyle(fontSize: 14, color: Colors.black),
              )
            ]),
          ),
          Positioned(
            child: RightButton(context),
            right: 0,
          ),
          Positioned(
            child: TitleScan(),
            bottom: 20,
          ),
        ],
      ),
    );
  }

  Widget FlashButton(){
    return IconButton(
        onPressed: () async {
          if (!flashButton){
            await _controller?.setFlashMode(FlashMode.always);
          }
          else {
            await _controller?.setFlashMode(FlashMode.off);
          }
          setState(() {
            flashButton = !flashButton;
          });
        },
        icon: Image.asset(
          (flashButton)
              ? 'assets/flash_on.png'
              : 'assets/flash_off.png',
          width: 50,
        )

    );
  }

  Widget ScanButton(){
    return GestureDetector(
      onTap: () async {
        setState(() {
          videoButton = !videoButton;
        });
        try {
          await _initializeControllerFuture;
          videoScan();
        } catch (e) {
          print('đang dính lỗi $e');
        }
      },
      child: (!videoButton)
          ? Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                ),
                Container(
                    height: 63,
                    width: 63,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(31.5)),
                        color: AppColors.app
                    ),
                ),
              ],
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                ),
                Container(
                  height: 27,
                  width: 27,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      color: AppColors.app
                  ),
                ),
              ],
            )
    );
  }

  Widget CameraButton(){
    return IconButton(
      onPressed: () async {
        final cameras = await availableCameras();
        setState(() {
          cameraValue = !cameraValue;
        });
        if (cameraValue){
          firstCamera(cameras[1]);
        } else firstCamera(widget.camera);
      },
      icon: Image.asset('assets/flip_camera.png', width: 50)
    );
  }

  Widget RightButton(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlashButton(),
          ScanButton(),
          CameraButton(),
        ],
      ),
      color: Colors.black.withOpacity(0.55),
    );
  }

  Widget SquareScan(BarcodeResult result){
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return CustomPaint(
          painter: MyPainter(result, context),
          size: Size(constraints.maxWidth, constraints.maxHeight),
        );
      },
    );
  }
  
  Widget TitleScan(){
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black.withOpacity(0.4)
      ),
      child: Text('Đang quét mã ...', style: TextStyle(color: Colors.white),),
    );
  }
}