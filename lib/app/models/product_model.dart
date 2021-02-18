class Product {

  final String id;
  final String name;
  final String picture;
  final bool active;
  final int sku;
  final int price;
  final int quantity;

  Product({
    this.id = '',
    this.name = '',
    this.picture = '',
    this.active = false,
    this.sku = 0,
    this.price = 0,
    this.quantity = 0,
  });

  Product copyWith({
    String id,
    String name,
    String picture,
    bool active,
    int sku,
    int price,
    int quantity,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    picture: picture ?? this.picture,
    active: active ?? this.active,
    sku: sku ?? this.sku,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
  );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id:       (json['id']           == null) ? ''     : json['id'],
    name:     (json['name']         == null) ? ''     : json['name'],
    picture:  (json['picture']      == null) ? ''     : json['picture'],
    active:   (json['active']       == null) ? false  : json['active'],
    sku:      (json['sku']          == null) ? 0      : json['sku'],
    price:    (json['price']        == null) ? 0      : json['price'],
    quantity: (json['quantity']     == null) ? 0   : json['quantity'],
  );

}