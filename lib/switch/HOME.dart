import 'package:bk_service/switch/switch_home.dart';
import 'package:bk_service/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomePage();
}

class HomePage extends State<Home> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  CollectionReference account = FirebaseFirestore.instance.collection('account');

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: AppColors.app,
            title: Image.asset('assets/eHUST.png', width: 100),
            actions: [
              IconButton(
                onPressed: (){

                },
                icon: Icon(
                  Icons.notifications,
                ),
              )
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              SwitchHome(),
              SwitchHome(),
              SwitchHome(),
            ],
          ),
          bottomNavigationBar: Container(
              margin: EdgeInsets.all(5),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                border: Border.all(width: 0.8, color: Colors.grey),
                color: Colors.white,
              ),
              // color: Colors.white,
              child: TabBar(
                isScrollable: false,
                indicator:BoxDecoration(),
                controller: _tabController,
                unselectedLabelColor: Color(0xffa4a4a4),
                labelColor: AppColors.app,
                tabs: [
                  Tab(
                      icon: Icon(Icons.home_outlined, size: 27),
                      child: Text('Trang chủ',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),textAlign: TextAlign.center, overflow: TextOverflow.visible, maxLines: 1, softWrap: false)
                  ),
                  Tab(
                      icon: Icon(Icons.search, size: 27,),
                      child: Text('Tra cứu',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),textAlign: TextAlign.center, overflow: TextOverflow.visible, maxLines: 1, softWrap: false)
                  ),
                  Tab(
                      icon: Icon(Icons.person_outline, size: 27),
                      child: Text('Thông tin',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),textAlign: TextAlign.center, overflow: TextOverflow.visible, maxLines: 1, softWrap: false)
                  ),
                ],
              )),
        ),
        Container(
            margin: EdgeInsets.only(top: 40,left: 30),
            height: 40,
            child: Image.asset('assets/logoBK.png')
        ),
      ],
    );
  }
}