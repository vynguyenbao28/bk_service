import 'package:bk_service/theme/colors.dart';
import 'package:bk_service/theme/global_variable.dart';
import 'package:camera/camera.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'select_borrow_scan.dart';

class SelectBorrow extends StatefulWidget{
  String? subjects;
  SelectBorrow(this.subjects);
  @override
  State<StatefulWidget> createState() {
    return SelectBorrowPage();
  }
}
class SelectBorrowPage extends State<SelectBorrow>{

  bool switchButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.app,
      body: ListView(
        children: [
          BackButton(),
          Subject(),
          Container(height: 60),
          VerificationWidget()
        ],
      ),
      bottomNavigationBar: ScanButton(),
    );
  }

  Widget BackButton(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(10,5,10,0),
      child: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                depth: 9,
                intensity: 0.3,
                lightSource: LightSource.bottomRight,
                color: AppColors.app
            ),
            child: NeumorphicIcon(
              Icons.clear,
              size: 27,
            ),
          )
      ),
    );
  }

  Widget Subject(){
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 10),
            ],
            color: Colors.white
        ),
        child: Column(
          children: [
            Text('Tiết học sắp tới',
              style: TextStyle(color: Colors.grey),
            ),
            Container(height: 10),
            Text('Cơ học kỹ thuật - Phòng 203 D7',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        )
    );
  }

  Widget VerificationWidget(){
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 10),
          ],
          color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text('Vui lòng xác minh danh tính',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              )
          ),
          Container(height: 10),
          BarCodeWidget(),
          Container(height: 25),
          ListDevices(),
          Center(
            child: Text('Giảng viên chỉ có thể thao tác mượn thiết bị trong 60 giây',
              style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  Widget BarCodeWidget(){
    return Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(7)),
          depth: 2,
          intensity: 0.7,
          lightSource: LightSource.topLeft,
        ),
        child: Container(
          height: 85,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(width: 0.5, color: Color(0xffCBCBCBFF)),
              color: Colors.white
          ),
          child: SfBarcodeGenerator(
            value: widget.subjects,
          ),
        )
    );
  }

  Widget ListDevices(){
    return Column(
      children: [
        Text('Danh sách thiết bị', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        Container(height: 15),
        Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2 - 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemDevice('Điều khiển điều hòa', 'air_conditioner.png'),
                    ItemDevice('Cáp chuyển HDMI', 'hdmi.png'),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemDevice('Điều khiển máy chiếu', 'projector.png'),
                    ItemDevice('Micro', 'micro.png'),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget ItemDevice(String name, String image){
    return Container(
      margin: EdgeInsets.fromLTRB(0,10,10,10),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/$image', width: 25),
                Container(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(child: Text(name, style: TextStyle(fontSize: 14), maxLines: 2,)),
                    Container(height: 6),
                    Text('Có thể mượn', style: TextStyle(fontSize: 13, color: AppColors.muon)),
                  ],
                )
              ]
          )
      ),
    );
  }

  Widget ScanButton(){
    double size = MediaQuery.of(context).size.width / 7;
    return Container(
      margin: EdgeInsets.fromLTRB(size,0,size,20),
      child: Neumorphic(
          style: NeumorphicStyle(
            shape: NeumorphicShape.convex,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(22.5)),
            depth:-6,
            intensity: 0.7,
            lightSource: LightSource.bottomRight,
            color: AppColors.app,
          ),
          child: GestureDetector(
            onTap: () async {
              print(MediaQuery.of(context).size.width);
              print(MediaQuery.of(context).size.height);
              setState(() {
                rotateScreen = true;
              });
              final cameras = await availableCameras();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SelectBorrowScan(camera: cameras.first)));
            },
            child: Container(
                height: 60,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.5),
                ),
                child: Center(
                  child: Text('Quét mã',
                      style: TextStyle(fontSize: 20, color:  Colors.white)),
                )
            ),
          )
      ),
    );
  }
}