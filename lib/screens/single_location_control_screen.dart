import 'package:flutter/material.dart';
import 'package:shadowrun/types/location_controls_arguments.dart';
import 'package:provider/provider.dart';
import '../providers/locations.dart';
import '../connected/firebase_auth.dart';
import '../providers/users.dart';

class SingleLocationControlScreen extends StatefulWidget {
  static String routeName = '/single-location-control';

  @override
  _SingleLocationControlScreenState createState() => _SingleLocationControlScreenState();
}

class _SingleLocationControlScreenState extends State<SingleLocationControlScreen> {
  final _nameFocusNode = FocusNode();
  var _isInit = true;
  var _isLoading = false;
  var _token = '';
  var _editedUserName = '';
  final _form = GlobalKey<FormState>();
  var _initialValue = '';
  var _locationId = '';
  var _currentUserId='';

  void _updateName() {
    setState(() {});
  }

  @override
  void initState() {
    _nameFocusNode.addListener(_updateName);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final LocationControlsArguments args = ModalRoute.of(context).settings.arguments;
    if (_isInit) {
      _token = Provider.of<AuthProvider>(context).token;
      _initialValue = args.locationName;
      _locationId = args.locationId;
      _currentUserId = Provider.of<Users>(context).currentUser.getUser.uid;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameFocusNode.removeListener(_updateName);
    _isInit = true;
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedUserName != '') {
      await Provider.of<Locations>(context, listen: false)
          .renameLocation(token: _token, locationId:_locationId,newName: _editedUserName);
    }
    if (this.mounted) {
      setState(() {
        _isLoading = false;
      });
    }
    Provider.of<Locations>(context).fetchAndSetAllLocations(token: _token,userId: _currentUserId);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final LocationControlsArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Управление локацией с ID ${args.locationId}'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
        child: Form(
          key: _form,
          child: Column(children: <Widget>[
            TextFormField(
              initialValue: _initialValue,
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Название локации",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Поле не должно быть пустым';
                }
                return null;
              },
              onSaved: (value) {
                _editedUserName = value;
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 8),
              width: double.infinity,
              child: RaisedButton(
                color: Theme.of(context).secondaryHeaderColor,
                child: Text(
                  'СОХРАНИТЬ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                onPressed: _saveForm,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
