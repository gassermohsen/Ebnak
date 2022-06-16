
class articlesModel{


  String? articleImage;
  String? articleFeed;
  String? articleDate;
  String? articleUrl;
  String? sourceName;



  late String reportMissingImage;

  articlesModel({
    required this.articleImage,
    this.articleFeed,

    this.articleDate,
    required this.articleUrl,
    this.sourceName,

  });
  articlesModel.FromJson(Map<String,dynamic>?json){
    articleImage=json?['articleImage'];
    articleFeed=json?['articleFeed'];
    articleDate=json?['articleDate'];
    articleUrl=json?['articleUrl'];
    sourceName=json?['sourceName'];




  }

  Map<String,dynamic>toMap(){
    return {
      'articleImage':articleImage,
      'articleFeed':articleFeed,
      'articleDate':articleDate,
      'articleUrl':articleUrl,
      'sourceName':sourceName,




    };
  }




}

