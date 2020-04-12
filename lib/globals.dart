library trial12.globals;

var currentLocation;
var tempPhone ;
var vendPhone;
var shopPhone;
var selectedShopPhone;
var imageSource;
var phoneNumber;
var shopperName;
var shopperAddress;

var selectedOrder;
var chosenImageUrl;
var indexchosen;

var numberOfOrderSelected = 0;

final List<Product> myCart = new List();
var vendorslist = [];
var base64ImageUrl;
final List<Product> allProductsList = new List();
class Product {
  String name;
  String image;
  int price;
  int value;
  bool available;
  bool cart ;
  bool favorite;

  Product(name, price, image, cart, favorite, value, available) {
    this.name = name;
    this.price = price;
    this.image = image;
    this.cart = cart;
    this.favorite = favorite;
    this.value = value;
    this.available = available;
  }

  Product.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      image = json['image'],
      price = json['price'],
      available = json['available'],
      cart = json['cart'],
      favorite = json['favorite'],
      value = json['value'];

  
  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
    'available': available,
    'cart': cart,
    'favorite': favorite,
    'value': value,
    'price': price
  };
}
class Shop {
  String name;
  String image;
  String address;
  String phone;
  

  Shop(name,  image, address,phone) {
    this.name = name;
    this.address = address;
    this.image = image;
    this.phone = phone;

    
    
  }

  Shop.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        image = json['image'],
        phone = json['phone'],
        address = json['address'];



  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'address':address,
        'phone':phone
      };
}