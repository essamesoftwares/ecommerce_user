class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const PRICE = "price";
  static const QUANTITY = "quantity";
  static const QTY_PRICE = "qty price";
  // static const SIZE = "size";
  // static const COLOR = "color";

  String _id;
  String _name;
  String _image;
  String _productId;
  // String _size;
  // String _color;
  int _price;
  int _quantity;
  int _qtyPrice;

  //  getters
  String get id => _id;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;

  // String get size => _size;
  //
  // String get color => _color;

  int get price => _price;

  int get quantity => _quantity;

  int get qtyPrice => _qtyPrice;

  CartItemModel.fromMap(Map data) {
    _id = data[ID];
    _name = data[NAME];
    _image = data[IMAGE];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _qtyPrice = data[QTY_PRICE];
    // _size = data[SIZE];
    // _color = data[COLOR];
  }

  Map toMap() => {
        ID: _id,
        IMAGE: _image,
        NAME: _name,
        PRODUCT_ID: _productId,
        PRICE: _price,
        QUANTITY: _quantity,
        QTY_PRICE: _qtyPrice
        // SIZE: _size,
        // COLOR: _color
      };
}
