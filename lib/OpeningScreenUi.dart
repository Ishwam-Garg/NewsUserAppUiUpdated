import 'package:flutter/material.dart';
import 'package:news_app_user/Theme.dart';

class OpeningScreen extends StatefulWidget {
  @override
  _OpeningScreenState createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {

  GlobalKey _formkey = GlobalKey();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeNotifier().darkTheme ? dark : light,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                //Welcome Text
                SizedBox(height: 60,),
                Center(
                  child: Text('Welcome to',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 2,
                          offset: Offset(2.0,2.0),
                        ),
                      ]),),
                ),
                SizedBox(height: 40,),
                Center(
                  child: Text('Jaipur Times',style: TextStyle(fontSize: 32,fontWeight: FontWeight.w500),),
                ),
                SizedBox(height: 60,),
                Form(
                  key: _formkey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: _nameController,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              enabled: true,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: 'Name',
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                              labelStyle: TextStyle(fontSize: 24),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(height: 40,),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneController,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              enabled: true,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: 'Phone',
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 20,left: 10,bottom: 20),
                                child: Text('+91 |',style: TextStyle(fontSize: 16),),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                              labelStyle: TextStyle(fontSize: 24),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(height: 50,),
                          GestureDetector(
                            onTap: (){},
                            child: Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 200,
                                //width: MediaQuery.of(context).size.width*0.6,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Center(child: Text('Login',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
