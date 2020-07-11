import 'package:flutter/material.dart';
import 'package:simplecalculator/buttons.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var UserQuestion='';
  var UserAnswer='';

  final List<String> buttons=
      [
        'AC','DEL',' % ',' / ',
        '9','8','7',' x ',
        '6','5','4',' - ',
        '3','2','1',' + ',
        '0','.','Ans',' = ',
      ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[

          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 12,),
                  Text('M a d e      B y      M o u s a m',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                    ),

                  ),

                  SizedBox(height: 20,),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(20),
                      child: Text(UserQuestion,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(UserAnswer,
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.black,
                          fontWeight: FontWeight.w300
                        ),))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              //color: Colors.deepPurple,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if(index==0)
                      {
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              UserQuestion='';
                              UserAnswer='';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.green,
                          textColor: Colors.white,
                        );
                      }
                    else if(index==1)
                      {
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              UserQuestion= UserQuestion.substring(0,UserQuestion.length-1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.red,
                          textColor: Colors.white,
                        );
                      }

                    else if(index==buttons.length-2)
                    {
                      return MyButton(
                        buttonTapped: (){
                          setState(() {
                            if(UserAnswer=='')
                              {
                                equalPressed();
                              }
                            else
                              {
                                UserQuestion=UserAnswer;
                                UserAnswer='';
                              }
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                      );
                    }

                    else if(index==buttons.length-1)
                    {
                      return MyButton(
                        buttonTapped: (){
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                      );
                    }

                    else
                      {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              UserQuestion += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index])? Colors.deepPurple : Colors.deepPurple[50],
                          textColor: isOperator(buttons[index])? Colors.white : Colors.deepPurple,
                        );
                      }

                  }),

          )
        ),
        ],
      ),
    );
  }

  bool isOperator(String x){
    if(x==' % '||x==' / '||x==' x '||x==' - '||x==' + '||x==' = '){
      return true;
    }
    return false;
  }

  void equalPressed(){
    String finalQuestion=UserQuestion;
    finalQuestion=finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    UserAnswer=eval.toString();
  }

}

