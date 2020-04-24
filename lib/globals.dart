library trial12.globals;

//google maps 
var currentLocation;
//number in the text field at phone.dart
var tempPhone ;
//after signing up
var vendPhone;
var shopPhone;
// For the selected shop in available 
var selectedShopPhone;

// Phone Auth
var phoneNumber;


var imageSource;

// for the Credentials selected shop
var shopperName;
var shopperAddress;

var selectedOrder;
// selecting form gallery and camera camera.dart
var chosenImageUrl;
var indexchosen;

// order
int finalPrice ;
// for cart

final List<Map> myCartPricesList = new List();
final List<Map> myCartValuesList = new List();
// 
var numberOfOrderSelected = 0;
var numbOfOrderSelectedShopper = 0;
final List<Map> myCart = new List();
final List<Map> allProductsList = new List();

// adding all vendors in this list available but not using it 
var vendorslist = [];
var idOrderslist = [];
var statusOrdersList = [];


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