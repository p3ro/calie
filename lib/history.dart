import 'package:calie/history_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late TextEditingController _controller;
  Color backgroundColor = const Color.fromRGBO(40, 3, 29, 1);
  double height = 0.0;
  double width = 0.0;
  String appBarText = "Most Recent";

  @override
  void initState() {
    super.initState();
    HistoryEntry.sortByDate(Home.entries);
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    DismissDirection dismissDirection = DismissDirection.startToEnd;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color.fromRGBO(88, 10, 10, 1)),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  top: height * 16.0 / 800, right: width * 16.0 / 360),
              child: GestureDetector(
                onTap: () {
                  changeOrder();
                },
                child: Text(appBarText,
                    style: GoogleFonts.karla(
                        textStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold))),
              ))
        ],
      ),
      backgroundColor: backgroundColor,
      body: ListView.builder(
          itemCount: Home.entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: UniqueKey(),
              direction: dismissDirection,
              onDismissed: (direction) {
                setState(() {
                  removeEntry(index);
                });
              },
              child: Card(
                color: backgroundColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Color.fromRGBO(255, 255, 255, 0.6), width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 8.0 / 360, right: width * 12.0 / 360),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (Home.entries[index].title.isEmpty)
                            ? Text("Title",
                                style: GoogleFonts.karla(
                                    textStyle: TextStyle(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.6),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic)))
                            : Text(Home.entries[index].title,
                                style: GoogleFonts.karla(
                                    textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Text(
                          formatDate(Home.entries[index].date),
                          style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.8),
                                  fontSize: 14)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 16.0 / 360, right: width * 12.0 / 360),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(Home.entries[index].calculation,
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ))
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 8 / 360, right: width * 12 / 360),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          GestureDetector(
                            child: Home.entries[index].isFavorite
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                            onTap: () {
                              setState(() {
                                Home.entries[index].changeFavorite();
                                if (appBarText == "Favorites First") {
                                  HistoryEntry.sortByFavorite(Home.entries);
                                }
                              });
                            },
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onTap: () {
                              editTitle(Home.entries[index], context);
                            },
                          ),
                          GestureDetector(
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onTap: () {
                                removeEntry(index);
                              })
                        ]),
                        Text(
                          Home.entries[index].result,
                          style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Color.fromRGBO(30, 153, 71, 1),
                                  fontSize: 24)),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            );
          }),
      drawer: Drawer(
          child: Container(
        color: backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: height * 110 / 800,
              alignment: Alignment.bottomLeft,
              child: DrawerHeader(
                child: Text("Calie",
                    style: GoogleFonts.karla(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 22))),
              ),
            ),
            Divider(
                height: height * 12 / 800,
                thickness: height * 5 / 800,
                indent: 0,
                endIndent: 0,
                color: Color.fromRGBO(110, 80, 80, 1)),
            ListTile(
              leading: Text("1+1",
                  style: GoogleFonts.merienda(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold))),
              minLeadingWidth: 10,
              title: Text('Simple',
                  style: GoogleFonts.karla(
                      textStyle: TextStyle(color: Colors.white, fontSize: 22))),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
            ListTile(
                leading: Text("fx",
                    style: GoogleFonts.merienda(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold))),
                minLeadingWidth: 10,
                title: Text('Scientific',
                    style: GoogleFonts.karla(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 22))),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/scientific');
                }),
          ],
        ),
      )),
    );
  }

  void changeOrder() {
    setState(() {
      if (appBarText == "Most Recent") {
        appBarText = "Favorites First";
        HistoryEntry.sortByFavorite(Home.entries);
      } else {
        appBarText = "Most Recent";
        HistoryEntry.sortByDate(Home.entries);
      }
    });
  }

  String formatDate(DateTime date) {
    return "${twoDigitFormat(date.day.toString())}/${twoDigitFormat(date.month.toString())}/${date.year.toString()} ${twoDigitFormat(date.hour.toString())}:${twoDigitFormat(date.minute.toString())}:${twoDigitFormat(date.second.toString())}";
  }

  String twoDigitFormat(String s) {
    if (s.length == 1) {
      return "0" + s;
    }
    return s;
  }

  editTitle(HistoryEntry entry, BuildContext context) {
    Widget exitButton = TextButton(
      child: Text("Exit", style: TextStyle(fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog edit = AlertDialog(
      title: Text("Edit Title",
          style: GoogleFonts.karla(
              textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
      content: TextField(
        maxLength: 16,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'New Title',
        ),
        style: GoogleFonts.karla(textStyle: TextStyle(fontSize: 16)),
        controller: _controller,
        onSubmitted: (String title) {
          if (title != "") {
            setState(() {
              entry.title = title;
            });
            _controller.clear();
            Navigator.of(context).pop;
          }
        },
      ),
      actions: [
        exitButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return edit;
      },
    );
  }

  void removeEntry(int index) {
    Widget yesButton = TextButton(
      child: Text("Yes",
          style: GoogleFonts.karla(textStyle: TextStyle(fontSize: 16))),
      onPressed: () {
        setState(() {
          Home.entries.removeAt(index);
        });
        Navigator.of(context).pop();
      },
    );

    Widget noButton = TextButton(
      child: Text("No",
          style: GoogleFonts.karla(textStyle: TextStyle(fontSize: 16))),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog delete = AlertDialog(
      title: Text("Delete Calculation",
          style: GoogleFonts.karla(
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      content: Text(
          "Are you sure? The calculation will be permanently removed!",
          style: GoogleFonts.karla(textStyle: TextStyle(fontSize: 16))),
      actions: [yesButton, noButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return delete;
      },
    );
  }
}
