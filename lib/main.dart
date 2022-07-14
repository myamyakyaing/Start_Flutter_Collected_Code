import 'dart:ffi';
import 'dart:ui';
import 'dart:math';
import 'package:demo/question.dart';
import 'package:demo/quiz_brain.dart';
import 'package:english_words/english_words.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/audio_cache.dart';
import 'package:flutter/material.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(Quizzler());

  //for dice page class
  // return runApp(
  //   MaterialApp(
  //     home: Scaffold(
  //       backgroundColor: Colors.red,
  //       appBar: AppBar(
  //         title: Text('Dicee'),
  //         backgroundColor: Colors.red,
  //       ),
  //       body: DicePage(),
  //     ),
  //   ),
  // );
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreTrueKeeper = [
     Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),
    Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),
    Icon(
      Icons.check,
      color: Colors.green,
    ),
  ];

  List<Icon> scoreFalseKeeper = [
    Icon(
      Icons.close,
      color: Colors.red,
    ),
    Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),
    Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    ),
  ];

  int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
         Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(questionNumber),
                //'This is where the question text will go.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {

              bool correctAnswer = quizBrain.getQuestionAnswer(questionNumber);
              if(correctAnswer == true){
                quizBrain.nextQuestion();
              }else{
                quizBrain.stayQuestion();
              }

              //for first line of bottom bar
                if(scoreTrueKeeper.length >= 12) {
                  scoreTrueKeeper.clear();
                }
                int count = 0;
                setState(() {
                  count = Random().nextInt(10) + 1;
                  if(count == count%2){
                    scoreTrueKeeper.add(
                        const Icon(
                          Icons.check,
                          color: Colors.green,)
                    );
                  }else{
                    scoreTrueKeeper.add(
                        const Icon(
                          Icons.close,
                          color: Colors.red,)
                    );
                  }

                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {

                bool correctAnswer = quizBrain.getQuestionAnswer(questionNumber);
                if(correctAnswer == false){
                  quizBrain.nextQuestion();
                }else{
                  quizBrain.stayQuestion();
                }

                //for first line of bottom bar
                int count = 0;
                if(scoreFalseKeeper.length >= 12) {
                  scoreFalseKeeper.clear();
                }
                setState(() {
                  count = Random().nextInt(10) + 1;
                  if(count == count%2){
                    scoreFalseKeeper.add(
                      const Icon(
                        Icons.close,
                        color: Colors.red,)

                    );
                  }else{
                    scoreFalseKeeper.add(
                        const Icon(
                          Icons.check,
                          color: Colors.green,)
                    );
                  }

                });
              },
            ),
          ),
        ),
       Padding(
         padding: EdgeInsets.all(15.0),
         child: Row(
           children: scoreTrueKeeper,
         ),
       ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: scoreFalseKeeper,
          ),
        )
      ],
    );
  }
}

class SoundXylophoneApp extends StatelessWidget {
  const SoundXylophoneApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const XylophoneApp(),
    );
  }
}

class XylophoneApp extends StatefulWidget {
  const XylophoneApp({Key? key}) : super(key: key);

  @override
  State<XylophoneApp> createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  @override
  Widget build(BuildContext context) {
    void playSound(int soundNumber) {
      final player = AudioCache();
      player.play('assets_note$soundNumber.wav');
    }

    Expanded buildKey(Color color, int soundNumber) {
      int increaseCount = 0;
      return Expanded(
        child: MaterialButton(
          color: color,
          onPressed: () {
            increaseCount = Random().nextInt(7) + 1;
            playSound(increaseCount);// you can use soundNumber if you want to original sound
          },
          child: const Text('Play'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildKey(Colors.deepOrange, 1),
                buildKey(Colors.yellow, 2),
                buildKey(Colors.green, 3),
                buildKey(Colors.red, 4),
                buildKey(Colors.blue, 5),
                buildKey(Colors.purple, 6),
                buildKey(Colors.indigo, 7),
              ],
            ),
        ),
      ),
    );
  }
}

class ImageSetUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Center(child: Text("I Am Rich")),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                child: Card(
                  color: Colors.lightBlue[100],
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: Padding(
                    padding:  EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(color: Colors.lightGreen[900], child: Image(width: 100.0, height: 100.0, image: NetworkImage('https://wallpaperaccess.com/full/12311.jpg'))),//get from url),
                        Image(width: 100.0, height: 100.0, image: AssetImage('images/cat2.jpeg')), //get from local),
                    ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Card(
                  color: Colors.lightBlue[200],
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: Padding(
                    padding:  EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image(width: 100.0, height: 100.0, image: AssetImage('images/cat2.jpeg')), //get from local),
                        Card(color: Colors.lightGreen[900], child: Image(width: 100.0, height: 100.0, image: NetworkImage('https://wallpaperaccess.com/full/12311.jpg'))),//get from url),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Card(
                  color: Colors.lightBlue[300],
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: Padding(
                    padding:  EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(color: Colors.lightGreen[900], child: Image(width: 100.0, height: 100.0, image: NetworkImage('https://wallpaperaccess.com/full/12311.jpg'))),//get from url),
                        Image(width: 100.0, height: 100.0, image: AssetImage('images/cat2.jpeg')), //get from local),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyAttributeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        //Note : one layout must have one child
        //Note : In Column attribute, CrossAxisAlignment.stretch (Width value cannot be add)
        //Note : In Row attribute, CrossAxisAlignment.stretch (Height value cannot be add)
        body: SafeArea(
          child: Container(
            color: Colors.blueGrey[900],
            child: Row( // you can set Row in here
              mainAxisSize: MainAxisSize.max, // .min = wrap_parent, .max = fill_parent or match_parent
              //verticalDirection: VerticalDirection.up, // .up = sort the widgets down to up of user create and .down = sort the according to user create
              //mainAxisAlignment: MainAxisAlignment.start,// .start/.center/.end = set the top/center/bottom of widgets
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,// .spaceEvenly = divide the same space of widget that include space and user created widget
              //mainAxisAlignment: MainAxisAlignment.spaceAround,// .spaceEvenly = divide the same space of widget, but start the top of about margin 45
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,// .spaceEvenly = divide the same space of widget, but start the top of widget
              //crossAxisAlignment: CrossAxisAlignment.end, //.start/.center/.end = set the top/center/bottom of widgets
              crossAxisAlignment: CrossAxisAlignment.stretch, //.stretch = if not container of width in children, fill the require space
              children: [
                Container(
                  //width: double.infinity,
                  width: 100.0,
                  //margin: EdgeInsets.all(20.0), //take 20 of the four sides(left,top,right and bottom)
                  //margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0), //take vertical(top&button) and horizontal(left&right)
                  //margin: EdgeInsets.fromLTRB(30.0, 10.0, 50.0, 20.0), //LTRB means Left, Top, Right and Bottom
                  //margin: EdgeInsets.only(bottom: 30.0), //you can take the customize side
                  //padding: EdgeInsets.all(20.0), // padding like as the margin attributes, but padding take the inside of widget and margin take the outside of widget
                  color: Colors.white,
                  child: Text('Container 1'),
                ),
                SizedBox(
                  //height: 20.0, //for column attribute
                  width: 20.0, //for row attribute
                ),
                Container(
                  //width: double.infinity,
                  width: 100.0,
                  //margin: EdgeInsets.only(bottom: 30.0),
                  color: Colors.blue,
                  child: Text("Container2"),
                ),
                Container(
                  //width: double.infinity,
                  width: 100.0,
                  //margin: EdgeInsets.only(bottom: 30.0),
                  color: Colors.red,
                  child: Text("Container3"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SketchLoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        //Note : one layout must have one child
        //Note : In Column attribute, CrossAxisAlignment.stretch (Width value cannot be add)
        //Note : In Row attribute, CrossAxisAlignment.stretch (Height value cannot be add)
        body: SafeArea(
          child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 50.0, backgroundImage: AssetImage('images/cat1.jpeg'),),
                  Center(
                    child: Text(
                      'Kyaing Kyaing',
                      style: TextStyle(
                          fontFamily: 'Lobster',
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      'FLUTTER DEVELOPER',
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                          color: Colors.teal.shade100,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                      child: Padding(
                        padding:  EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(Icons.phone, size: 30.0, color: Colors.teal,),
                            SizedBox(width: 10.0),
                            Text(
                              '+959 09123456789',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 20.0,
                                  color: Colors.teal.shade100,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                      child: Padding(
                        padding:  EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(Icons.mail, size: 30.0, color: Colors.teal,),
                            SizedBox(width: 10.0),
                            Text(
                              'abcdef@gmail.com',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 20.0,
                                  color: Colors.teal.shade100,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: Text(
                      'LIST TITLE CODE',
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                          color: Colors.teal.shade100,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0, width: 180.0, child: Divider(color: Colors.teal.shade100,),),
                  Container(
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(Icons.phone, color: Colors.teal),
                        title: Text(
                          '+959 09123456789',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20.0,
                              color: Colors.teal.shade100,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                      child: ListTile(
                        leading: Icon(Icons.mail, color: Colors.teal),
                        title: Text(
                          'abcdef@gmail.com',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20.0,
                              color: Colors.teal.shade100,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}

class Challenge1App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.teal,
          body: SafeArea(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 100,
                    color: Colors.blue,
                    child: Center(child: Text("Column 1"),),
                  ),
                  Container(
                    width: 150,
                    color: Colors.blueGrey[900],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            color: Colors.red,
                            child: Center(child: Text("Sub 1"),),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.green,
                            child: Center(child: Text("Sub 1"),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Center(child: Text("Column 3"),),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}


class DicePage extends StatefulWidget{
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage>{
  int leftDiceNo = 1;
  int rightDiceNo = 1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded( //show user created widgets within the SafeArea. Not show the oveflow error
            child:  FlatButton(
              onPressed: changeDiceFace,
              child: Image(
                image: AssetImage('images/dice$leftDiceNo.png'),
              ),
            ),
          ),
          Expanded(
              child:  FlatButton(onPressed: changeDiceFace,child: Image.asset('images/dice$rightDiceNo.png'))
          ),
        ],
      ),
    );
  }

  void changeDiceFace(){
    setState(() {
      leftDiceNo = Random().nextInt(6) + 1;
      rightDiceNo = Random().nextInt(6) + 1;
    });
  }

}


class BallPage extends StatefulWidget{
  @override
  _BallPageState createState() => _BallPageState();

}

class _BallPageState extends State<BallPage> {
  int ballNo = 1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          title: const Center(child: Text("Ask Me Anything")),
          backgroundColor: Colors.blue[900],
        ),
        body: Center(
          child: FlatButton(
            onPressed: changeBallMessage,
            child: Image(
              image: AssetImage('images/ball$ballNo.png'), //get from local
            ),
          ),
        ),
      ),
    );
  }

  void changeBallMessage(){
    setState(() {
      ballNo = Random().nextInt(5) + 1;
    });
  }
}
