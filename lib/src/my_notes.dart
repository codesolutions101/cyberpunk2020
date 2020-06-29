import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/src/helpers/utils/const.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uuid/uuid.dart';

import 'helpers/common_widget/error_dialog.dart';
import 'helpers/common_widget/input_decoration.dart';

class MyNotes extends StatefulWidget {
  MyNotes({this.uid});

  final String uid;

  @override
  _MyNotesState createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  String title;
  String text;
  String noteID = Uuid().v4();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var dateTime;

  Widget _notes(DocumentSnapshot doc) {
    if (doc.data['createdAt'] != null) {
      dateTime = timeago.format(doc.data['createdAt'].toDate());
    } else {
      dateTime = '';
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Dismissible(
            key: Key(UniqueKey().toString()),
            background: Container(
              height: 120,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            secondaryBackground: Container(
              height: 120,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Card(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.delete,
                        color: AppColor.kPurple,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onDismissed: (direction) async {
              if (direction == DismissDirection.endToStart) {
                print('delete note entry');
                await Firestore.instance
                    .collection('notes')
                    .document(doc.documentID)
                    .delete();
              }
            },
            child: ListTile(
              isThreeLine: true,
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      doc.data['title'],
                      style: GoogleFonts.orbitron(
                        color: AppColor.kPurple,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    dateTime.toString(),
                    style: GoogleFonts.orbitron(
                      color: AppColor.themeColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      doc.data['text'],
                      style: GoogleFonts.orbitron(
                        color: AppColor.themeColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('notes')
                  .where('uid', isEqualTo: widget.uid)
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.documents.length == 0) {
                    return Center(
                      child: Container(
                        child: Text(
                          'Add Notes',
                          style: GoogleFonts.orbitron(
                            color: AppColor.kPurple,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Expanded(
                              child: ListView(
                                children: snapshot.data.documents
                                    .map((doc) => _notes(doc))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: GoogleFonts.orbitron(
                        color: AppColor.themeColor,
                        fontSize: 15,
                      ),
                    ),
                  );
                } else
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    valueColor: AlwaysStoppedAnimation(AppColor.themeColor),
                  ));
              }),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {
                showGeneralDialog(
                    context: context,
                    // ignore: missing_return
                    pageBuilder: (context, anim1, anim2) {},
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.5),
                    barrierLabel: '',
                    transitionDuration: Duration(milliseconds: 400),
                    transitionBuilder: (context, anim1, anim2, child) {
                      return ScaleTransition(
                        scale: anim1,
                        alignment: Alignment.bottomRight,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dialogBackgroundColor: Colors.black),
                          child: AlertDialog(
                            contentPadding: EdgeInsets.all(0),
                            content: Container(
                              height: 430,
                              width: 430,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Add New Note',
                                    style: GoogleFonts.orbitron(
                                      color: AppColor.kPurple,
                                      fontSize: 30,
                                    ),
                                  ),
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          validator: (val) {
                                            if (val.trim().length < 2 ||
                                                val.isEmpty) {
                                              return 'Too Short';
                                            } else if (val.trim().length >
                                                500) {
                                              return 'Too Long';
                                            } else
                                              return null;
                                          },
                                          maxLines: 1,
                                          onChanged: (val) =>
                                              setState(() => title = val),
                                          decoration: kInputDecoration(
                                              labelText: "Title",
                                              hintText: "Title"),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          validator: (val) {
                                            if (val.trim().length < 5 ||
                                                val.isEmpty) {
                                              return 'Too Short';
                                            } else if (val.trim().length >
                                                500) {
                                              return 'Too Long';
                                            } else
                                              return null;
                                          },
                                          maxLines: 5,
                                          onChanged: (val) =>
                                              setState(() => text = val),
                                          decoration: kInputDecoration(
                                              labelText: "Note",
                                              hintText: "Note"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RaisedButton(
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        try {
                                          await Firestore.instance
                                              .collection('notes')
                                              .document()
                                              .setData({
                                            'uid': widget.uid,
                                            'noteID': noteID,
                                            'title': title,
                                            'text': text,
                                            'createdAt':
                                                FieldValue.serverTimestamp(),
                                          });
                                          setState(() {});
                                          Navigator.pop(context);
                                        } on FirebaseError catch (e) {
                                          errorDialogue(
                                              errorText: e.toString(),
                                              context: context);
                                        }
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.tealAccent,
                                              AppColor.themeColor
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Add",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
              backgroundColor: Colors.black,
              child: Icon(Icons.add, color: AppColor.themeColor),
            ),
          ),
        ],
      ),
    );
  }
}
