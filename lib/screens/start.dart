import 'package:flutter/material.dart';
import 'package:moodairy/models/activity.dart';

import 'package:moodairy/models/mood.dart';
import 'package:moodairy/models/moodcard.dart';
import 'package:moodairy/widgets/activity.dart';
import 'package:moodairy/widgets/moodicon.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  MoodCard moodCard;
  String mood;
  String image;
  String datepicked;
  String timepicked;
  String datetime;
  int currentindex;
  int ontapcount = 0;
  List<Mood> moods = [
    Mood('assets/smile.png', 'Happy', false),
    Mood('assets/sad.png', 'Sad', false),
    Mood('assets/angry.png', 'Angry', false),
    Mood('assets/surprised.png', 'Surprised', false),
    Mood('assets/loving.png', 'Loving', false),
    Mood('assets/scared.png', 'Scared', false)
  ];

  List<Activity> act = [
    Activity('assets/sports.png', 'Sports', false),
    Activity('assets/sleeping.png', 'Sleep', false),
    Activity('assets/shop.png', 'Shop', false),
    Activity('assets/relax.png', 'Relax', false),
    Activity('assets/reading.png', 'Read', false),
    Activity('assets/movies.png', 'Movies', false),
    Activity('assets/gaming.png', 'Gaming', false),
    Activity('assets/friends.png', 'Friends', false),
    Activity('assets/family.png', 'Family', false),
    Activity('assets/excercise.png', 'Excercise', false),
    Activity('assets/eat.png', 'Eat', false),
    Activity('assets/date.png', 'Date', false),
    Activity('assets/clean.png', 'Clean', false)
  ];
  Color colour = Colors.white;
  void initState() {
    super.initState();
  }

  String dateonly;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('MOOD Dairy',
                style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold)),
                SizedBox(width: 5,),
                Icon(Icons.insert_emoticon , color: Colors.white , size: 25)
              ],
            ),
            backgroundColor: Colors.red),
        body: Container(
          child: Column(children: <Widget>[
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              GestureDetector(
                 onTap: (){
                   Navigator.of(context).pushNamed('/home_screen');
                 },
                 child: Column(
                   children: [
                     CircleAvatar(
                        radius: 27,
                        child: CircleAvatar(
                          child: Icon(Icons.dashboard , color: Colors.green, size: 30),
                          radius: 25,
                        backgroundColor: Colors.white  
                        ),
                        backgroundColor: Colors.green,
                      ),
                      SizedBox(height: 2.5),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                          fontSize: 15
                        )
                      )
                   ],
                 ),
             ),
             GestureDetector(
                 onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2022))
                      .then((date) => {
                            setState(() {
                              datepicked = date.day.toString() +
                                  '-' +
                                  date.month.toString() +
                                  '-' +
                                  date.year.toString();
                              dateonly = date.day.toString() +
                                  '/' +
                                  date.month.toString();
                            }),
                          }
                       );
                 },
                 child: Column(
                   children: [
                     CircleAvatar(
                     radius: 27,
                     child: CircleAvatar(
                       child: Icon(
                         Icons.calendar_today, 
                         color: Colors.blue, 
                         size: 30),
                       radius: 25,
                       backgroundColor: Colors.white  
                     ),
                      backgroundColor: Colors.blue,
                    ),
                     SizedBox(height: 2.5,),
                     Text(
                       'Pick a date',
                       style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                          fontSize: 15
                        )
                       )
                   ],
                 ),
             ),
             GestureDetector(
                 onTap: (){
                  showTimePicker(
                          context: context, initialTime: TimeOfDay.now())
                      .then((time) => {
                            setState(() {
                              timepicked = time.format(context).toString();
                            })
                          });
                 },
                 child: Column(
                   children: [
                     CircleAvatar(
                     radius: 27,
                     child: CircleAvatar(
                       child: Icon(Icons.timer , color: Colors.red, size: 30),
                       radius: 25,
                       backgroundColor: Colors.white  
                     ),
                     backgroundColor: Colors.red,
                    ),
                    SizedBox(height: 2.5,),
                     Text(
                       'Pick a time',
                       style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                          fontSize: 15
                        )
                       )
                   ],
                 ),
             ),
            ]),
            SizedBox(height: 20),
            Container(
                height: 30,
                width: 30,
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.done),
                  onPressed: () => setState(() {
                    datetime = datepicked + '   ' + timepicked;
                  }),
                ),
              ),
            SizedBox(height: 20),
            Text('WHAT YOU FEELING NOW?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height:6),
              Text('(Tap to Select and Tap again to deselect!)' , style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            
            Expanded(
                  child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: moods.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: <Widget>[
                        SizedBox(width: 15),
                        GestureDetector(
                            child: MoodIcon(
                                image: moods[index].moodimage,
                                name: moods[index].name,
                                colour: moods[index].iselected
                                    ? Colors.black
                                    : Colors.white),
                            onTap: () => {
                                  if (ontapcount == 0)
                                    {
                                      setState(() {
                                        mood = moods[index].name;
                                        image = moods[index].moodimage;
                                        moods[index].iselected = true;
                                        ontapcount = ontapcount + 1;
                                        print(mood);
                                      }),
                                    }
                                  else if (moods[index].iselected)
                                    {
                                      setState(() {
                                        moods[index].iselected = false;
                                        ontapcount = 0;
                                      })
                                    }
                                }),
                      ],
                    );
                  }),
            ),
            Text('WHAT YOU HAVE BEEN DOING?',
                style: TextStyle(fontSize: 22 ,  fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Hold on the activity to select,You can choose multiple',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            Expanded(
                          child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: act.length,
                  itemBuilder: (context, index) {
                    return Row(children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                          child: ActivityIcon(
                              act[index].image,
                              act[index].name,
                              act[index].selected
                                  ? Colors.black
                                  : Colors.white),
                          onLongPress: () => {
                                if (act[index].selected)
                                  {
                                    setState(() {
                                      act[index].selected = false;
                                    })
                                  }
                                else
                                  setState(() {
                                    act[index].selected = true;
                                    Provider.of<MoodCard>(context,
                                            listen: false)
                                        .add(act[index]);
                                  }),
                              }),
                    ]);
                  }),
            ),
            GestureDetector(
                onTap: () => {
                      setState(() {
                        Provider.of<MoodCard>(context, listen: false).addPlace(
                            datetime,
                            mood,
                            image,
                            Provider.of<MoodCard>(context, listen: false)
                                .activityimage
                                .join('_'),
                            Provider.of<MoodCard>(context, listen: false)
                                .activityname
                                .join('_'),
                            dateonly);
                      }),
                      Navigator.of(context).pushNamed('/home_screen'),
                    },
                child: Container(
                height: 38.00,
                width: 117.00,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 21.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 5,),
                    Icon(Icons.save_alt , size: 20 , color: Colors.white)
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xffff3d00),
                  border: Border.all(width: 1.00, color: Color(0xffff3d00),), borderRadius: BorderRadius.circular(19.00), 
                ), 
              ),
            ),
            SizedBox(height: 15)
          ]),
        ));
  }
}
