
class shortArticlesModel{


  String? articleImage;
  String? articleFeed;
  String? articleViews;
  String? articleUrl;



  late String reportMissingImage;

  shortArticlesModel({
    required this.articleImage,
    this.articleFeed,

    this.articleViews,
    required this.articleUrl,

  });
  shortArticlesModel.FromJson(Map<String,dynamic>?json){
    articleImage=json?['articleImage'];
    articleFeed=json?['articleFeed'];
    articleViews=json?['articleViews'];
    articleUrl=json?['articleUrl'];




  }

  Map<String,dynamic>toMap(){
    return {
      'articleImage':articleImage,
      'articleFeed':articleFeed,
      'articleViews':articleViews,
      'articleUrl':articleUrl,




    };
  }




}

