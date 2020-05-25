import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:algoliaexample/search_service.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _searchText = TextEditingController(text: "");

  List<AlgoliaObjectSnapshot> _results = [];

  Future _search(String searchText) async{
    setState(() {
    //  searching set state
    });
    var algolia = SearchService().algolia();

    AlgoliaQuery query = algolia.instance.index('grade');
    query = query.search(_searchText.text);
    _results =(await query.getObjects()).hits;


    return _results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        title: Text('Algolia Example'),
        brightness: Brightness.light,
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.lightBlue,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            onChanged: _search,
                            controller: _searchText,
                            decoration: InputDecoration(
                              hintText: 'Search text..',
                              hintStyle: TextStyle(fontSize: 14,),
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Container(
                                margin: EdgeInsets.only(bottom: 0),
                                child: Icon(Icons.search, color: Colors.lightBlue,),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.lightBlue, size: 20,),
                          onPressed: () {
                            _searchText.text = "";
                            setState(() {
                              _results.clear();
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Expanded(
              flex: 1,
              child:  ListView.builder(
                itemCount: _results.length,
                itemBuilder: (BuildContext ctx, int index){
                  AlgoliaObjectSnapshot snap = _results[index];
                  return  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16.0,bottom: 8,top: 8),
                    child: Material(
                      color: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.black26,
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start  ,
                              children: <Widget>[
                                Text(
                                  snap.data['name'],
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
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
        ],
      ),
    );

  }
}
