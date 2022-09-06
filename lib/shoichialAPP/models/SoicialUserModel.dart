class SocialUserModel{
  String? email;
  String? phone;
  String? name;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  String? password;


  SocialUserModel({ this.email,
    this.phone,
    this.name, this.uId,
    this.image,this.bio,
    this.cover,this.password});
  SocialUserModel.fromJson(Map<String, dynamic> json) {
      email= json["email"];
      password=json["password"];
      phone =json["phone"];
      name= json["name"];
      uId= json["uId"];

      image=json["image"];
      cover=json["cover"];
      bio=json["bio"];
  }

  Map<String, dynamic> toMap() {
    return {
      "password":password,
      "email":email,
      "phone":phone,
      "name": name,
      "uId": uId,
      "image":image,
      "cover":cover,
      'bio':bio,
    };
  }

//

}