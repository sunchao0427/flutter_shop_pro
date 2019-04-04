class CategoryBigModel{
  String mallCategoryId;//类别编号
  String mallCategoryName;
  List<dynamic> bxMallSubDto; //子类别
  Null comments;
  String image; //图片地址

  CategoryBigModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.bxMallSubDto,
    this.comments,
    this.image
  });


  factory CategoryBigModel.fromJson(dynamic json){  //工厂模式 

    return CategoryBigModel(
     mallCategoryId: json['mallCategoryId'],
     mallCategoryName: json['mallCategoryName'],
     bxMallSubDto: json['bxMallSubDto'],
     comments: json['comments'],
     image: json['image']
    );

  }

}

class CategoryBigListModel{
  List<CategoryBigModel> data;
  CategoryBigListModel(this.data);

  factory CategoryBigListModel.fromJson(List json){
    return CategoryBigListModel(
      json.map((i)=>CategoryBigModel.fromJson((i))).toList()
      );
  }
}

