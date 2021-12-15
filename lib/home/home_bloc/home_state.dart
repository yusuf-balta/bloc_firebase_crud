import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:coflow/models/product_model.dart';

abstract class HomeState extends Equatable {
  List<Object?> get props => [UniqueKey()];
}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class SuccsesHomeState extends HomeState {
  final List<ProductModel> productsModel;
  SuccsesHomeState({
    required this.productsModel,
  });
}

class FailedHomeState extends HomeState {
  final String error;
  FailedHomeState({
    required this.error,
  });
}

class LogoutLoadingHomeState extends HomeState {}

class LogoutSuccsesHomeState extends HomeState {}

class LogoutFailedHomeState extends HomeState {}

class PushToLoginScreenHomeState extends HomeState {}
