
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
            title: Text('MOOD Dairy',
                style: TextStyle(
                    fontStyle: FontStyle.normal, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red),
        body: Container(
          child: Column(children: <Widget>[
            FlatButton.icon(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/home_screen'),
                icon: Icon(Icons.dashboard),
                label: Text('Go to Dashboard')),
            Row(children: <Widget>[
              SizedBox(width: 70),
              FlatButton.icon(
                  icon: Icon(Icons.date_range),
                  label: Text('Pick a date'),
                  onPressed: () => showDatePicker(
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
                          })),
              FlatButton.icon(
                  icon: Icon(Icons.timer),
                  label: Text('Pick a Time'),
                  onPressed: () => showTimePicker(
                          context: context, initialTime: TimeOfDay.now())
                      .then((time) => {
                            setState(() {
                              timepicked = time.format(context).toString();
                            })
                          })),
              Container(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  child: Icon(Icons.done),
                  onPressed: () => setState(() {
                    datetime = datepicked + '   ' + timepicked;
                  }),
                ),
              )
            ]),
            SizedBox(height: 40),
            Text('WHAT YOU FEELING NOW?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('(Tap to Select!)'),
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
                                  if (moods[index].iselected)
                                    {
                                      setState(() {
                                        moods[index].iselected = false;
                                      })
                                    }
                                  else
                                    {
                                      moods.forEach((f) => setState((){f.iselected =false;})),
                                      setState(() {
                                        mood = moods[index].name;
                                        image = moods[index].moodimage;
                                        moods[index].iselected = true;
                                        print(mood);
                                      }),
                                    }
                                }),
                      ],
                    );
                  }),
            ),
            Text('WHAT YOU HAVE BEEN DOING?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Tap on the activity to select,You can choose multiple',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
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
                          onTap: () => {
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
            FlatButton.icon(
                onPressed: () => {
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
                icon: Icon(Icons.send),
                label: Text(
                  'SUBMIT',
                  style: TextStyle(color: Colors.black),
                ))
          ]),
        ));
  }
}

