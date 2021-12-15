import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProductViewState extends Equatable {
  List<Object?> get props => [UniqueKey()];
}

class InitialProductViewState extends ProductViewState {}

class LoadingProductViewState extends ProductViewState {}

class LoadingAddToDbProductViewState extends ProductViewState {}

class SuccsesAddToDbProductViewState extends ProductViewState {}

class FailedAddToDbProductViewState extends ProductViewState {}

class LoadingUpdateToDbProductViewState extends ProductViewState {}

class SuccsesUpdateToDbProductViewState extends ProductViewState {}

class FailedUpdateToDbProductViewState extends ProductViewState {}

class LoadingDeleteToDbProductViewState extends ProductViewState {}

class SuccsesDeleteToDbProductViewState extends ProductViewState {}

class FailedDeleteToDbProductViewState extends ProductViewState {}

class PushToHomeScreenProductViewState extends ProductViewState {}
