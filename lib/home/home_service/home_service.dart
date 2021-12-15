import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coflow/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addProductToDb(ProductModel productModel) async {
    CollectionReference product = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('products');

    product.doc(productModel.uuid).set(productModel.toMap());
  }

  Future<void> updateProductToDb(ProductModel productModel) async {
    CollectionReference product = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('products');
    product.doc(productModel.uuid).set(productModel.toMap());
  }

  Future<void> deleteProductToDb(ProductModel productModel) async {
    CollectionReference product = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('products');
    product.doc(productModel.uuid).delete();
  }

  Future<QuerySnapshot> getProductFromDb() async {
    CollectionReference listProducts = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('products');

    QuerySnapshot prodcuts = await listProducts.get();
    return prodcuts;
  }
}
