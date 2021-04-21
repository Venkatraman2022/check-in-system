import 'dart:math' as math show pi;
import 'package:check_in_system/AdminPage/dashboard/customer_visits.dart';
import 'package:check_in_system/AdminPage/login/admin_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool dashboard = false;
  bool qrCode = false;
  bool customerVisits = false;
  String dropdownValue = '';



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dropdownValue = 'User Name';
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = DateFormat('dd-MM-yy')
        .format(DateTime.parse(dateParse.toString()));
        return Scaffold(
          appBar: AppBar(
            leading: Image.asset(
              "images/wel.png",
              width: size.width * 0.5,
              height: size.height * 0.5,
            ),
            title: Row(
              children: [
                Text('Dropin | ',style: TextStyle(color: Colors.white,fontSize:size .width* 0.02 ),),
                Text(FirebaseAuth.instance.currentUser ==null ? 'Shop Name ' : FirebaseAuth.instance.currentUser.displayName,style: TextStyle(color: Colors.white,fontSize:size .width* 0.02 ),),
              ],
            ),

          ),
          body: SingleChildScrollView(
            child:Column(
              children: [
                  Row(
                  children: [

                    Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.white,
                        height: size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${FirebaseAuth.instance.currentUser ==null ? 'Shop Name ' : FirebaseAuth.instance.currentUser.displayName} Visitors Dashboard ',style: TextStyle(color: Colors.grey,fontSize: size.width * 0.03),),
                            ),
                            size.width <= 700 ?
                            ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: [
                                Column(
                                  children: [
                                StreamBuilder(
                                stream: FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.displayName).doc('customerDetails').collection(formattedDate.toString()).snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                          }
                          // print(snapshot.data.docs[0]['mobile']);
                          return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  height:size.width <= 700 ? size.height * 0.2:  size.height * 0.135,
                                  width:size.width <= 700 ? size.width * 0.3: size.width * 0.2,
                                  child: Card(
                                    color: Colors.blueGrey.shade600,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ListTile(
                                      title: Text("Today Visits",style: TextStyle(color: Colors.white,fontSize: size.width * 0.02),),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_circle_up,size: size.width* 0.01,color: Colors.blue,),
                                            Text(snapshot.data.docs.length.toString(),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: size.width * 0.02),)
                                          ],
                                        ),
                                      ),
                                      trailing: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Icon(Icons.calendar_today_outlined,color: Colors.blue,size: size.width * 0.03,),
                                      ),
                                    ),
                                  ),
                                ),
                          );
                        }
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height:size.width <= 700 ? size.height * 0.2:  size.height * 0.135,
                        width:size.width <= 700 ? size.width * 0.3: size.width * 0.2,
                        child: StreamBuilder(
                                stream: FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.displayName).doc('NewCustomers').collection('NewCustomers').snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Card(
                                    color: Color(0xFF4C2B47),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ListTile(
                                      title: Text("Unique Visits",style: TextStyle(color: Colors.white,fontSize: size.width * 0.02),),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_circle_up,size: size.width* 0.01,color: Colors.pink,),
                                            Text(snapshot.data.docs.length.toString(),style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: size.width * 0.02),)
                                          ],
                                        ),
                                      ),
                                      trailing: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Icon(Icons.person,color: Colors.yellow,size: size.width * 0.03,),
                                      ),
                                    ),
                                  );
                                }
                        ),
                      ),
                    ), Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                        height:size.width <= 700 ? size.height * 0.2:  size.height * 0.135,
                        width:size.width <= 700 ? size.width * 0.3: size.width * 0.2,
                        child: StreamBuilder(
                                stream: FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.displayName).doc('returnCustomers').collection('customerReturn').snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Card(
                                    color: Color(0xFF4B4A2B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ListTile(
                                      title: Text("Return Visits",style: TextStyle(color: Colors.white,fontSize: size.width * 0.02),),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_circle_up,size: size.width* 0.01,color: Colors.yellow,),
                                            Text(snapshot.data.docs.length.toString(),style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,fontSize: size.width * 0.02),)
                                          ],
                                        ),
                                      ),
                                      trailing: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Icon(Icons.people,color: Colors.yellow,size: size.width * 0.03,),
                                      ),
                                    ),
                                  );
                                }
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.displayName).doc('totalCustomers').collection('customerTotalIndex').snapshots(),
                        builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                                }
                                print(snapshot.data.docs.length);
                                return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  height:size.width <= 700 ? size.height * 0.2:  size.height * 0.135,
                                  width:size.width <= 700 ? size.width * 0.3: size.width * 0.2,
                                  child: Card(
                                    color: Color(0xFFD53343),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ListTile(
                                      title: Text("Total Visits",style: TextStyle(color: Colors.white,fontSize: size.width * 0.0170),),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_circle_up,size: size.width* 0.01,color: Colors.white,),
                                            Text(snapshot.data.docs.length.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: size.width * 0.02),)
                                          ],
                                        ),
                                      ),
                                      trailing: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Icon(Icons.file_copy_rounded,color: Colors.white,size: size.width * 0.03,),
                                      ),
                                    ),
                                  ),
                                ),
                                );
                        }
                    ),


                                  ],
                                ),
                              ],
                            )  :  Row(
                              children: [
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.displayName).doc('customerDetails').collection(formattedDate.toString()).snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    // print(snapshot.data.docs[0]['mobile']);
                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        height:size.width <= 700 ? size.height * 0.2:  size.height * 0.135,
                                        width:size.width <= 700 ? size.width * 0.3: size.width * 0.2,
                                        child: Card(
                                          color: Colors.blueGrey.shade600,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: ListTile(
                                            title: Text("Today Visits",style: TextStyle(color: Colors.white,fontSize: size.width * 0.02),),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 20),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.arrow_circle_up,size: size.width* 0.01,color: Colors.blue,),
                                                  Text(snapshot.data.docs.length.toString(),style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: size.width * 0.02),)
                                                ],
                                              ),
                                            ),
                                            trailing: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 20),
                                              child: Icon(Icons.calendar_today_outlined,color: Colors.blue,size: size.width * 0.03,),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    height:size.width <= 700 ? size.height * 0.2:  size.height * 0.135,
                                    width:size.width <= 700 ? size.width * 0.3: size.width * 0.2,
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.displayName).doc('NewCustomers').collection('NewCustomers').snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Card(
                                          color: Color(0xFF4C2B47),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: ListTile(
                                            title: Text("Unique Visits",style: TextStyle(color: Colors.white,fontSize: size.width * 0.02),),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 20),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.arrow_circle_up,size: size.width* 0.01,color: Colors.pink,),
                                                  Text(snapshot.data.docs.length.toString(),style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: size.width * 0.02),)
                                                ],
                                              ),
                                            ),
                                            trailing: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 20),
                                              child: Icon(Icons.person,color: Colors.yellow,size: size.width * 0.03,),
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                  ),
                                ), Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    height: size.height * 0.135,
                                    width:  size.width * 0.2,
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.displayName).doc('returnCustomers').collection('customerReturn').snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Card(
                                          color: Color(0xFF4B4A2B),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: ListTile(
                                            title: Text("Return Visits",style: TextStyle(color: Colors.white,fontSize: size.width * 0.02),),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 20),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.arrow_circle_up,size: size.width* 0.01,color: Colors.yellow,),
                                                  Text(snapshot.data.docs.length.toString(),style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,fontSize: size.width * 0.02),)
                                                ],
                                              ),
                                            ),
                                            trailing: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 20),
                                              child: Icon(Icons.people,color: Colors.yellow,size: size.width * 0.03,),
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.displayName).doc('totalCustomers').collection('customerTotalIndex').snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      print(snapshot.data.docs.length);
                                      return Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SizedBox(
                                          height:size.width <= 700 ? size.height * 0.2:  size.height * 0.135,
                                          width:size.width <= 700 ? size.width * 0.3: size.width * 0.2,
                                          child: Card(
                                            color: Color(0xFFD53343),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: ListTile(
                                              title: Text("Total Visits",style: TextStyle(color: Colors.white,fontSize: size.width * 0.0170),),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 20),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.arrow_circle_up,size: size.width* 0.01,color: Colors.white,),
                                                    Text(snapshot.data.docs.length.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: size.width * 0.02),)
                                                  ],
                                                ),
                                              ),
                                              trailing: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 20),
                                                child: Icon(Icons.file_copy_rounded,color: Colors.white,size: size.width * 0.03,),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
        );
      }

  }






