import 'package:flutter/material.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        accentColor: Colors.green,
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 30
            )
          )
        )
      ),
      title: 'Calculator App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variable
  double minimumPadding=10.0; //you can use var
  var isDouble=false;
  var num1=0.0;
  var num2=0.0;
  var operand='';

  //create object
  TextEditingController displayController=TextEditingController();

  //methods
  Widget buildButton(String text,Function handler){
    return Expanded(
      child: RaisedButton(
        child: Text(
          text,
          style:TextStyle(
            fontSize: 25,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          )
        ),
        onPressed: handler,
      ),
    );
  }

  void digitHandler(String char){
    displayController.text=displayController.text+char;
  }

  void pointHandler(){
    if(isDouble==false) {
      displayController.text = displayController.text + '.';
      isDouble=true;
    }
  }

  void cleHandler(){
    num1=0.0;
    num2=0.0;
    operand='';
    isDouble=false;
    displayController.clear();
  }

  void delHandler(){
    String result=displayController.text;
    if(result.length>0) {
      displayController.text = result.substring(0, result.length - 1);
    }else if(result.length==0){
      displayController.clear();
    }
  }

  void signHandler() {
    String result = displayController.text;
    double num = double.parse(result);
    if (num == 0) {
      return;
    }
    num = num * -1;
    if (num * 10 % 10 == 0) {
      displayController.text = num.toStringAsFixed(0);
    } else {
      displayController.text = num.toString();
    }
  }

    void operandHandler(String text){
      num1=double.parse(displayController.text);
      switch(text){
        case '+':
        operand='+';
        break;

        case '-':
          operand='-';
          break;

        case '*':
          operand='*';
          break;

        case '/':
          operand='/';
          break;
      }
         displayController.clear();
      isDouble=false;
    }

    void equalHandler(){
    num2=double.parse(displayController.text);
    displayController.clear();
    double result;
    switch(operand){
      case '+':
        result=num1+num2;
        break;

      case '-':
        result=num1-num2;
        break;

      case '*':
        result=num1*num2;
        break;

      case '/':
        result=num1/num2;
        break;
    }
    if(result==null){
      return;
    }
    displayController.text=result.toString();
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Calculator')),
      ),
      body: Container(
        margin: EdgeInsets.all(minimumPadding*2),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: minimumPadding,bottom: minimumPadding),
              child: TextField(
                style: Theme.of(context).textTheme.title,
                showCursor: true,
                readOnly: true,
                controller: displayController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular((10))
                  )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding*3,bottom: minimumPadding),
              child: Row(
                children: <Widget>[
                  buildButton('7',(){digitHandler('7');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('8',(){digitHandler('8');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('9',(){digitHandler('9');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('-',(){operandHandler('-');}),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding,bottom: minimumPadding),
              child: Row(
                children: <Widget>[
                  buildButton('4',(){digitHandler('4');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('5',(){digitHandler('5');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('6',(){digitHandler('6');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('+',(){operandHandler('+');}),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding,bottom: minimumPadding),
              child: Row(
                children: <Widget>[
                  buildButton('1',(){digitHandler('1');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('2',(){digitHandler('2');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('3',(){digitHandler('3');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('*',(){operandHandler('*');}),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding,bottom: minimumPadding),
              child: Row(
                children: <Widget>[
                  buildButton('.',(){pointHandler();}),
                  SizedBox(width: minimumPadding,),
                  buildButton('0',(){digitHandler('0');}),
                  SizedBox(width: minimumPadding,),
                  buildButton('+/-',(){signHandler();}),
                  SizedBox(width: minimumPadding,),
                  buildButton('/',(){operandHandler('/');}),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding,bottom: minimumPadding),
              child: Row(
                children: <Widget>[
                  buildButton('DEL',(){delHandler();}),
                  SizedBox(width: minimumPadding,),
                  buildButton('=',(){equalHandler();}),
                  SizedBox(width: minimumPadding,),
                  buildButton('CLEAR',(){cleHandler();}),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
