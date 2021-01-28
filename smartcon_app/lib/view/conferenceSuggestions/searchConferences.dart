import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/model/conference.dart';
import 'package:smartcon_app/controller/database.dart';

import '../profile.dart';
import 'conferenceList.dart';

class SearchConferences extends StatefulWidget {
  SearchConferences({Key key}) : super(key: key);

  @override
  _SearchConferences createState() => _SearchConferences();
}

class _SearchConferences extends State<SearchConferences> {
  bool _rating = false;
  bool _near = false;
  List<DateTime> _dates = [];
  String datesStr = 'Must Pick a date';

  _onDateChanged(picked) {
    setState(() {
      _dates = picked;
      datesStr = "FROM: " +
          _dates[0].toString().substring(0, 10) +
          "\nTO: " +
          _dates[1].toString().substring(0, 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Conference>>.value(
      value: DatabaseService().conferences,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // HEADER IMAGE (100%)
              Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('images/pageHeader.png', fit: BoxFit.fill),
                ),
              ]),

              // CONTENT ROW
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08,
                    right: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Page title
                      Container(
                        width: MediaQuery.of(context).size.width * 0.84,
                        child: Text(
                          "Search Conferences",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        alignment: Alignment.topLeft,
                      ),

                      //Manage Profile Button
                      SizedBox(height: 10),
                      RaisedButton(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black26, width: 2)),
                        highlightElevation: 40.0,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                        child: Text("MANAGE PROFILE",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Rubik',
                            )),
                      ),

                      SizedBox(height: 20),
                      Text(
                        'DATE',
                        style: Theme.of(context).textTheme.headline3,
                      ),

                      // Date Picker
                      SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.84,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.54,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 2.0, color: Colors.black26),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Text(datesStr,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Rubik',
                                  )),
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: ButtonTheme(
                                height: 50,
                                child: MaterialButton(
                                    color: Color(0xFF6E96EF),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    highlightElevation: 40.0,
                                    onPressed: () async {
                                      final List<DateTime> picked =
                                          await DateRagePicker.showDatePicker(
                                        context: context,
                                        initialFirstDate: new DateTime.now(),
                                        initialLastDate: (new DateTime.now())
                                            .add(new Duration(days: 7)),
                                        firstDate: new DateTime(2020),
                                        lastDate: new DateTime(2022),
                                      );
                                      if (picked != null &&
                                          picked.length == 2) {
                                        print(picked);
                                        _onDateChanged(picked);
                                      }
                                    },
                                    child: Text(
                                      "CHANGE",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.84,
                        // Rating Checkbox
                        child: Row(children: <Widget>[
                          // Rating
                          Checkbox(
                            value: _rating,
                            onChanged: (bool value) {
                              setState(() {
                                _rating = value;
                              });
                            },
                          ),
                          Text(
                            "SORT BY RATING",
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.center,
                          ),
                        ]),
                      ),

                      // District cehckbox
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.84,
                        child: Row(children: [
                          Checkbox(
                            value: _near,
                            onChanged: (bool value) {
                              setState(() {
                                _near = value;
                              });
                            },
                          ),
                          Text(
                            "ONLY NEAR YOU",
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.center,
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ]),

              Row(
                children: [
                  ConferenceList(
                      filterDistrict: _near,
                      ratingOrder: _rating,
                      dates: _dates)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
