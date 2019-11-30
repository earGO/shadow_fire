import 'package:flutter/material.dart';

class NameScreen extends StatefulWidget {
  static String routeName = '/game-name';

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController _nameTextController = new TextEditingController();
  final _nameFocusNode = FocusNode();
  var _isInit = true;
  var _isLoading = false;
  final _form = GlobalKey<FormState>();
  var _initValues = {
    'name': '',
  };

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
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {}
      _isInit = false;

    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameFocusNode.removeListener(_updateName);
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Имя в игре'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
        child:
            Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: _initValues['name'],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Имя",
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(6.0))),
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
                ]
              ),
            ),
        ),
      );
  }
}
