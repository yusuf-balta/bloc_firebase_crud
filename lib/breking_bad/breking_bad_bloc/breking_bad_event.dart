import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BrekingBadEvent extends Equatable {
  @override
  List<Object?> get props => [UniqueKey()];
}

class InitialBrekingBadEvent extends BrekingBadEvent {}
