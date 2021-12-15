import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:coflow/models/breking_bad_model.dart';

abstract class BrekingBadState extends Equatable {
  List<Object?> get props => [UniqueKey()];
}

class InitialBrekingBadState extends BrekingBadState {}

class LoadingBrekingBadState extends BrekingBadState {}

class SuccsesBrekingBadState extends BrekingBadState {
  final List<BrekingBadModel> listBrekingBadModels;
  SuccsesBrekingBadState({
    required this.listBrekingBadModels,
  });
}

class FailedBrekingBadState extends BrekingBadState {}
