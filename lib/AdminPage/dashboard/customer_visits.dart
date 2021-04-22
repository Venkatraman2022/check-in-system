import 'dart:convert';
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';

class CustomerVisits extends StatefulWidget {

  @override
  _CustomerVisitsState createState() => _CustomerVisitsState();
}
class Record {
  final String name;
  final String mobile;
  final String guests;
  final String date;
  final String time;
  final DocumentReference reference;


  Record(this.name, this.mobile, this.guests, this.date,this.time, this.reference);
  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['mobile'] != null),
        assert(map['guests'] != null),
        assert(map['date'] != null),
        assert(map['time'] != null),
        name = map['name'],
        mobile = map['mobile'],
        guests = map['guests'],
        date = map['date'],
        time = map['time'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

}

class _CustomerVisitsState extends State<CustomerVisits> {
  List<List<String>> csvrow = [];
  DateTime currentDate = DateTime.now();
  var dateFormat = DateFormat('d-MM-yy');
  DateTime fromSelected;
  DateTime toSelected;
  bool filter;
  int  sortColumnIndex;
  List<DataRow> dataRows =[];
  List<Record> record ;

  List<User> usersFiltered = [];
  TextEditingController controller = TextEditingController();
  String _searchResult = '';


  @override
  void initState() {
    super.initState();
    usersFiltered =dataRows.cast<User>() ;
  }

  _showDateTimePicker() async {
    fromSelected = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );

