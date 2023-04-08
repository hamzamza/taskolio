

class Category {
  String? id;
  String? title;
  String? desc;
  String? userId;
  String? imgurl;
  String? color;
  bool? isLast;

  Category({required this.id, required this.title,required this.desc,required this.userId,required this.imgurl,required this.color,this.isLast=false
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      title: json['title'],
      desc:json['desc'],
      userId:json['userId'],
      imgurl:json['imgurl'],
      color:json['color'],
      isLast: false,
    );
  }
}