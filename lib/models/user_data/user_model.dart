class UserModel {
  final int id;
  final String email;
  final String username;
  final String password;
  final String phone;
  final String firstName;
  final String lastName;
  final Address address;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      phone: json['phone'],
      firstName: json['name']['firstname'],
      lastName: json['name']['lastname'],
      address: Address.fromJson(json['address']),
    );
  }
}

class Address {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final GeoLocation geolocation;

  Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
      geolocation: GeoLocation.fromJson(json['geolocation']),
    );
  }
}

class GeoLocation {
  final String lat;
  final String long;

  GeoLocation({
    required this.lat,
    required this.long,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      lat: json['lat'],
      long: json['long'],
    );
  }
}
