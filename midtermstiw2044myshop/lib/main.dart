import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:midtermstiw2044myshop/newproduct.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ProductsScreen(),
      ),
    );
  }
}
class ProductsScreen extends StatefulWidget {
  
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String titlecenter = "Loading...";
  double screenHeight, screenWidth;
   List _productList;

    void initState() {
    super.initState();
    _loadGrams();
  }
  @override
  Widget build(BuildContext context) {
    
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: Center(
        child: Column(
          children: [
            _productList == null 
            ? Flexible(
                child: Center(
                  child: Text("No data")),
            )
            : Flexible(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: GridView.builder(
                      itemCount: _productList.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: (screenWidth / screenHeight) /1),
                        itemBuilder: (BuildContext context, int index){
                          return Card(
                            child: InkWell(
                              onTap: (){
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color:Colors.grey[600],
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(1, 1),
                                    ),
                                  ]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius:BorderRadius.only(
                                      topLeft:Radius.circular(10),
                                      topRight:Radius.circular(10),),
                                      child: CachedNetworkImage(
                                        imageUrl: "https://crimsonwebs.com/s272043/myshop/images/${_productList[index]['id']}.png",
                                        height: 185,
                                        width: 185,)
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:[
                                        Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                                        child: Text(_productList[index]['name'],
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 18)),
                                        ),
                                      ] 
                                    ), 
                                    Row(
                                      children: [
                                    Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 15, 5, 0),
                                          child: Text("RM: " + _productList[index]['price'],
                                          style: TextStyle(fontSize:18),),
                                        ),
                                        ],),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                          child: Text(_productList[index]['type'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize:16,),),
                                        ),
                                        
                                      ],),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                          child: Text("Quantity Available: "+_productList[index]['qty'],
                                          style: TextStyle(fontSize:16),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                    ),
                  ),
              )
            ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context)=>TabNewProduct())
          );
        },
        child: Icon(Icons.add),),
    
    );
  }

   void _loadGrams() {
    http.post(
        Uri.parse("https://crimsonwebs.com/s272043/myshop/php/loadproduct.php"),
         body: {
          
        }
        ).then((response) {
      if (response.body == "nodata") {
        titlecenter = "Sorry no gram available";
        return;
      } else {
        var jsondata = json.decode(response.body);
        _productList = jsondata["products"];
        titlecenter = "Contain Data";
        setState(() {});
        print(_productList);
      }
    });
  }
}