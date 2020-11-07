import 'dart:convert';

class TestModel {
  final String reciveLastDate;
  final String reciveLastQty;
  final String saleAfterRC;
  final String stkWh;
  final String saleLastDate;
  TestModel({
    this.reciveLastDate,
    this.reciveLastQty,
    this.saleAfterRC,
    this.stkWh,
    this.saleLastDate,
  });

  TestModel copyWith({
    String reciveLastDate,
    String reciveLastQty,
    String saleAfterRC,
    String stkWh,
    String saleLastDate,
  }) {
    return TestModel(
      reciveLastDate: reciveLastDate ?? this.reciveLastDate,
      reciveLastQty: reciveLastQty ?? this.reciveLastQty,
      saleAfterRC: saleAfterRC ?? this.saleAfterRC,
      stkWh: stkWh ?? this.stkWh,
      saleLastDate: saleLastDate ?? this.saleLastDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ReciveLastDate': reciveLastDate,
      'ReciveLastQty': reciveLastQty,
      'SaleAfterRC': saleAfterRC,
      'StkWh': stkWh,
      'SaleLastDate': saleLastDate,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return TestModel(
      reciveLastDate: map['ReciveLastDate'],
      reciveLastQty: map['ReciveLastQty'],
      saleAfterRC: map['SaleAfterRC'],
      stkWh: map['StkWh'],
      saleLastDate: map['SaleLastDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TestModel.fromJson(String source) => TestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TestModel(reciveLastDate: $reciveLastDate, reciveLastQty: $reciveLastQty, saleAfterRC: $saleAfterRC, stkWh: $stkWh, saleLastDate: $saleLastDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is TestModel &&
      o.reciveLastDate == reciveLastDate &&
      o.reciveLastQty == reciveLastQty &&
      o.saleAfterRC == saleAfterRC &&
      o.stkWh == stkWh &&
      o.saleLastDate == saleLastDate;
  }

  @override
  int get hashCode {
    return reciveLastDate.hashCode ^
      reciveLastQty.hashCode ^
      saleAfterRC.hashCode ^
      stkWh.hashCode ^
      saleLastDate.hashCode;
  }
}
