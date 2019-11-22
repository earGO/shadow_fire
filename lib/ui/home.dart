import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../utils/firebase_auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Home page"),
            RaisedButton(
              child: Text("Log out"),
              onPressed: () {
                AuthProvider().logOut();
              },
            ),
            Center(
              child: FloatingActionButton(
                onPressed: () => _showAddUserDialogBox(context), //--------- new
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
              child: _retrieveUsers(),
            ),
          ],
        ),
      ),
    );
  }
}

/** the popup screen to test cloud function */

Future<Null> _showAddUserDialogBox(BuildContext context) {
  TextEditingController _nameTextController = new TextEditingController();
  TextEditingController _emailTextController = new TextEditingController();

  return showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: const Text("Add a contact"),
          content: Container(
            height: 120.0,
            width: 100.0,
            child: ListView(
              children: <Widget>[
                new TextField(
                  controller: _nameTextController,
                  decoration: const InputDecoration(labelText: "Name: "),
                ),
                new TextField(
                  controller: _emailTextController,
                  decoration: const InputDecoration(labelText: "Email: "),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel")),
            // This button results in adding the contact to the database
            new FlatButton(
                onPressed: () {
//                  final HttpsCallable callable =
//                      CloudFunctions.instance.getHttpsCallable(
//                    functionName: 'addUser',
//                  );
//                  callable.call(<String, dynamic>{
//                    "name": _nameTextController.text,
//                    "email": _emailTextController.text
//                  });
                  Navigator.of(context).pop();
                },
                child: const Text("Confirm")),
          ],
        );
      });
}

/// Widget retrieves users from Firestore

StreamBuilder<QuerySnapshot> _retrieveUsers() {
  return new StreamBuilder<QuerySnapshot>(
      // Interacts with Firestore (not CloudFunction)
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          print("retrieve users do not have data.");
          return Container();
        }

        // This ListView widget consists of a list of tiles
        // each represents a user.
        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              final userDoc = snapshot.data.documents[index];
              return Dismissible(
                key: Key(userDoc.documentID),
                direction: DismissDirection.startToEnd,
                onDismissed: (DismissDirection direction){
                  if(direction == DismissDirection.startToEnd){
                    Firestore.instance.collection('users').document(userDoc.documentID).delete();
                  }
                },
                child: InkWell(
                  onTap: ()=>_showEditUserDialog(context, userDoc),
                  child: new ListTile(
                      title: new Text(userDoc['name']),
                      subtitle: new Text(userDoc['email'])),
                ),
              );
            });
      });
}

Future<Null> _showEditUserDialog(BuildContext context, DocumentSnapshot userDoc) {
  TextEditingController _nameTextController = new TextEditingController(text: userDoc['name']);
  TextEditingController _emailTextController = new TextEditingController(text: userDoc['email']);

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text("Edit contact"),
          content: Container(
            height: 120.0,
            width: 100.0,
            child: ListView(
              children: <Widget>[
                new TextField(
                  controller: _nameTextController,
                  decoration: new InputDecoration(labelText: "Name: "),

                ),
                new TextField(
                  controller: _emailTextController,
                  decoration: new InputDecoration(labelText: "Email: "),
                ),

              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel")
            ),
            // This button results in adding the contact to the database
            new FlatButton(
                onPressed: () {
//                  final HttpsCallable callable =
//                  CloudFunctions.instance.getHttpsCallable(
//                    functionName: 'updateUser',
//                  );
//                  callable.call(<String, dynamic>{
//                        "doc_id": userDoc.documentID,
//                        "name": _nameTextController.text,
//                        "email": _emailTextController.text
//                      }
//                  );
                  Navigator.of(context).pop();
                },
                child: const Text("Confirm")
            )
          ],

        );
      }
  );
}