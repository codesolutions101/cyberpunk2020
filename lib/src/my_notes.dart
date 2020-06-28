import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon2020/src/helpers/utils/const.dart';

class MyNotes extends StatelessWidget {
  const MyNotes({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'NOTESSS',
                  style: GoogleFonts.orbitron(color: AppColor.themeColor),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {
                print('notes add');
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
