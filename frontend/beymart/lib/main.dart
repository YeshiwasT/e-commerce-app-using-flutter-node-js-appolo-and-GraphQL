import 'package:beymart/product_post.dart';
import 'package:beymart/update_product.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const productsGRaphQL = """ query getDepartment{
  getProducts {
    title
    description
    imageUrl
    price
  }

}""";
void main() {
  final HttpLink httpLink = HttpLink("http://10.0.2.2:5000/");
  ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  ));
  var app = GraphQLProvider(client: client, child: MyApp());
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ' Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return 
    
    SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductPost()));
            }, 
            icon: Icon(
              Icons.add))
           ],
          title: Text(widget.title)),
        body: Query(
          options: QueryOptions(document: gql(productsGRaphQL)),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              print(result.exception.toString());
              return Text(result.exception.toString()+"kkkkkkkkkkkkkkkkkkkkkk");
            }
            if (result.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            print("hellllo");
    
            final productList = result.data?['getProducts'];
            print(productList.length);
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Your Products"),
                  ),
                  Expanded(
                      child: GridView.builder(
                    itemCount: productList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      
                      return  GridTile(
                              child: GestureDetector(
                                onTap: () => {
                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UpdateProduct(id:int.parse(productList[index]['id']),title: productList[index]['title'],description: productList[index]['description'],imageUrl: productList[index]['imageUrl'],price: productList[index]['price'])))
                                
                                },
                                child: Container(
                                    child:
                                        Image.asset(productList[index]['imageUrl'])),
                              ),
                              header: GridTileBar(
                               
                                
                               title: Text("", style: TextStyle(color: Colors.white)),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,  ),
                                  onPressed: () => {
                                    
                                  },
                                  color: Colors.black,
                                ),
                              ),
                              footer: GridTileBar(
                                backgroundColor: Color.fromRGBO(0, 0, 0, 0.65),
                                leading: Text(
                                  productList[index]['title'],
                                  style: TextStyle(color: Colors.white),
                                ),
                                title:
                                    Text("", style: TextStyle(color: Colors.white)),
                                trailing: Text(
                                    productList[index]['price'],
                                    style: TextStyle(color: Colors.black)),
                              ));}
                        ),
                      
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
