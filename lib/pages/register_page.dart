import 'package:demo/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../helper/helper_function.dart';
import '../widgets/widgets.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String name = "";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator(color:Theme.of(context).primaryColor))
            : SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Form(
                  key: formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Groupie",
                          style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text("Create your account and join us",
                            style: TextStyle(fontSize: 15)),
                        Image.asset("assets/meeting.png"),

                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            labelText: "Name",
                            prefix: Icon(Icons.person,
                              color: Theme.of(context).primaryColor,),),
                          onChanged: (val) {
                            setState(() {
                              name = val;
                            });},
                          //validation name
                          validator: (val){
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Name cannot be empty";
                            }
                          },

                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            labelText: "Email",
                            prefix: Icon(Icons.email,
                              color: Theme.of(context).primaryColor,),),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });},
                          //validation email
                          validator: (val){
                            return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                                ? null
                                : "Please enter a valid email";
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                              labelText: "Password",
                              prefix: Icon(Icons.lock,
                                color: Theme.of(context).primaryColor,),),
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });},

                            //validation password
                            validator: (val){
                              if (val!.length < 6) {
                                return "Password must be at least 6 characters";
                              } else {
                                return null;
                              }
                            }
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: const Text(
                              "Register",
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: (){
                              register();
                            },
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ]))),
        ));
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(name, email, password)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(name);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

}
