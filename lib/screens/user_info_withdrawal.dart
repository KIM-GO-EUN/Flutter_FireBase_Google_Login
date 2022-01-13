import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test4/res/custom_colors.dart';
import 'package:flutter_test4/screens/sign_in_screen.dart';
import 'package:flutter_test4/utils/authentication.dart';

// 회원 탈퇴 부분

// 회원 탈퇴 부분

Future<void> information() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: '동계현장실습',
    home: Scaffold(
      appBar: AppBar(title: Text('동계현장실습'),),
      body: UserInfoWithdrawal(),
    ),
  ));
}

class UserInfoWithdrawal extends StatefulWidget {
  const UserInfoWithdrawal({Key? key}) : super(key: key);

  @override
  State createState() => UserInfoWithdrawalState();
}

class UserInfoWithdrawalState extends State<UserInfoWithdrawal> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('동계현장실습'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              SignInScreen();
            }
        ),
        backgroundColor: CustomColors.firebaseOrange,
      ),
      body: Column(
        children: <Widget>[
          Row(),
          const SizedBox(height: 24.0),
          Text(
            '정말 탈퇴하시겠습니까? 닉네임/성별/지역/자기소개 저장된 정보가 모두 사라집니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: CustomColors.firebaseBlack.withOpacity(0.8),
                fontSize: 25,
                letterSpacing: 0.2),
          ),

          const SizedBox(height: 16.0),
          _isSigningOut
              ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.redAccent,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () async {
              // 사용자 계정 삭제 부분 임의 삽입
              FirebaseAuth.instance.currentUser!.delete();
              fireStore.collection('member').doc(user.uid).delete();
              setState(() {
                _isSigningOut = true;
              });
              await Authentication.signOut(context: context);
              setState(() {
                _isSigningOut = false;
              });
              Navigator.of(context)
                  .pushReplacement(_routeToSignInScreen());
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                '탈퇴하기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),

        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
