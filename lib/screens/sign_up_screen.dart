import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test4/res/custom_colors.dart';
import 'package:flutter_test4/screens/user_info_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> information() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: '동계현장실습',
    home: Scaffold(
      appBar: AppBar(title: Text('동계현장실습'),),
      body: SignUpScreen(),
    ),
  ));
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String nickname ='';
  String gender = '';
  String area = '';
  String aboutMe = '';
  String inputs = '';
  final _valueList = ['선택','여성', '남성'];
  var _selectdValue = '선택';

  final _formKey = GlobalKey<FormState>();

  // 임시 컨트롤러 값저장?
  final amountInputController1 = TextEditingController();
  final amountInputController2 = TextEditingController();
  final amountInputController3 = TextEditingController();
  //User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('동계현장실습'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
            }
        ),
        backgroundColor: CustomColors.firebaseOrange,
      ),
      body: Form(
        key: _formKey,
        child:Column(
          children: <Widget>[
            Container(
              child: TextFormField(
                controller: amountInputController1,
                style: TextStyle(fontSize: 16, color: CustomColors.firebaseGrey),
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: '닉네임을 입력해 주세요.'),
                onChanged: (value1) {
                  setState((){
                    nickname = value1;
                  });
                  },
                validator: (nickname) {
                  if(nickname!.length < 1){
                    return '닉네임은 필수 입력 값입니다.';
                  }
                  return null;
                  },
              ),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              width: 500,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text("성별     "),
                  ),
                  Container(
                    child: DropdownButtonFormField(
                      value: _selectdValue,
                      items: _valueList.map(
                            (value){
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                              },
                      ).toList(),
                      onChanged: (value){
                        setState(() {
                          _selectdValue = value as String;
                        });
                        },
                      validator: (value){
                        if(value == _valueList[0]){
                          return '성별은 필수 입력 값입니다.';
                        }
                      },
                    ),
                    width: 300,
                  ),
                ],
              ),
            ),
            Container(
              child: TextFormField(
                controller: amountInputController2,
                style: TextStyle(fontSize: 16, color: CustomColors.firebaseGrey),
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: '살고 있는 지역을 입력해 주세요.'),
                onChanged: (value2) {
                  setState((){
                    area = value2;
                  });
                  },
                validator: (area) {
                  if(area!.length < 1){
                    return '살고 있는 지역은 필수 입력 값입니다.';
                  }
                  return null;
                  },
              ),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              width: 500,
            ),
            Container(
              child: TextFormField(
                controller: amountInputController3,
                style: TextStyle(fontSize: 16, color: CustomColors.firebaseGrey),
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: '자기소개를 입력해 주세요.'),
                onChanged: (value3) {
                  setState((){
                    aboutMe = value3;
                  });
                  },
                validator: (aboutMe) {
                  if(aboutMe!.length < 1){
                    return '닉네임은 필수 입력 값입니다.';
                  }
                  return null;
                  },
              ),
              padding: EdgeInsets.only(top: 10, bottom: 40),
              width: 500,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                primary: Colors.white,
                backgroundColor: Colors.redAccent,
                minimumSize: Size(200,50),
              ),
              onPressed: () {
                //파이어베이스 데이터 넣는 부분
                firestore.collection('member').doc(user.uid).set({
                  '닉네임':nickname,
                  '성별':_selectdValue,
                  '지역':area,
                  '자기소개':aboutMe,
                });
                if(_formKey.currentState!.validate()) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          UserInfoScreen(
                            user: user,
                          ),
                    ),
                  );
                }
                },
              child: Text("회원가입 완료"),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      )
    );
  }
}
