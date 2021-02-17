class OrderItemsTable {
  String _itemName, _itemCategory, _itemBrand, _weightLabel, _orderId;
  int _id;
  double _itemPrice, _itemQuantity, _weight;
  String _imgUrl;

  OrderItemsTable(
    this._itemName,
    this._itemCategory,
    this._itemBrand,
    this._weightLabel,
    this._orderId,
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
  String get orderId => _orderId;

  int get id => _id;

  double get itemPrice => _itemPrice;
  double get itemQuantity => _itemQuantity;
  double get weight => _weight;

  String get imgUrl => _imgUrl;

  /*set setState(String currentState) {
    _state = currentState;
  }*/

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['item_name'] = _itemName;
    map['item_category'] = _itemCategory;
    map['item_brand'] = _itemBrand;
    map['weight_label'] = _weightLabel;
    map['order_id'] = _orderId;
    map['item_price'] = _itemPrice;
    map['item_quantity'] = _itemQuantity;
    map['weight'] = _weight;
    map['img_url'] = _imgUrl;

    return map;
  }

  // Extract a Note object from a Map object
  OrderItemsTable.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._itemName = map['item_name'];
    this._itemCategory = map['item_category'];
    this._itemBrand = map['item_brand'];
    this._weightLabel = map['weight_label'];
    this._orderId = map['order_id'];
    this._itemPrice = map['item_price'];
    this._itemQuantity = map['item_quantity'];
    this._weight = map['weight'];
    this._imgUrl = map['img_url'];
  }
}
