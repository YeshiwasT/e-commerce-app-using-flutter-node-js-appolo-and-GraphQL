// ignore_for_file: dead_code, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:uuid/uuid.dart';

class ProductPost extends StatefulWidget {
  const ProductPost({Key? key}) : super(key: key);

  @override
  _ProductPostState createState() => _ProductPostState();
}

class _ProductPostState extends State<ProductPost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final imageUrlController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  var uuid = Uuid();
  String mutation = '''
mutation createProduct(
  \$title:String!,
  \$description: String!,
  \$imageUrl: String!,
 \$price: String!){
   createProduct(
    title:\$title,
    description: \$description,
    imageUrl: \$imageUrl,
    price:\$price)
   }'''.replaceAll('\n', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Add Item To Sell")),
      body: 
Mutation(
  options: MutationOptions(
    document: gql(mutation),
    update: (GraphQLDataProxy cache, QueryResult? result) {
      return cache;},
    onCompleted: (dynamic resultData) {
      print(resultData);
    }, ), 
  builder: (RunMutation runMutation,QueryResult? result,) {
    return 
      Column(
          children:<Widget> [
                TextField(
                  controller: titleController,
                  decoration:
                      InputDecoration(hintText: 'Title', labelText: 'Title'),
                ),
                TextField(
                  controller: imageUrlController,
                  decoration: InputDecoration(
                      hintText: 'imageUrl', labelText: 'imageUrl'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: 'Description', labelText: 'Description'),
                ),
                TextField(
                  controller: priceController,
                  decoration:
                      InputDecoration(hintText: 'Price', labelText: 'Price'),
                ),
                Expanded(
                  child: Align(
                    heightFactor: 2,
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: () => runMutation({
                          'title':titleController.text,
                          'description':descriptionController.text,
                          'imageUrl':imageUrlController.text,
                          'price':priceController.text
                          }),
                        child: Text('Post Item')),
                  ),
                )
              ]);},)); } }

