import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Generate a list of fiction prodcts
  // final List<Map> _products = List.generate(30, (i) {
  //   return {"id": i, "name": "Product $i", "price": Random().nextInt(200) + 1};
  // });
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  int _currentSortColumn = 0;
  bool _isAscending = true;
  List<TableData> tabledata = [];
  List<Map> _products = [];
  getdata() async {
    print('getdata');
    await FirebaseFirestore.instance
        .collection('posshop')
        .doc('itemDetails')
        .collection('items')
        .get().then((value) {
      value.docs.forEach((element) {
        List dat = element.get('cat');
        print(dat[0]);
        tabledata.add(TableData(
          item: element.get('name'),
          image: element.get('imgUrl'),
          price: element.get('price'),
          category: dat.join('').toString(),

        ));
        print(tabledata);
      });
    });
    tabledata.map((data){
      print('${data.item} \t${data.price} \t${data.image}');
      if(data.image.contains(controller.text.toLowerCase())){
        print('top search ${controller.text}');
        _products.add({'item': data.item, 'image': data.image, 'price': data.price, 'category': data.category});
      }
      return
          _products;
    } ).toList();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init');
    getdata();
  }
  @override
  Widget build(BuildContext context) {
Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Kindacode.com'),
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: SizedBox(
                    height: size.height * 0.06,
                    width: size.width * 0.4,
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                          controller: controller,
                          decoration: new InputDecoration(
                              hintText: 'Search', border: InputBorder.none),
                          onChanged: (value) {
                            setState(() {
                              _searchResult = value;
                              print(_searchResult);
                              // usersFiltered = users.where((user) => user.name.contains(_searchResult)).toList();
                            });
                          }),
                      trailing: new IconButton(
                        icon: new Icon(controller.text != ''
                            ? Icons.cancel
                            : Icons.more_horiz),
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
                DataTable(
                  sortColumnIndex: _currentSortColumn,
                  sortAscending: _isAscending,
                  headingRowColor: MaterialStateProperty.all(Colors.amber[200]),
                  columns: [
                    DataColumn(label: Text('Item')),
                    DataColumn(label: Text('Category')),

                    DataColumn(
                        label: Text(
                          'Price',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),

                        // Sorting function
                        onSort: (columnIndex, _) {
                          setState(() {
                            _currentSortColumn = columnIndex;
                            if (_isAscending == true) {
                              _isAscending = false;
                              // sort the product list in Ascending, order by Price
                              _products.sort((productA, productB) =>
                                  productB['price'].compareTo(productA['price']));
                            } else {
                              _isAscending = true;
                              // sort the product list in Descending, order by Price
                              _products.sort((productA, productB) =>
                                  productA['price'].compareTo(productB['price']));
                            }
                          });
                        }
                        ),
                    DataColumn(label: Text('Image')),
                  ],
                  rows: _products.map((item) {
                    print('${item['item']} \t${item['price']} \t${item['image']}');
                    return DataRow(cells: [
                      DataCell(Text(item['item'].toString())),
                      DataCell(Text(item['category'].toString())),

                      DataCell(Text(item['price'].toString())),
                    DataCell(Text(item['image'].toString())),
                    ]);
                  }).toList(),
                ),
              ],
            ),
          ),
        ));
  }
}

class TableData{
  String item;
  String category;
  double price;
  String image;
  TableData({this.item,this.price,this.image,this.category});
}