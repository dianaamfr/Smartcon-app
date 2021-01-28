import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/model/conference.dart';
import 'package:smartcon_app/model/user.dart';
import 'package:smartcon_app/controller/database.dart';

import '../homePage.dart';

class RateConference extends StatefulWidget {

  const RateConference({Key key, this.conference}) : super(key: key);

  final Conference conference;

  @override
  _RateConferenceState createState() => _RateConferenceState();
}

class _RateConferenceState extends State<RateConference> {
  int _rating = 5;
  int _ratingBarMode = 1;

  @override
  Widget build(BuildContext context) {
    SmartconUser user = Provider.of<SmartconUser>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Image.asset(
                            'images/pageHeader.png',
                            fit: BoxFit.fill
                        ),
                      ),
                    ],
                  ),
                ]
            ),
            Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.08,
                      right: MediaQuery
                          .of(context)
                          .size
                          .width * 0.08,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.84,
                          child: Text(widget.conference.name, style: Theme
                              .of(context)
                              .textTheme
                              .headline2,),
                          alignment: Alignment.topLeft,
                        ),
                      ],
                    ),
                  ),
                ]
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Rating: $_rating',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            _ratingBar(_ratingBarMode),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.black26, width: 2)),
                child: Text('SAVE FEEDBACK', style: TextStyle(color:Colors.black38, fontSize: 14.0,  fontWeight: FontWeight.w700, fontFamily: 'Rubik',)),
                onPressed: () async {
                  await DatabaseService().addConferenceToFeedbacks(widget.conference.confId);
                  await DatabaseService().saveFeedback(widget.conference, user.uid, _rating.toDouble());
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                          (Route<dynamic> route) => route is HomePage
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _ratingBar(int mode) {
    return RatingBar.builder(
      initialRating: 5,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      unratedColor: Color(0xFF6E96EF).withAlpha(50),
      itemCount: 5,
      itemSize: 50.0,
      itemBuilder: (context, _) =>
          Icon(
            Icons.star,
            color: Color(0xFF6E96EF),
          ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating.toInt();
        });
      },
      updateOnDrag: true,
    );
  }
}