class SidebarPage extends StatefulWidget {
  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  TextEditingController fbController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  var fbKey = GlobalKey<FormState>();
  var instaKey = GlobalKey<FormState>();


  List<CollapsibleItem> _items;
  int _headline;
  NetworkImage _avatarImg =
  NetworkImage('https://image.shutterstock.com/image-vector/user-icon-person-profile-avatar-260nw-601712213.jpg');

  showAlertDialogInstaURL(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () async{
        await FirebaseFirestore.instance
            .collection(FirebaseAuth.instance.currentUser.displayName)
            .doc("socialMedia")
            .updateData({
          'insta': instaController.text,
        });
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Insta Url"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: instaKey,
          child: TextFormField(
            validator: (String value) {
              if (value.length < 3)
                return " Enter at least 3 character from Customer Name";
              else
                return null;
            },
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text ,
            controller: instaController,
            autofillHints: [AutofillHints.givenName],

            decoration: InputDecoration(
                labelText: 'insta Url',
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: size.width * 0.02,
                ),
                prefixIcon: Icon(Icons.data_usage),
                hoverColor: Colors.yellow,
                filled: true,
                focusColor: Colors.yellow),
          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  showAlertDialogFBURL(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // set up the buttons

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () async{
        await FirebaseFirestore.instance
            .collection(FirebaseAuth.instance.currentUser.displayName)
            .doc("socialMedia")
            .updateData({
          'facebook': fbController.text,
        });
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Facebook Url"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: fbKey,
          child: TextFormField(
            validator: (String value) {
              if (value.length < 3)
                return " Enter at least 3 character from Customer Name";
              else
                return null;
            },
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            controller: fbController,
            autofillHints: [AutofillHints.givenName],

            decoration: InputDecoration(
                labelText: 'Facebook Url',
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: size.width * 0.02,
                ),
                prefixIcon: Icon(Icons.data_usage),
                hoverColor: Colors.yellow,
                filled: true,
                focusColor: Colors.yellow),
          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = 1;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Dashboard',
        icon: Icons.assessment,
        onPressed: () => setState(() => _headline = 1),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Customer Visits ',
        icon: Icons.people,
        onPressed: () => setState(() => _headline = 2),
      ),
      CollapsibleItem(
        text: 'Facebook Url ',
        icon: Icons.link,
        onPressed: () => setState(() {
          _headline = 1;
          showAlertDialogFBURL(context);
        }
        ),
      ),
      CollapsibleItem(
        text: 'Instagram Url ',
        icon: Icons.link,
        onPressed: () => setState(() {
          _headline = 3;
          showAlertDialogInstaURL(context);
        }),
      ),
      CollapsibleItem(
        text: 'Sign Out',
        icon: Icons.logout,
        onPressed: () => setState(() {
          _headline = 4;
          FirebaseAuth.instance.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminLoginPage(),));
        }),
      ),
      // CollapsibleItem(
      //   text: 'Settings',
      //   icon: Icons.settings,
      //   onPressed: () => setState(() => _headline = 'Settings'),
      // ),
      // CollapsibleItem(
      //   text: 'Home',
      //   icon: Icons.home,
      //   onPressed: () => setState(() => _headline = 'Home'),
      // ),
      // CollapsibleItem(
      //   text: 'Alarm',
      //   icon: Icons.access_alarm,
      //   onPressed: () => setState(() => _headline = 'Alarm'),
      // ),
      // CollapsibleItem(
      //   text: 'Eco',
      //   icon: Icons.eco,
      //   onPressed: () => setState(() => _headline = 'Eco'),
      // ),
      // CollapsibleItem(
      //   text: 'Event',
      //   icon: Icons.event,
      //   onPressed: () => setState(() => _headline = 'Event'),
      // ),
      // CollapsibleItem(
      //   text: 'Email',
      //   icon: Icons.email,
      //   onPressed: () => setState(() => _headline = 'Email'),
      // ),
      // CollapsibleItem(
      //   text: 'Face',
      //   icon: Icons.face,
      //   onPressed: () => setState(() => _headline = 'Face'),
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    instaController.text = 'https://www.instagram.com/';
    fbController.text = 'https://www.facebook.com/';
    return SafeArea(
      child: Scaffold(
        body: CollapsibleSidebar(
          items: _items,
          avatarImg: _avatarImg,
          title:FirebaseAuth.instance.currentUser ==null ? 'User Name ' : FirebaseAuth.instance.currentUser.displayName,
          body: landingWidget(page: _headline,),
          backgroundColor: Colors.black,
          selectedTextColor: Colors.limeAccent,
          textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          titleStyle: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
          toggleTitleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}

class landingWidget extends StatelessWidget {
  final int page;

  const landingWidget({Key key, this.page}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    switch(page)
    {
      case 1 : return AdminDashboard();
      case 2 : return CustomerVisits();
      case 3 : return AdminDashboard();
      default : return Container(color: Colors.pink,);
    }
  }
}

