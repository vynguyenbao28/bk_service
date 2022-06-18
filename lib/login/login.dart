import 'package:bk_service/switch/HOME.dart';
import 'package:bk_service/theme/app_function.dart';
import 'package:bk_service/theme/colors.dart';
import 'package:bk_service/theme/global_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => LoginPage();
}

class LoginPage extends State<Login> {
  final textAccount = TextEditingController();
  final textPass = TextEditingController();

  bool checkBox = false;
  bool checkButton = false;
  bool checkPassFaild = false;
  bool checkAccountFaild = false;
  bool checkSignInFaild = false;
  bool _passwordVisible = false;

  CollectionReference account = FirebaseFirestore.instance.collection('account');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  checkInternet() async{
    var result = await Connectivity().checkConnectivity();
    switch(result){
      case ConnectivityResult.wifi:
        setState(() {
          isConnected = true;
        });
        break;
      case ConnectivityResult.mobile:
        setState(() {
          isConnected = true;
        });
        break;
      case ConnectivityResult.none:
        setState(() {
          isConnected = false;
        });
        break;
      case ConnectivityResult.bluetooth:
      // TODO: Handle this case.
        break;
      case ConnectivityResult.ethernet:
      // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkInternet();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Hello(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Email(),
                  SizedBox(height: 20),
                  Password(),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  RememberMe(),
                  SizedBox(height: 40),
                  SignInButton(),
                  LoginWithFinger(),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget Hello(){
    return Stack(
      children: [
        Image.asset('assets/title_login.png',
          height: MediaQuery.of(context).size.width*0.69,alignment: Alignment.centerLeft,
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 70),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('BK-Service,', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w300)),
              Container(
                padding: EdgeInsets.only(left: 40),
                child: Text('Xin chào!', style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w500)),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget Email(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val){
        if (checkButton){
          const pattern = r'^[\w-\.]+@([hust]+\.[edu]+\.)+[\w-]{2,4}$';
          final regExp = RegExp(pattern);
          if (val == null || val.isEmpty) {
            return '* Nhập email';
          }
          if (!regExp.hasMatch(val)) {
            return '* Nhập dạng @hust.edu.vn';
          }
          if (checkAccountFaild){
            return '* Không tìm thấy người dùng';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'EMAIL',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(fontSize: 19, color: AppColors.app),
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1.5, color: AppColors.app,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1.5,color: AppColors.app),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1.5,color: AppColors.app)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1.5,color: AppColors.app)
        ),
      ),
      style: TextStyle(fontSize: 17, height: 1.2, color: (AppColors.app)),
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.next,
      controller: textAccount,
      cursorColor: AppColors.app,
    );
  }

  Widget Password(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val){
        if (checkButton){
          if(val!.isEmpty){
            return '* Nhập mật khẩu';
          }
          else if(val.length < 6){
            return '* Mật khẩu ít nhất cần 6 ký tự';
          }
          else if (checkPassFaild){
            return '* Mật khẩu không hợp lệ';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'MẬT KHẨU',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(fontSize: 19, color: AppColors.app),
        isDense: true,
        filled: true,
        // hintStyle: TextStyle(fontSize: 17,
        //     color: AppColors.app),
        // hintText: 'Mật khẩu',
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1.5, color: AppColors.app),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1.5,color: AppColors.app),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1.5,color: AppColors.app)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1.5,color: AppColors.app)
        ),
        suffixIcon: IconButton(
          splashRadius: 17,
          icon: Icon(
            _passwordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: AppColors.app,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      style: TextStyle(fontSize: 17, height: 1.2, color: (AppColors.app)),
      obscureText: !_passwordVisible,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.send,
      controller: textPass,
      cursorColor: AppColors.app,
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return AppColors.app;
  }

  Widget RememberMe(){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(5,0,5,0),
          height: 20,
          width: 20,
          child: Checkbox(
            side: BorderSide(width: 1.5, color: AppColors.app),
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: checkBox,
            onChanged: (bool? value) {
              setState(() {
                checkBox = value!;
              });
            },
          ),
        ),
        Text('Lưu tài khoản', style: TextStyle(color: AppColors.app, fontSize: 13)),
      ],
    );
  }

  Widget SignInButton(){
    return  ElevatedButton(
      onPressed: () async {
        if (isConnected == false) {
          AppFunction().notification('Vui lòng kết nối Internet', context);
        } else {
          setState(() {
            checkButton = true;
            checkPassFaild = false;
            checkAccountFaild = false;
            checkSignInFaild = false;
          });
          if (_formKey.currentState!.validate()) {
            SignIn(false);
          };
        }
      },
      child: Ink(
        decoration: BoxDecoration(
            gradient:
            const LinearGradient(colors: [Color(0xffb34859), Color(0xff851224)]),
            borderRadius: BorderRadius.circular(10)),
        child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Center(
              child: Text('Đăng nhập',
                  style: TextStyle(fontSize: 18, color:  Colors.white)),
            )
        ),
      ),
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          primary: AppColors.app),
    );
  }

  SignIn(bool loginMode) async {
    AppFunction().LoadingDialog(context);
    String passLogin = textPass.text;
    if (loginMode){
      await account.doc(textAccount.text).get().then((DocumentSnapshot pass){
        passLogin = pass['password'];
      });
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: textAccount.text, password: passLogin);
      if (!checkPassFaild && !checkAccountFaild && !checkSignInFaild){
        Navigator.of(context).pop();
        account.doc('${textAccount.text}').set({
          'password': '$passLogin',
        });
        FirebaseAuth.instance.currentUser!.updateDisplayName('Nguyễn Bảo Vỹ');
        // CollectionReference getuuid = account.doc('${textAccount.text}').collection('uuid');
        // QuerySnapshot querySnapshot = await getuuid.get();
        // List<DocumentSnapshot> countUuid = querySnapshot.docs;
        // if (countUuid.length == 1){
        //
        // }
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
        if (checkBox){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', textAccount.text);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.message == 'The password is invalid or the user does not have a password.'){
        setState(() {
          checkPassFaild = true;
        });
      }
      if (e.message == 'There is no user record corresponding to this identifier. The user may have been deleted.') {
        setState(() {
          checkAccountFaild = true;
        });
      }
      if (e.message == 'We have blocked all requests from this device due to unusual activity. Try again later.') {
        setState(() {
          checkSignInFaild = true;
        });
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            title: Text("Ôi bạn ơi"),
            content: Text('Lỗi đăng nhập mất rồi. Vui lòng thử lại sau vài phút :('),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Xác nhận'),
              )
            ],
          ),
        );
      }
      Navigator.of(context).pop();
    }
  }

  Widget LoginWithFinger(){
    return TextButton.icon(
        onPressed: (){
          // if (_canCheckBiometric){
          //   if (textAccount.text != ''){
          //     _authenticate();
          //   } else AppFunction().notification('Vui lòng nhập Email', context);
          // } else AppFunction().notification('Thiết bị không hỗ trợ vân tay', context);;
        },
        icon: Icon(Icons.fingerprint, color: AppColors.app),
        label: Text('Đăng nhập bằng vân tay', style: TextStyle(color: AppColors.app))
    );
  }
}