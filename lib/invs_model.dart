import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class InvList {
  final List<InvsModel> list;

  InvList({
    required this.list,
  });

  @override
  String toString() => ' $list';

  InvList copyWith({
    List<InvsModel>? list,
  }) {
    return InvList(
      list: list ?? this.list,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'list': list.map((x) => x.toMap()).toList(),
    };
  }

  factory InvList.fromMap(Map<String, dynamic> map) {
    return InvList(
      list: List<InvsModel>.from(
        (map['list'] as List<int>).map<InvsModel>(
          (x) => InvsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory InvList.fromJson(String source) =>
      InvList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant InvList other) {
    if (identical(this, other)) return true;

    return listEquals(other.list, list);
  }

  @override
  int get hashCode => list.hashCode;
}

class InvsModel {
  final String name;
  final String price;

  InvsModel(
    this.name,
    this.price,
  );

  InvsModel copyWith({
    String? name,
    String? price,
  }) {
    return InvsModel(
      name ?? this.name,
      price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
    };
  }

  factory InvsModel.fromMap(Map<String, dynamic> map) {
    return InvsModel(
      map['name'] as String,
      map['price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvsModel.fromJson(String source) =>
      InvsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => ' $name \t\t\t\t  \$$price \n';

  @override
  bool operator ==(covariant InvsModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode;
}
