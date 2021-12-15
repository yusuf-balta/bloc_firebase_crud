import 'dart:convert';

import 'package:flutter/foundation.dart';

class BrekingBadModel {
  int? char_id;
  String? name;
  String? birthday;
  List<String>? occupation;
  String? img;
  String? status;
  String? nickname;
  List<int>? appearance;
  String? portrayed;
  List<int>? better_call_saul_appearance;
  BrekingBadModel({
    this.char_id,
    this.name,
    this.birthday,
    this.occupation,
    this.img,
    this.status,
    this.nickname,
    this.appearance,
    this.portrayed,
    this.better_call_saul_appearance,
  });

  BrekingBadModel copyWith({
    int? char_id,
    String? name,
    String? birthday,
    List<String>? occupation,
    String? img,
    String? status,
    String? nickname,
    List<int>? appearance,
    String? portrayed,
    List<int>? better_call_saul_appearance,
  }) {
    return BrekingBadModel(
      char_id: char_id ?? this.char_id,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      occupation: occupation ?? this.occupation,
      img: img ?? this.img,
      status: status ?? this.status,
      nickname: nickname ?? this.nickname,
      appearance: appearance ?? this.appearance,
      portrayed: portrayed ?? this.portrayed,
      better_call_saul_appearance:
          better_call_saul_appearance ?? this.better_call_saul_appearance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'char_id': char_id,
      'name': name,
      'birthday': birthday,
      'occupation': occupation,
      'img': img,
      'status': status,
      'nickname': nickname,
      'appearance': appearance,
      'portrayed': portrayed,
      'better_call_saul_appearance': better_call_saul_appearance,
    };
  }

  factory BrekingBadModel.fromMap(Map<String, dynamic> map) {
    return BrekingBadModel(
      char_id: map['char_id']?.toInt(),
      name: map['name'],
      birthday: map['birthday'],
      occupation: List<String>.from(map['occupation']),
      img: map['img'],
      status: map['status'],
      nickname: map['nickname'],
      appearance: List<int>.from(map['appearance']),
      portrayed: map['portrayed'],
      better_call_saul_appearance:
          List<int>.from(map['better_call_saul_appearance']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BrekingBadModel.fromJson(String source) =>
      BrekingBadModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BrekingBadModel(char_id: $char_id, name: $name, birthday: $birthday, occupation: $occupation, img: $img, status: $status, nickname: $nickname, appearance: $appearance, portrayed: $portrayed, better_call_saul_appearance: $better_call_saul_appearance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BrekingBadModel &&
        other.char_id == char_id &&
        other.name == name &&
        other.birthday == birthday &&
        listEquals(other.occupation, occupation) &&
        other.img == img &&
        other.status == status &&
        other.nickname == nickname &&
        listEquals(other.appearance, appearance) &&
        other.portrayed == portrayed &&
        listEquals(
            other.better_call_saul_appearance, better_call_saul_appearance);
  }

  @override
  int get hashCode {
    return char_id.hashCode ^
        name.hashCode ^
        birthday.hashCode ^
        occupation.hashCode ^
        img.hashCode ^
        status.hashCode ^
        nickname.hashCode ^
        appearance.hashCode ^
        portrayed.hashCode ^
        better_call_saul_appearance.hashCode;
  }
}
