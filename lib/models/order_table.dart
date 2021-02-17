class OrderTable {
  String _orderId, _date;
  int _id;
  double _price;

  OrderTable(this._orderId, this._date, this._price);

  String get orderId => _orderId;
  String get date => _date;
  int get id => _id;
  double get price => _price;

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }

    map['order_id'] = _orderId;
    map['date'] = _date;
    map['price'] = _price;

    return map;
  }

  // Extract a Note object from a Map object
  OrderTable.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._orderId = map['order_id'];
    this._date = map['date'];
    this._price = map['price'];
  }
}
