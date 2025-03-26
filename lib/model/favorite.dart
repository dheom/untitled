class FavoriteModel {
  int? id;
  int foodStoreId;
  String favoriteUid;
  DateTime? createdAt;

  FavoriteModel({
    this.id,
    required this.foodStoreId,
    required this.favoriteUid,
    this.createdAt,
  });


  Map<String, dynamic> toMap() {
    return {
      'food_store_id': foodStoreId,
      'favorite_uid': favoriteUid,
    };
  }

  factory FavoriteModel.fromJson(Map<dynamic, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      foodStoreId: json['food_store_id'],
      favoriteUid: json['favorite_uid'],
      createdAt: DateTime.parse(json['created_at']),);
  }
}