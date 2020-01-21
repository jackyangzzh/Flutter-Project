import '../Screens/auth_screen.dart';
import 'package:flutter/material.dart';
import '../Providers/auth.dart';
import 'package:provider/provider.dart';
import '../Models/HttpException.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController _animationController;
  Animation _heightAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    _heightAnimation = Tween<Size>(
            begin: Size(double.infinity, 300), end: Size(double.infinity, 350))
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Error'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email'], _authData['password']);
      }
    } on HttpException catch (error) {
      var errorMsg = 'Authenticatioin failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMsg = 'This email is already used.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMsg = 'This email is not valid';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMsg = 'Weak password. Try a stronger one!';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMsg = 'Could not find this email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMsg = 'Wrong password';
      }
      _showErrorDialog(errorMsg);
    } catch (error) {
      const errorMsg = 'Could not authenticate';
      _showErrorDialog(errorMsg);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animationController.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _animationController.reverse();
    }
    _heightAnimation.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        height: _heightAnimation.value.height,
        constraints: BoxConstraints(minHeight: _heightAnimation.value.height),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val.isEmpty || !val.contains('@')) {
                      return 'Invalid Email';
                    }
                  },
                  onSaved: (val) {
                    _authData['email'] = val;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (val) {
                    if (val.isEmpty || val.length < 6) {
                      return 'Password should be at least 6 digits!';
                    }
                  },
                  onSaved: (val) {
                    _authData['password'] = val;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (val) {
                            if (val != _passwordController.text) {
                              return 'Please enter the same password!';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  )
                else
                  FlatButton(
                    child: Text(
                        _authMode == AuthMode.Login ? 'Login' : 'Sign up',
                        style: TextStyle(fontFamily: 'Raleway', fontSize: 15)),
                    onPressed: _submit,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'Sign up' : 'Login'}',
                      style: TextStyle(fontFamily: 'Raleway', fontSize: 15)),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
