import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DeleteProduct extends StatefulWidget {
  DeleteProduct({Key? key, required this.id}) : super(key: key);
  String id;
  @override
  State<DeleteProduct> createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
  String mutationDelete = '''
 mutation deleteProduct(\$id:ID!) {
  deleteProduct(id: \$id)
}
  ''';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Confirmation"),
          ),
          body: Mutation(
              options: MutationOptions(
                document: gql(mutationDelete),
                update: (GraphQLDataProxy cacheDelete, QueryResult? result) {
                  return cacheDelete;
                },
                onCompleted: (dynamic resultData) {
                  Navigator.pop(context);
                },
              ),
              builder:
                  (RunMutation runMutationDelete, QueryResult? resultDelete) {
                return Center(
                    child: Container(
                      height: 300,
                      width: 300,
                      color: Colors.blueGrey,
                      padding:EdgeInsets.only(top:50),
                  margin: EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(30),
                        child: Text("Are you sure ?")),
                        SizedBox(
                          height:30,
                        ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                          RaisedButton(
                            color:Colors.red,
                              onPressed: () => setState(() {
                                    runMutationDelete({'id': widget.id});
                                  }),
                              child: Text("Delete"))
                        ],
                      )
                    ],
                  ),
                ));
              })),
    );
  }
}//+251 91 224 2780
