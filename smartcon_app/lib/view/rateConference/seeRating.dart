import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartcon_app/model/conference.dart';

import '../homePage.dart';

class SeeRating extends StatefulWidget {

  const SeeRating({Key key, this.conference, this.rating}) : super(key: key);

  final Conference conference;
  final int rating;

  @override
  _SeeRatingState createState() => _SeeRatingState();
}

class _SeeRatingState extends State<SeeRating> {

  @override
  Widget build(BuildContext context) {
    int _rating = widget.rating;
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
              'Your Rating: $_rating',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _starsForRatings(_rating)
              ),
            ),
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
                child: Text('RETURN TO HOMEPAGE', style: TextStyle(color:Colors.black38, fontSize: 14.0,  fontWeight: FontWeight.w700, fontFamily: 'Rubik',)),
                onPressed: () async {
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

  List<Icon>_starsForRatings(int rating) {
    List<Icon> stars = [];
    for(int i = 0; i < rating; i++){
      stars.add(Icon(Icons.star, color: Color(0xFF637DEB), size: 50.0));
    }
    return stars; }
}
