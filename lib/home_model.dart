import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'edit_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late TextEditingController textController;
  late FocusNode textFieldFocusNode;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    textFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    textController.dispose();
    textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => textFieldFocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(textFieldFocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor:
            Colors.white, // Change to your desired background color
        appBar: AppBar(
          backgroundColor: Colors.blue, // Change to your desired app bar color
          automaticallyImplyLeading: false,
          title: Text(
            'cRUD',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: <Widget>[],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.grey, // Change to your desired color
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          controller: textController,
                          focusNode: textFieldFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Label here...',
                            labelStyle: TextStyle(
                              fontSize: 16,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 16,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    Colors.blue, // Change to your desired color
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    Colors.blue, // Change to your desired color
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    Colors.red, // Change to your desired color
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    Colors.red, // Change to your desired color
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          validator: (value) {
                            // Add your validation logic here
                            return null;
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .add({
                          'name': textController.text,
                        });
                        textController.clear();
                      },
                      child: Icon(
                        Icons.check,
                        color: Colors.blue, // Change to your desired color
                        size: 44,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.grey, // Change to your desired background color
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      );
                    }
                    final documents = snapshot.data!.docs;
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: documents.map((doc) {
                        final name = doc['name'] as String;
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                // Add your edit logic here
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      UsersRecord user = UsersRecord(
                                          name: doc['name'],
                                          reference: doc.reference);

                                      return EditWidget(user: user);
                                    },
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.edit,
                                color:
                                    Colors.blue, // Change to your desired color
                                size: 30,
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // Add your delete logic here
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(doc.id)
                                    .delete();
                              },
                              child: Icon(
                                Icons.delete_sharp,
                                color:
                                    Colors.red, // Change to your desired color
                                size: 30,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
