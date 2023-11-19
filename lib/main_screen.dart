import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 메인화면 (stf)
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController introduceController = TextEditingController();
  bool isEditMode = false; // 자기소개 수정모드 상태값
  @override
  void initState() {
    // 위젯이 처음 실행되었을 때 이곳을 호출함.
    getIntroduceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.eco_rounded,
          color: Colors.green,
          size: 32,
        ),
        backgroundColor: Colors.white,
        elevation: 0, //그림자
        title: Text(
          '발전하는 개발자 허수진을 소개합니다.',
          style: TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              child: Image.asset(
                'assets/img_me.png',
              ), //fit: 사진 비율을 무시하고 채워넣는 것
            ),

            /// 이름 섹션
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      '이름',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('허수진')
                ],
              ),
            ),

            /// 나이 섹션
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      '나이',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('23')
                ],
              ),
            ),

            /// 취미 섹션
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      '취미',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('음악 감상')
                ],
              ),
            ),

            /// 직업 섹션
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      '직업',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('학생')
                ],
              ),
            ),

            /// 학력
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      '학력',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('성결대 재학')
                ],
              ),
            ),

            /// MBTI 섹션
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      'MBTI',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('ENFP+ENFJ')
                ],
              ),
            ),

            ///자기소개 입력필드
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    '자기소개',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                //이미지 아이콘의 클릭기능 구현하기
                GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(right: 16, top: 16),
                      child: Icon(
                        Icons.mode_edit,
                        color: isEditMode == true
                            ? Colors.blueAccent
                            : Colors.black,
                        size: 24,
                      ),
                    ),
                    onTap: () async {
                      if (isEditMode == false) {
                        setState(() {
                          //위젯 다시 업데이트 되려면 setState
                          isEditMode = true;
                        });
                      } else {
                        if (introduceController.text.isEmpty) {
                          // 입력필드 값이 비어있으면 empty check

                          //snackbar 메세지로 사용자에게 알려줘야됨
                          var snackbar = SnackBar(
                            content: Text('자기소개란을 입력해주세요.'),
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);

                          return; // 밑에 저장 로직 수행하지 않고 여기서 메서드 종료시켜버림
                        }
                        //저장 로직 구현
                        var sharedPref = await SharedPreferences.getInstance();
                        sharedPref.setString(
                            'introduce', introduceController.text); //문자열 저장

                        setState(() {
                          isEditMode = false;
                        });
                      }
                    }),
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  maxLines: 5,
                  controller: introduceController,
                  enabled: isEditMode, // 아이콘 클릭하면 활성화되고 다시 클릭하면 활성화 못하게
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xffd9d9d9)),
                  )),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> getIntroduceData() async {
    // 기존의 소개 텍스트 가져오기
    var sharedPref = await SharedPreferences.getInstance();
    String introduceMsg = sharedPref.getString('introduce').toString();
    introduceController.text = introduceMsg ?? ""; //null합류 연산자
  }
}
