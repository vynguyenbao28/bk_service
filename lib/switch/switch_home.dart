import 'package:bk_service/theme/colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../select_switch/select_switch_borrow/select_borrow.dart';

class SwitchHome extends StatefulWidget {
  @override
  State<SwitchHome> createState() => SwitchHomePage();
}

class SwitchHomePage extends State<SwitchHome> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(height: 18),
        User(),
        Calendar(),
        ListSelect()
      ],
    );
  }

  Widget User(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Image.asset('assets/user.png', width: 40,),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Nguyễn Bảo Vỹ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.text)),
              ),
              Container(
                height: 15,
                width: 1.5,
                color: Colors.grey,
              ),
              Text('  20175927', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey)),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 25,
            child: IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.calendar_month_outlined, color: AppColors.app, size: 25),
            ),
          )
        ],
      )
    );
  }

  Widget Calendar(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(height: 20),
          Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  depth: 2,
                  lightSource: LightSource.topLeft,
                  color: Colors.grey,
                  border: NeumorphicBorder(
                    color: Color(0x33000000),
                    width: 0.2,
                  )
              ),
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              )
          )
        ],
      ),
    );
  }

  NavigatorMode(String name) {
    //String obText = '{"n": "${FirebaseAuth.instance.currentUser!.displayName}"}';
    String obText = '{"e": "vy.nb@hust.edu.vn"}';
    switch (name) {
      case 'Lịch giảng dạy':
        //Navigator.push(context, MaterialPageRoute(builder: (context) => SelectBorrow()));
        break;
      case 'Mượn thiết bị':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SelectBorrow(obText)));
        break;
      case 'Danh sách lớp':
        //Navigator.push(context, MaterialPageRoute(builder3: (context) => SelectBorrow()));
        break;
      case 'Lịch thi':
        //Navigator.push(context, MaterialPageRoute(builder: (context) => SelectBorrow()));
        break;
      case 'Thông báo tin tức':
        //Navigator.push(context, MaterialPageRoute(builder: (context) => SelectBorrow()));
        break;
      case 'Bản đồ':
        //Navigator.push(context, MaterialPageRoute(builder: (context) => SelectBorrow()));
        break;
    }
  }

  Widget SelectMode(String image, String title, String content){
    return Column(
      children: [
        Container(height: 20),
        TextButton(
          child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                depth: 3,
                lightSource: LightSource.topLeft,
                color: Colors.grey,
              ),
              child: Container(
                width: 90,
                height: 90,
                padding: EdgeInsets.all(23),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(blurRadius: 6, color: Colors.grey)],
                  color: Colors.white,
                ),
                child: Image.asset('assets/$image', color: AppColors.mode,),
              )
          ),
          onPressed: (){
            NavigatorMode(title);
          },
        ),
        Container(height: 10),
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.text),
          textAlign: TextAlign.center,
        ),
        Container(height: 5),
        Text(
            content,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: AppColors.text),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget ListSelect(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.4,
              child: SelectMode('schedule.png', 'Lịch giảng dạy', 'Tra cứu lịch giảng\ndạy'),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.4,
              child: SelectMode('borrow.png', 'Mượn thiết bị', 'Mượn thiết bị phòng\nhọc'),
            ),
          ],
        ),
        Container(height: MediaQuery.of(context).size.width / 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 2.4,
                child: SelectMode('list_person.png', 'Danh sách lớp', 'Thông tin các lớp\ngiảng dạy')
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.4,
              child: SelectMode('test.png', 'Lịch thi', 'Thông tin lịch thi\ncác lớp'),
            )
          ],
        ),
        Container(height: MediaQuery.of(context).size.width / 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.4,
              child: SelectMode('newspaper.png', 'Thông báo tin tức', 'Các thông báo\nquan trọng'),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.4,
              child: SelectMode('location.png', 'Bản đồ', 'Bản đồ trường\nhọc'),
            )
          ],
        ),
      ],
    );
  }
}

class EmailCode {
  String? e;

  EmailCode({this.e});

  EmailCode.fromJson(Map<String, dynamic> json) {
    e = json['e'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['e'] = this.e;
    return data;
  }
}
