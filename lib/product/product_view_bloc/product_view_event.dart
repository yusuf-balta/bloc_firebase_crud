import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:coflow/models/product_model.dart';

abstract class ProductViewEvent extends Equatable {
  @override
  List<Object?> get props => [UniqueKey()];
}

class AddToDbProductViewEvent extends ProductViewEvent {
  final ProductModel productModel;
  AddToDbProductViewEvent({
    required this.productModel,
  });
}

class UpdateToDbProductViewEvent extends ProductViewEvent {
  final ProductModel productModel;
  UpdateToDbProductViewEvent({
    required this.productModel,
  });
}

class DeleteToDbProductViewEvent extends ProductViewEvent {
  final ProductModel productModel;
  DeleteToDbProductViewEvent({
    required this.productModel,
  });
}

class PushToHomeScrrenProductViewEvent extends ProductViewEvent {}
