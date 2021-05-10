import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';



class BusinessProfile extends StatefulWidget {
  @override
  _BusinessProfileState createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateCountryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController gstINController = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(mask: '+61 (##) ####-####', filter: { "#": RegExp(r'[0-9]') });

  String shopName;
  String address;
  String stateCountry;
  String phone;
  String gstIN;

  bool check;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,color:  Color(0xFFF37325),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "images/wel.png",
                            width: size.width * 0.01,
                            height: size.height * 0.01,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width* 0.01,
                      ),
                      Text(
                        'Dashboard',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width * 0.0150,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '/',
                          style: TextStyle(
                            color: Colors.deepOrange[300],
                            fontSize: size.width * 0.0150,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.person,
                        size: size.width * 0.0150,
                      ),
                      Text(
                        'Business Profile',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width * 0.0150,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StatefulBuilder(
                  builder:   (BuildContext context,
                      StateSetter showstate) {
                    return SizedBox(
                      height: size.height * 0.6,
                      width: size.width * 0.6,
                      child: Card(
                        color: Colors.grey[300],
                        elevation: 20,
                        child: Center(
                          child: Container(
                            height: size.height * 0.43,
                            width: size.width * 0.4,
                            // decoration: BoxDecoration(
                            //   border: Border(
                            //     left: BorderSide(
                            //       //                   <--- left side
                            //       color: Colors.deepOrange[100],
                            //       width: 15.0,
                            //     ),
                            //     top: BorderSide(
                            //       //                    <--- top side
                            //       color: Colors.deepOrange[100],
                            //       width: 10.0,
                            //     ),
                            //     right: BorderSide(
                            //       //                    <--- top side
                            //       color: Colors.deepOrange[500],
                            //       width: 5.0,
                            //     ),
                            //     bottom: BorderSide(
                            //       //                    <--- top side
                            //       color: Colors.deepOrange[800],
                            //       width: 3.0,
                            //     ),
                            //   ),
                            // ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection(FirebaseAuth.instance.currentUser.displayName)
                                      .doc("businessProfile").snapshots(),
                                  builder: (context, snapshot) {
                                    if(!snapshot.hasData || snapshot.hasError){
                                      check = false;
                                      print(check);
                                      return
                                          Column(
                                            children: [
                                              Text('Loading Please wait'),
                                              CircularProgressIndicator(),
                                            ],
                                          );
                                    }
                                    // print(snapshot.data['shopName']);

                                    else{
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text('Business Profile',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:20,),),
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  border: Border.all(color: Colors.grey.shade400)),
                                              height: size.height * 0.06,
                                              width: size.width * 0.1,
                                              child: Center(
                                                child: Text(
                                                  'Shop Name',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: size.width * 0.01,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: size.height * 0.06,
                                              width: size.width * 0.275,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: Colors.grey.shade400)),
                                              child: TextFormField(
                                                validator: (String value) {
                                                  if (value.length < 3)
                                                    return " Enter at least 3 character from Customer Name";
                                                  else
                                                    return null;
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                      RegExp('[a-z,A-Z]')),],
                                                textCapitalization: TextCapitalization.words,
                                                keyboardType: TextInputType.text,
                                                controller: shopNameController,
                                                onChanged: (value){
                                                  // itemName = value;
                                                },
                                                autofillHints: [AutofillHints.givenName],
                                                decoration: InputDecoration(
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    hintText:'${snapshot.data['shopName']}' ,
                                                    hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontStyle: FontStyle.italic,
                                                      fontSize: size.width * 0.01,
                                                    ),
                                                    hoverColor: Colors.white,
                                                    filled: true,
                                                    focusColor: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  border: Border.all(color: Colors.grey.shade400)),
                                              height: size.height * 0.06,
                                              width: size.width * 0.1,
                                              child: Center(
                                                child: Text(
                                                  'Address',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: size.width * 0.01,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: size.height * 0.06,
                                              width: size.width * 0.275,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: Colors.grey.shade400)),
                                              child: TextFormField(
                                                validator: (String value) {
                                                  if (value.length < 3)
                                                    return " Enter at least 3 character from Customer Name";
                                                  else
                                                    return null;
                                                },
                                                textCapitalization: TextCapitalization.words,
                                                keyboardType: TextInputType.text,
                                                controller: addressController,
                                                onChanged: (value){
                                                  // taxes = int.parse(value);
                                                },
                                                autofillHints: [AutofillHints.givenName],
                                                decoration: InputDecoration(
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    hintText: '${snapshot.data['address']}' ,
                                                    hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontStyle: FontStyle.italic,
                                                      fontSize: size.width * 0.01,
                                                    ),
                                                    hoverColor: Colors.white,
                                                    filled: true,
                                                    focusColor: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ), Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  border: Border.all(color: Colors.grey.shade400)),
                                              height: size.height * 0.06,
                                              width: size.width * 0.1,
                                              child: Center(
                                                child: Text(
                                                  'State & Country',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: size.width * 0.01,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: size.height * 0.06,
                                              width: size.width * 0.275,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: Colors.grey.shade400)),
                                              child: TextFormField(
                                                validator: (String value) {
                                                  if (value.length < 3)
                                                    return " Enter at least 3 character from Customer Name";
                                                  else
                                                    return null;
                                                },
                                                textCapitalization: TextCapitalization.words,
                                                keyboardType: TextInputType.text,
                                                controller: stateCountryController,
                                                onChanged: (value){
                                                  // taxes = int.parse(value);
                                                },
                                                autofillHints: [AutofillHints.givenName],
                                                decoration: InputDecoration(
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    hintText: '${snapshot.data['stateCountry']}',
                                                    hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontStyle: FontStyle.italic,
                                                      fontSize: size.width * 0.01,
                                                    ),
                                                    hoverColor: Colors.white,
                                                    filled: true,
                                                    focusColor: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ), Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  border: Border.all(color: Colors.grey.shade400)),
                                              height: size.height * 0.06,
                                              width: size.width * 0.1,
                                              child: Center(
                                                child: Text(
                                                  'Phone',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: size.width * 0.01,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: size.height * 0.06,
                                              width: size.width * 0.275,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: Colors.grey.shade400)),
                                              child: TextFormField(
                                                validator: (String value) {
                                                  if (value.length < 3)
                                                    return " Enter at least 3 character from Customer Name";
                                                  else
                                                    return null;
                                                },
                                                inputFormatters: [
                                                  maskFormatter,
                                                ],
                                                textCapitalization: TextCapitalization.words,
                                                keyboardType: TextInputType.text,
                                                controller: phoneController,
                                                onChanged: (value){
                                                  // price = double.parse(value);
                                                },
                                                autofillHints: [AutofillHints.givenName],
                                                decoration: InputDecoration(
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    hintText: '${snapshot.data['phone']}',
                                                    hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontStyle: FontStyle.italic,
                                                      fontSize: size.width * 0.01,
                                                    ),
                                                    hoverColor: Colors.white,
                                                    filled: true,
                                                    focusColor: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  border: Border.all(color: Colors.grey.shade400)),
                                              height: size.height * 0.06,
                                              width: size.width * 0.1,
                                              child: Center(
                                                child: Text(
                                                  'GSTIN',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: size.width * 0.01,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: size.height * 0.06,
                                              width: size.width * 0.275,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: Colors.grey.shade400)),
                                              child: TextFormField(
                                                validator: (String value) {
                                                  if (value.length < 3)
                                                    return " Enter at least 3 character from Customer Name";
                                                  else
                                                    return null;
                                                },
                                                textCapitalization: TextCapitalization.words,
                                                keyboardType: TextInputType.text,
                                                controller: gstINController,
                                                onChanged: (value){
                                                  // price = double.parse(value);
                                                },
                                                autofillHints: [AutofillHints.givenName],
                                                decoration: InputDecoration(
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    hintText: '${snapshot.data['gstIN']}',
                                                    hintStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontStyle: FontStyle.italic,
                                                      fontSize: size.width * 0.01,
                                                    ),
                                                    hoverColor: Colors.white,
                                                    filled: true,
                                                    focusColor: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: ()async{
                                            shopName = shopNameController.text == '' ? snapshot.data['shopName']: shopNameController.text;
                                            address = addressController.text == '' ? snapshot.data['address']: addressController.text;
                                            stateCountry = stateCountryController.text == '' ? snapshot.data['stateCountry']: stateCountryController.text;
                                            phone = phoneController.text == '' ? snapshot.data['phone']: phoneController.text;
                                            gstIN = gstINController.text == '' ? snapshot.data['gstIN']: gstINController.text;


                                            await FirebaseFirestore.instance
                                                .collection(FirebaseAuth.instance.currentUser.displayName)
                                                .doc("businessProfile")
                                                .set({
                                              "shopName": shopName,
                                              "address": address,
                                              "stateCountry": stateCountry,
                                              "phone": phone,
                                              "gstIN": gstIN,
                                            }).then((value) {
                                              shopNameController.text = '';
                                              addressController.text = '';
                                              stateCountryController.text = '';
                                              phoneController.text = '';
                                              gstINController.text = '';
                                              print('firebase updated');
                                            });
                                          },
                                          child: Card(
                                            color: Colors.deepOrange,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text('Save',style: TextStyle(color: Colors.white),),
                                            ),
                                          ),
                                        )
                                      ],
                                    );}
                                  }
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
