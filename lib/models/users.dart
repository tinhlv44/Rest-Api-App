class Users {
  final Name? name;
  final Location? location;
  final String? email;
  final Dob? dob;
  final String? phone;
  final String? cell;
  final String? nat;
  final String? gender;
  final PictureCls? picture;

  Users(
      {this.name,
      this.gender,
      this.location,
      this.email,
      this.dob,
      this.phone,
      this.cell,
      this.nat,
      this.picture});
  factory Users.formJson(Map<String, dynamic> json) {
    final name = Name.formJson(json['name']);
    final dob = Dob.formJson(json['dob']);
    final location = Location.formJson(json['location']);
    final picture = PictureCls.formJson(json['picture']);
    return Users(
      name: name,
      cell: json['cell'],
      phone: json['phone'],
      email: json['email'],
      nat: json['nat'],
      gender: json['gender'],
      location: location,
      dob: dob,
      picture: picture,
    );
  }
}

class PictureCls {
  final String? large;
  final String? medium;
  final String? thumbnail;

  PictureCls({this.large, this.medium, this.thumbnail});
  factory PictureCls.formJson(Map<String, dynamic> json) {
    return PictureCls(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}

class Dob {
  final String? date;
  final String? age;

  Dob({this.date, this.age});
  factory Dob.formJson(Map<String, dynamic> json) {
    return Dob(
      age: json['age'].toString(),
      date: json['date'],
    );
  }
}

class Location {
  final String? country;
  final String? city;

  Location({this.country, this.city});
  factory Location.formJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'],
      country: json['country'],
    );
  }
}

class Name {
  final String? title;
  final String? first;
  final String? last;

  Name({this.title, this.first, this.last});
  factory Name.formJson(Map<String, dynamic> json) {
    return Name(
      first: json['first'],
      last: json['last'],
      title: json['title'],
    );
  }
  @override
  String toString() {
    return "$title. $first $last";
  }
}
