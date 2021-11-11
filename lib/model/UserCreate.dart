class UserCreate
{
    String? name;
    String? email;
    String? phone;
    String? uId;
    String? image;
    String? cover;
    String? bio;
   UserCreate(
   {
      this.name,
      this.email,
      this.phone,
      this.uId,
      this.image,
      this.cover,
      this.bio,
});
   UserCreate.fromJson(Map<String,dynamic>json)
   {
     email =json['email'];
     name =json['name'];
     phone =json['phone'];
     uId =json['uId'];
     bio=json['bio'];
     image= json['image'];
     cover=json['cover'];
   }
   Map<String,dynamic> toMap()
   {
     return {
       'name':name,
       'email':email,
       'phone':phone,
       'cover':cover,
       'image':image,
       'bio':bio,
       'uId':uId,
     };
   }

}