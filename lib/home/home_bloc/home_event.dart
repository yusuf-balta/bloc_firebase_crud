import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:coflow/models/product_model.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [UniqueKey()];
}

class InitialHomeEvent extends HomeEvent {}

class LogoutHomeEvent extends HomeEvent {}

class PushToLoginScreenHomeEvent extends HomeEvent {}

class ProductAddToDbHomeEvent extends HomeEvent {
  final ProductModel productModel;
  ProductAddToDbHomeEvent({
    required this.productModel,
  });
}
