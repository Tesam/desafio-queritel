import 'dart:typed_data';

class CartTable {
  String _itemName, _itemCategory, _itemBrand, _weightLabel, _state;
  int _id;
  double _itemPrice, _itemQuantity, _weight;
  Uint8List _imgUrl;

  CartTable(
    this._itemName,
    this._itemCategory,
    this._itemBrand,
    this._weightLabel,
    this._state,
    this._id,
    this._itemPrice,
    this._itemQuantity,
    this._weight,
    this._imgUrl,
  );

  String get itemName => _itemName;
  String get itemCategory => _itemCategory;
  String get itemBrand => _itemBrand;
  String get weightLabel => _weightLabel;
  String get state => _state;

  int get id => _id;

  double get itemPrice => _itemPrice;
  double get itemQuantity => _itemQuantity;
  double get weight => _weight;

  Uint8List get imgUrl => _imgUrl;

  set setState(String currentState) {
    _state = currentState;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }

    map['item_name'] = _itemName;
    map['item_category'] = _itemCategory;
    map['item_brand'] = _itemBrand;
    map['weight_label'] = _weightLabel;
    map['state'] = _state;
    map['item_price'] = _itemPrice;
    map['item_quantity'] = _itemQuantity;
    map['weight'] = _weight;
    map['img_url'] = _imgUrl;

    return map;
  }

  // Extract a Note object from a Map object
  CartTable.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._itemName = map['item_name'];
    this._itemCategory = map['item_category'];
    this._itemBrand = map['item_brand'];
    this._weightLabel = map['weight_label'];
    this._state = map['state'];
    this._itemPrice = map['item_price'];
    this._itemQuantity = map['item_quantity'];
    this._weight = map['weight'];
    this._imgUrl = map['img_url'];
  }
}
