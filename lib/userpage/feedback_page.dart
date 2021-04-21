import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:check_in_system/userpage/userpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatefulWidget {
  final urlName;

  const FeedbackPage({Key key, this.urlName}) : super(key: key);
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool thumbsDown = false;
  bool thumbsUp = false;
  String  fbUrl = 'https://www.facebook.com/';
  String instaUrl = 'https://www.instagram.com/';
  String currentTime;
  String currentDate;
  _launchFBURL() async {

    if (await canLaunch(fbUrl)) {
      await launch(fbUrl);
    } else {
      throw 'Could not launch $fbUrl';
    }
  }

  _launchInstaURL() async {

    if (await canLaunch(instaUrl)) {
      await launch(instaUrl);
    } else {
      throw 'Could not launch $instaUrl';
    }
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    currentTime =
        DateFormat('hh:mm a').format(
          DateTime.now(),
        );
    currentDate =
        DateFormat(" d MMMM yyyy").format(DateTime.now());
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(widget.urlName).doc('socialMedia').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot == null) {
          return Center(
            child: CircularProgressIndicator(
            ),
          );
        }
        print(snapshot.data['insta']);
        fbUrl =  snapshot.data['facebook'];
        instaUrl =snapshot.data['insta'];
        print(fbUrl);
        return Scaffold(
          backgroundColor:   Color(0xFFFEFEFE),
          body: MediaQuery.of(context).size.width <= 700 ? ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Container(
                height: size.height ,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Please give your Feedback ',
                      style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.urlName == null ? 'Empty' : widget.urlName,
                      style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Image.asset(
                          "images/checked.gif",
                          width: 300,
                          height: 100,
                        ),
                      ),
                    ),
                    Text(
                      'Checked In ',
                      style: TextStyle(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$currentDate at $currentTime', style: TextStyle(
                            fontSize: size.width * 0.04,),),
                        ],
                      ),
                    ),

                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 80,right: 80),
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              'How was the app check-in  ',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                              ),
                            ),
                            Text(
                              ' experience ?',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          iconSize: size.width * 0.1,
                          onPressed: (){
                            setState(() {
                              thumbsDown = true;
                              thumbsUp = false;
                              print(thumbsDown);
                            });
                          },
                          icon:
                          thumbsDown == false ?
                          Image.asset(
                            "images/thumbs down false.png",
                            width:100,
                            height: size.height ,
                          )
              :
                          Image.asset(
                            "images/thumbs down true.png",
                            width:size.width * 0.048,
                          )

        ),
                        IconButton(
                            iconSize: size.width * 0.1,
                            onPressed: (){
                              setState(() {
                                thumbsDown = false;
                                thumbsUp = true;
                                print(thumbsDown);
                              });
                            },
                            icon:
                            thumbsUp == false ?
                            Image.asset(
                              "images/thumbs up false.png",
                              width:100,
                              height: size.height ,
                            )
                                :
                            Image.asset(
                              "images/thumbs up true.png",
                              width:size.width * 0.048,
                            )

                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: InkWell(
                          onTap: (){
                            showModel(context);
                          },
                          child: Container(

                            decoration: BoxDecoration(
                              // Color(0xFFFEFEFE),
                              image: DecorationImage(
                                  image: AssetImage("images/feedback.gif"), fit: BoxFit.cover),

                              borderRadius: BorderRadius.all(Radius.circular(20)),

                            ),
                            child: Image.asset(
                              "images/feedback.png",
                              width: size.width * 5,
                              height: size.height * 0.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25,),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 20,
                            side: BorderSide(width: 1,
                              color:  Colors.deepOrange,),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            primary:thumbsUp == true || thumbsDown ==true ? Colors.deepOrange: Colors.grey.shade200,
                            onPrimary: Colors.white),
                        onPressed: () {
                          if(thumbsUp == true && thumbsDown == false )
                            print('thumpsUp true');
                          else
                            print('thumbsDown true');
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> UserPage(),));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                thumbsUp == true || thumbsDown ==true ? "Done" :  "Skip",
                                style: TextStyle(
                                  color:  thumbsUp == true || thumbsDown ==true ?Colors.white:  Colors.deepOrange,
                                  fontSize: size.width * 0.03,
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
            ],
          ):
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('Sorry This page can only  opened in Mobile',style: TextStyle(
                color: Colors.black,fontSize: size.width * 0.1,
              ),)),
            ),
          ),
        );
      }
    );
  }
  showModel(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          Size size = MediaQuery.of(context).size;
          var date = new DateTime.now().toString();
          var dateParse = DateTime.parse(date);
          var formattedDate =
              "${dateParse.day}-${dateParse.month}-${dateParse.year}";
          print(formattedDate);

          return SizedBox(
            height: size.height * 0.05,
            width: size.width * 0.1,
            child: SingleChildScrollView(
              child: AlertDialog(actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Close'))
              ],
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: StatefulBuilder(
                  builder: (context, setstate) {
                    return
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(

                                decoration: BoxDecoration(
                                  color: Color(0xFFFEFEFE),
                                  image: DecorationImage(
                                      image: AssetImage("images/feedback.gif"), fit: BoxFit.cover),

                                  borderRadius: BorderRadius.all(Radius.circular(20)),

                                ),
                                child: InkWell(
                                  onTap: (){
                                    _launchInstaURL();
                                  },
                                  child: Image.asset(
                                    "images/insta.png",
                                    width: size.width * 0.1,
                                    height: size.height * 0.2,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFEFEFE),
                                  image: DecorationImage(
                                      image: AssetImage("images/feedback.gif"), fit: BoxFit.cover),

                                  borderRadius: BorderRadius.all(Radius.circular(20)),

                                ),
                                child: InkWell(
                                  onTap: (){
                                    _launchFBURL();
                                  },
                                  child: Image.asset(
                                    "images/fb.png",
                                    width: size.width * 0.17,
                                    height: size.height * 0.1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    '  TO available 5 % Offer Follow our channels ,',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Text(
                                    '  Take screen shot  and show to Casher while paying your bill ',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      );
                  },
                ),
              ),
            ),
          );
        });
  }
}