    setState(() {});
  }
  _showDateTimePickerTo() async {
    toSelected = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );

    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var date = dateFormat.format(currentDate);
    var dates = new DateTime.now().toString();
    var dateParse = DateTime.parse(dates);
    var formattedDate = DateFormat('dd-MM-yy')
        .format(DateTime.parse(dateParse.toString()));
    var dateStringParsing = new Column(
      children: <Widget>[

        fromSelected != null
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                  new DateFormat('dd-MM-yy')
                      .format(DateTime.parse(fromSelected.toString())),
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.0180,
                  ),
                overflow: TextOverflow.ellipsis,
                ),
            )
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
          new DateFormat(date)
                .format(DateTime.parse("2018-09-15 20:18:04Z")),
          style: new TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.0180,
          ),
               overflow: TextOverflow.ellipsis,
        ),
            )
      ],
    );
    var dateStringParsingTo = new Column(
      children: <Widget>[

        toSelected != null
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            new DateFormat('dd-MM-yy')
                .format(DateTime.parse(toSelected.toString())),
            style: new TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.0180,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            new DateFormat(date)
                .format(DateTime.parse("2018-09-15 20:18:04Z")),
            style: new TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.0180,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );


    return

      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(color: Colors.grey.shade300,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))

                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.dashboard,size: size.width * 0.0150,),
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
                            color: Colors.blue,
                            fontSize: size.width * 0.0150,
                          ),
                        ),
                      ),
                  Icon(Icons.person,size: size.width * 0.0150,),
                  Text(
                    'Customer Visits',
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
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(color: Colors.grey.shade300,
                              borderRadius: BorderRadius.all(Radius.circular(8.0))

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Customer Visits',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.02,
                                ),
                              ),
                            ),
                          ),
                        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: size.height * 0.06,
                        // margin: const EdgeInsets.all(7.0),
                        // padding: const EdgeInsets.all(3.0),
                        // width:  size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                            borderRadius: BorderRadius.all(Radius.circular(8.0))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'From',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * 0.02,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.06,
                        // margin: const EdgeInsets.all(7.0),
                        // padding: const EdgeInsets.all(3.0),
                        // width:  size.width* 0.1,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade300,
                            borderRadius: BorderRadius.all(Radius.circular(8.0))
                          // border: Border(
                          //   right: BorderSide(
                          //     color: Colors.black,
                          //     width: 1.0,
                          //   ),
                          // ),
                        ),
                        child: dateStringParsing,
                      ),
                      InkWell(
                        onTap: (){

                          _showDateTimePicker();
                        },
                        child: Container(
                          width: size.width <= 800 ?  size.width * 0.08:size.width * 0.05,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.all(Radius.circular(8.0))
                            // border: Border(
                            //   right: BorderSide(
                            //     color: Colors.black,
                            //     width: 1.0,
                            //   ),
                            // ),
                          ),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            size:size.width <= 800 ?  size.width * 0.08:size.width * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      )

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: size.height * 0.06,
                        // margin: const EdgeInsets.all(7.0),
                        // padding: const EdgeInsets.all(3.0),
                        // width:  size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.all(Radius.circular(8.0))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'TO',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * 0.02,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.06,

                        decoration: BoxDecoration(
                            color: Colors.blueGrey.shade300,
                            borderRadius: BorderRadius.all(Radius.circular(8.0))
                        ),

                        child: dateStringParsingTo,
                      ),
                      InkWell(
                        onTap: (){

                          _showDateTimePickerTo();
                        },
                        child: Container(
                          width: size.width <= 800 ?  size.width * 0.08:size.width * 0.05,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            size: size.width <= 800 ?  size.width * 0.08:size.width * 0.02,
                            color: Colors.black,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Card(
                  child: SizedBox(
                    height: size.height* 0.06 ,
                    width:  size.width * 0.2,
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                          controller: controller,
                          decoration: new InputDecoration(
                              hintText: 'Search', border: InputBorder.none),
                          onChanged: (value) {
                            setState(() {
                              _searchResult = value;
                              // usersFiltered = users.where((user) => user.name.contains(_searchResult)).toList();
                            });
                          }),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: () {
                          setState(() {
                            controller.clear();
                            _searchResult = '';
                            // usersFiltered = users;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StreamBuilder(
              stream:    fromSelected != null && toSelected != null ?  FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.displayName).doc('totalCustomers').collection('customerTotal').where('date',isGreaterThanOrEqualTo:DateFormat('dd-MM-yy')
          .format(DateTime.parse(fromSelected.toString())),).where('date',isLessThanOrEqualTo: DateFormat('dd-MM-yy')
          .format(DateTime.parse(toSelected.toString())),).orderBy('date',).snapshots():
      FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.displayName).doc('customerDetails').collection(formattedDate.toString()).orderBy('time',descending: true).snapshots(),
        builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  print(snapshot.data);

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  getlist(snapshot);
                  return SingleChildScrollView(
                    child: DataTable(
                      sortAscending: true,
                      sortColumnIndex: sortColumnIndex,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 1,)
                      ),
                      showBottomBorder: true,
                      columnSpacing: size.width * 0.1,
                      columns: [
                        DataColumn(label: Text('SI.No', style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: size.width * 0.02,
                                                            ),)),
                        DataColumn(
                            label: Text('Name',style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.02,
                        ),)),
                        DataColumn(label: Text('Mobile',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.02,
                          ),),),
                        DataColumn(label: Text('No Of Circle',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.016,
                          ),),),
                        DataColumn(
                          label: Text('Visit Date',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.016,
                          ),),),
                        DataColumn(
                          label: Text('Time',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.02,
                            ),),),
                      ],
                      rows:  _buildList(context, snapshot.data.documents,snapshot.data.docs.length, _searchResult),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(

                      onPressed: () async {
                        final csvData = ListToCsvConverter().convert(csvrow);
                        html.AnchorElement()
                          ..href =
                              '${Uri.dataFromString(csvData, mimeType: 'text/csv', encoding: utf8)}'
                          ..download = 'data.csv'
                          ..style.display = 'none'
                          ..click();
                      },
                      child: Text('Export as CSV')),
                ),
              ],
            )
          ],
        ),
      );

  }
  List getlist(AsyncSnapshot snapshot) {
    return snapshot.data.docs.forEach((element) {
      csvrow.add([
        element.get('name'),
        element.get('mobile'),
        element.get('guests'),
        element.get('date'),
        element.get('time'),
      ]);
    });
  }
  List<DataRow> _buildList(BuildContext context, List<DocumentSnapshot> data,int  snap, String _searchKey) {

    dataRows.clear();
    int k=1;
    print("---->SearchKey ${_searchKey.toString()} ");
    for (int i = 0; i <snap; i++) {
      var record = Record.fromSnapshot(data[i]);

      // print('len $snap');
      if(record.name.toLowerCase().contains(_searchKey.toLowerCase()))
       {
         dataRows.add(DataRow(cells: [
           DataCell(Text((k++).toString())),
           DataCell(Text(record.name.toString())),
           DataCell(Text(record.mobile.toString())),
           DataCell(Text(record.guests.toString())),
           DataCell(Text(record.date.toString())),
           DataCell(Text(record.time.toString())),
         ]));
       }
    }
    print("===datarows ${dataRows.length}");
    return dataRows;
  }


}


