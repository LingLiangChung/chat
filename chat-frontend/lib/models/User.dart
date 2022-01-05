class User {
  int? id;
  String? name;
  int? contactNumber;
  int? nric;
  String? email;
  String? position;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.name,
        this.contactNumber,
        this.nric,
        this.email,
        this.position,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contactNumber = json['contact_number'];
    nric = json['nric'];
    email = json['email'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact_number'] = this.contactNumber;
    data['nric'] = this.nric;
    data['email'] = this.email;
    data['position'] = this.position;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}