import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartcon_app/model/conference.dart';
import 'package:smartcon_app/model/session.dart';
import 'package:smartcon_app/controller/database.dart';

class BuildSessionQuestion extends StatefulWidget {
  SessionQuestion sessionQuestion;
  BuildSessionQuestion({Key key}) : super(key: key);

  @override
  _BuildSessionQuestion createState() => _BuildSessionQuestion();
}

class _BuildSessionQuestion extends State<BuildSessionQuestion> {
  final GlobalKey<FormState> _questionKey = GlobalKey<FormState>();

  String _question;
  String _type = 'conceptKnowledge';
  String _required;
  List<String> _options = List<String>(4);
  String _answer;

  _letterToInt(str) {
    int result;
    switch (str) {
      case 'A':
        result = 0;
        break;
      case 'B':
        result = 1;
        break;
      case 'C':
        result = 2;
        break;
      case 'D':
        result = 3;
        break;
      default:
        result = -1;
        break;
    }
    return result;
  }

  _buildSessionQuestion() {
    widget.sessionQuestion = new SessionQuestion(
        question: _question,
        options: _options,
        required: _required == null ? -1 : int.parse(_required),
        answer: _answer == null ? -1 : _letterToInt(_answer),
        type: _type);
  }

  Widget _buildQuestion() {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width * 0.84,
      child: TextFormField(
        decoration: new InputDecoration(
          labelText: "Question",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            borderSide: new BorderSide(),
          ),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'A Question is Required';
          }
          return null;
        },
        onSaved: (String value) {
          _question = value;
        },
      ),
    );
  }

  Widget _buildRequired() {
    return Container(
        alignment: Alignment.centerRight,
        width: MediaQuery.of(context).size.width * 0.3,
        child: DropDownFormField(
          contentPadding: EdgeInsets.fromLTRB(12, -20, 8, 0),
          required: true,
          titleText: '',
          hintText: '',
          value: _required,
          onSaved: (value) {
            setState(() {
              _required = value;
            });
          },
          onChanged: (value) {
            setState(() {
              _required = value;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Please choose an option';
            }
            return null;
          },
          dataSource: [
            {
              "display": "0",
              "value": "0",
            },
            {
              "display": "1",
              "value": "1",
            },
            {
              "display": "2",
              "value": "2",
            },
            {
              "display": "3",
              "value": "3",
            },
            {
              "display": "4",
              "value": "4",
            },
          ],
          textField: 'display',
          valueField: 'value',
        ));
  }

  Widget _buildAnswer() {
    return Container(
        alignment: Alignment.centerRight,
        width: MediaQuery.of(context).size.width * 0.3,
        child: DropDownFormField(
          contentPadding: EdgeInsets.fromLTRB(12, -20, 8, 0),
          required: true,
          titleText: '',
          hintText: '',
          value: _answer,
          onSaved: (value) {
            setState(() {
              _answer = value;
            });
          },
          onChanged: (value) {
            setState(() {
              _answer = value;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Please choose a correct answer';
            }
            return null;
          },
          dataSource: [
            {
              "display": "A",
              "value": "A",
            },
            {
              "display": "B",
              "value": "B",
            },
            {
              "display": "C",
              "value": "C",
            },
            {
              "display": "D",
              "value": "D",
            },
          ],
          textField: 'display',
          valueField: 'value',
        ));
  }

  Widget _buildForType() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (_type == 'conceptKnowledge')
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.84,
                child: Text(
                  "How many concepts must the user know to enjoy the session?",
                  style: TextStyle(
                    color: Color(0xFF4A4444),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                )),
          ],
        ),
      if (_type == 'conceptKnowledge') SizedBox(height: 20),
      Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.54,
            child: Text(
              _type == 'conceptKnowledge'
                  ? "KNOLDGE REQUIRED "
                  : "CORRECT OPTION ",
              style: TextStyle(
                color: Color(0xFF4A4444),
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _type == 'conceptKnowledge' ? _buildRequired() : _buildAnswer()
        ],
      ),
    ]);
  }

  Widget _buildOption(optionIdx, letter) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Text(
            letter,
            style: TextStyle(
              color: Color(0xFF5BBDB8),
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          alignment: Alignment.topLeft,
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.74,
          child: TextFormField(
            decoration: new InputDecoration(
              labelText: "Option",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(),
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'All Options are Required';
              }
              return null;
            },
            onSaved: (String value) {
              _options[optionIdx] = value;
            },
          ),
        )
      ],
    );
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
                      child: Image.asset('images/pageHeader.png',
                          fit: BoxFit.fill),
                    ),
                  ]),

                  // CONTENT ROW
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.08,
                      right: MediaQuery.of(context).size.width * 0.08,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.84,
                          child: Text(
                            "Session Question",
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Color(0xFF5BBDB8),
                              fontSize: 32.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.84,
                          child: Text(
                            "Make a Question to test Attendees knowledge on the topics of the session",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Rubik',
                            ),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ],
                    ),
                  ),

                  // Question Type
                  Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text('Concept Knowledge Question'),
                        leading: Radio(
                          value: 'conceptKnowledge',
                          groupValue: _type,
                          onChanged: (String value) {
                            setState(() {
                              _type = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Right/Wrong Question'),
                        leading: Radio(
                          value: 'right/wrong',
                          groupValue: _type,
                          onChanged: (String value) {
                            setState(() {
                              _type = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.08,
                      right: MediaQuery.of(context).size.width * 0.08,
                    ),
                    child: Form(
                      key: _questionKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.84,
                              child: Text(
                                "QUESTION",
                                style: TextStyle(
                                  color: Color(0xFF4A4444),
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            SizedBox(height: 10),
                            _buildQuestion(),
                            SizedBox(height: 10),
                            _buildForType(),
                            SizedBox(height: 10),
                            _buildOption(0, 'A. '),
                            SizedBox(height: 10),
                            _buildOption(1, 'B. '),
                            SizedBox(height: 10),
                            SizedBox(height: 10),
                            _buildOption(2, 'C. '),
                            SizedBox(height: 10),
                            _buildOption(3, 'D. '),
                            SizedBox(height: 10),
                          ]),
                    ),
                  ),
                ]),
          ),
          floatingActionButton: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: "btn2",
              child: Icon(Icons.done),
              backgroundColor: Color(0xFF5BBDB8),
              onPressed: onSave,
              foregroundColor: Colors.white,
            ),
          ),
        ));
  }

  //on save forms
  //on save forms
  void onSave() async {
    if (_questionKey.currentState.validate()) {
      _questionKey.currentState.save();
      _buildSessionQuestion();

      Navigator.pop(context, widget.sessionQuestion);
    }
  }
}
