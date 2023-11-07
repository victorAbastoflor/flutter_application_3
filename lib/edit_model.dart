import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditWidget extends StatefulWidget {
  const EditWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UsersRecord? user;

  @override
  _EditWidgetState createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  late TextEditingController textController;
  late FocusNode textFieldFocusNode;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.user?.name);
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
            'edit',
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
              Row(
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
                          labelText: 'editar',
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
                              color: Colors.red, // Change to your desired color
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red, // Change to your desired color
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
                      // Actualiza el registro en Firebase Firestore
                      await widget.user!.reference.update({
                        'name': textController.text,
                      });
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.check,
                      color: Colors.blue, // Change to your desired color
                      size: 44,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UsersRecord {
  final String name;
  final DocumentReference reference;

  UsersRecord({required this.name, required this.reference});

  // Puedes agregar más campos según tus necesidades
}
