import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/model/user.dart';
import 'package:smartcon_app/view/profile.dart';
import 'package:smartcon_app/view/sessionSuggestions/sessionSuggestionsCode.dart';
import 'package:smartcon_app/controller/auth.dart';
import 'package:smartcon_app/controller/database.dart';
import '../wrapper.dart';
import 'conferenceSuggestions/searchConferences.dart';
import 'insertConference/insertConference.dart';
import 'package:smartcon_app/view/rateConference/rateConferenceCode.dart';

class HomePage extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key('home_page'),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset('images/homeHeader.png', fit: BoxFit.fill),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.18,
            ),
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "SmartCon",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "Your number one Conference & Session advisor",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Rubik',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.08,
                    top: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: RaisedButton(
                    onPressed: () async {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Wrapper()),
                          (Route<dynamic> route) => route is HomePage);
                      await _auth.signOutGoogle();
                    },
                    color: Color(0xFF6E96EF),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "SIGN OUT",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.08,
                    top: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: RaisedButton(
                    key: Key('manage_profile_btn'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                    color: Color(0xFF6E96EF),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "MANAGE PROFILE",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  )),
            ],
          ),
          //Manage Profile Button
        ],
      ),
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.15,
        ),
        child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width * 0.6,
          child: RaisedButton(
            color: Color(0xFF6E96EF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            highlightElevation: 20.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WrapperConferences()),
              );
            },
            child: Text(
              "Search Conferences",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
      Text("Already have a ticket?",
          style: TextStyle(
            color: Color(0xFF6E96EF),
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Rubik',
          )),
      ButtonTheme(
        minWidth: MediaQuery.of(context).size.width * 0.6,
        child: RaisedButton(
          color: Color(0xFF6E96EF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          highlightElevation: 20.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SessionSuggestionsCode()),
            );
          },
          child: Text(
            "Session Sugestions",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
      ButtonTheme(
        minWidth: MediaQuery.of(context).size.width * 0.6,
        child: RaisedButton(
          color: Color(0xFF6E96EF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          highlightElevation: 20.0,
          onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => RateConferenceCode()),);
          },
          child: Text(
            "Leave feedback",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text("Organizing a conference?",
          style: TextStyle(
            color: Color(0xFF5BBDB8),
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Rubik',
          )),
      ButtonTheme(
        minWidth: MediaQuery.of(context).size.width * 0.6,
        child: RaisedButton(
          key: Key('insert_conference_btn'),
          color: Color(0xFF5BBDB8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          highlightElevation: 20.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InsertConference()),
            );
          },
          child: Text(
            "Insert Conference",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    ])));
  }
}

class WrapperConferences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return either Manage Profile or Search conferences
    final user = Provider.of<SmartconUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            if (userData.district != '' && userData.interests.isNotEmpty)
              return SearchConferences();
            else
              return Profile();
          } else {
            return Container();
          }
        });
  }
}
