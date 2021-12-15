import 'dart:convert';

class PersonModel {
  String? userName;
  String? phoneNumber;
  DateTime? birthDay;
  String? mailAdress;
  String? password;
  PersonModel({
    this.userName,
    this.phoneNumber,
    this.birthDay,
    this.mailAdress,
    this.password,
  });

  PersonModel copyWith({
    String? userName,
    String? phoneNumber,
    DateTime? birthDay,
    String? mailAdress,
    String? password,
  }) {
    return PersonModel(
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDay: birthDay ?? this.birthDay,
      mailAdress: mailAdress ?? this.mailAdress,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'phoneNumber': phoneNumber,
      'birthDay': birthDay?.millisecondsSinceEpoch,
      'mailAdress': mailAdress,
      'password': password,
    };
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(
      userName: map['userName'],
      phoneNumber: map['phoneNumber'],
      birthDay: map['birthDay'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthDay'])
          : null,
      mailAdress: map['mailAdress'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonModel.fromJson(String source) =>
      PersonModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PersonModel(userName: $userName, phoneNumber: $phoneNumber, birthDay: $birthDay, mailAdress: $mailAdress, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonModel &&
        other.userName == userName &&
        other.phoneNumber == phoneNumber &&
        other.birthDay == birthDay &&
        other.mailAdress == mailAdress &&
        other.password == password;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        phoneNumber.hashCode ^
        birthDay.hashCode ^
        mailAdress.hashCode ^
        password.hashCode;
  }
}
