import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UpdateProduct extends StatefulWidget {
  UpdateProduct(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,

      required this.price})
      : super(key: key);

  final String title;
  final String description;
  final String price;
  final int id;
  final String imageUrl;

  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateProduct> {
  final titleController = TextEditingController();
  final imageUrlController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  String mutationUpdate = '''
  mutation updateProduct(\$id:Int!,\$title:String!,\$imageUrl:String!,\$description:String!,\$price:String!){
  updateProduct(where: 
    {id: {_eq: \$id}}, 
    _set: {title: \$title, imageUrl: \$imageUrl,description: \$description, price: \$price}) {
  }
}
  ''';

  String mutationDelete = '''
 mutation deleteProduct(\$id:ID!) {
  deleteProduct(id: \$id)
}
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
      ),
      body: Mutation(
        options: MutationOptions(
          document: gql(mutationUpdate),
          update: (GraphQLDataProxy cacheUpdate, QueryResult? result) {
            return cacheUpdate;
          },
          onCompleted: (dynamic resultData) {
            Navigator.pop(context);
          },
        ),
        builder: (RunMutation runMutationUpdate, QueryResult? resultUpdate) {
          return Mutation(
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
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          helperText: "Update title", hintText: widget.title),
                      controller: titleController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          helperText: "Update description",
                          hintText: widget.description),
                      controller: descriptionController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          helperText: "Update imageUrl",
                          hintText: widget.imageUrl),
                      controller: imageUrlController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          helperText: "Update price", hintText: widget.price),
                      controller: priceController,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      onPressed: () => runMutationUpdate({
                        'id': widget.id,
                        'title': titleController.text,
                        'description': descriptionController.text,
                        'imageUrl': imageUrlController.text,
                        'price': priceController.text
                      }),
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () => runMutationDelete({'id': widget.id}),
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
