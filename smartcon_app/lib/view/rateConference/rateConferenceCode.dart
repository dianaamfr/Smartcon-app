import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/model/conference.dart';
import 'package:smartcon_app/model/user.dart';
import 'package:smartcon_app/view/rateConference/rateConference.dart';
import 'package:smartcon_app/view/rateConference/seeRating.dart';
import 'package:smartcon_app/controller/database.dart';

class RateConferenceCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RateConferenceCodeState();
  }
}

class RateConferenceCodeState extends State<RateConferenceCode> {

  final GlobalKey<FormState> _confCodeKey = GlobalKey<FormState>();

  String _code;

  Widget _conferenceCode(List<Conference> conferences) {
    final user = Provider.of<SmartconUser>(context);

    Conference _getConference(){
      for(int i = 0; i< conferences.length; i++){
        if(conferences[i].confId == _code)
          return conferences[i];
      }
    }

    _handleConferenceCode() async{
      await DatabaseService(uid: user.uid).addConferenceToFeedbacks(_code);
      List<String> feedback = await DatabaseService(uid: user.uid).getUserFeedbackOnConference(_code);

      if (feedback.isEmpty) {
        Navigator.push( context, MaterialPageRoute(builder: (context) =>
            RateConference(conference: _getConference(),)), );
      }
      else{
        Navigator.push( context, MaterialPageRoute(builder: (context) =>
            SeeRating(conference: _getConference(), rating: double.parse(feedback[0]).toInt(),)), );
      }
    }

    return Form(
        key: _confCodeKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: new InputDecoration(
                  labelText: "Code",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                maxLength: 50,
                validator: (String value) {
                  if (value.isEmpty)
                    return 'Code is Required!';
                  else if(!conferences.contains(new Conference.onlyId(confId: _code))){
                    return 'Invalid Ticket!';
                  }
                  return null;
                },
                onSaved: (String value) {
                  _code = value;
                },
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black26, width: 2)),
                  child: Text('LEAVE FEEDBACK', style: TextStyle(color:Colors.black38, fontSize: 14.0,  fontWeight: FontWeight.w700, fontFamily: 'Rubik',)),
                  onPressed: () async {
                    _confCodeKey.currentState.save();
                    if (!_confCodeKey.currentState.validate())
                      return;

                    _handleConferenceCode();
                    //Send to API
                  },
                ),
              ),
            ])
    );
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<SmartconUser>(context);

    return StreamBuilder<List<Conference>>(
        stream: DatabaseService(uid: user.uid).conferences,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List<Conference> conferences = snapshot.data;

            return Scaffold(
              body: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset('images/pageHeader.png', fit: BoxFit.fill),
                    ),
                  ]),
                  Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.08,
                        right: MediaQuery.of(context).size.width * 0.08,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Feedback",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              alignment: Alignment.topLeft,
                            )
                          ])),
                  // CONTENT ROW
                  Container(
                    margin: EdgeInsets.all(24),
                    child: _conferenceCode(conferences),
                  ),
                ]),
              ),
            );
          }

          else{
            return Container();
          }
        });
  }
}