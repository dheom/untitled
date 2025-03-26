//맛집정보 모델 클래스
class FoodStoreModel{
  int? id;
  String storeName;//맛집이름
  String storeAddress;//맛집주소
  String storeComment;//맛집 상세내용
  String? storeImgUrl;//맛집 이미지
  String uid;//수파베이스 회원고유값
  double latitude;//위도
  double longitude;//경도
  DateTime? createdAt;

  FoodStoreModel({
    this.id,
    required this.storeName,
    required this.storeAddress,
    required this.storeComment,
    this.storeImgUrl,
    required this.uid,
    required this.latitude,
    required this.longitude,
    this.createdAt,
}); // 객체를 Map<String, dynamic>으로 변환
  Map<String, dynamic> toMap() {
    return {
      'store_name': storeName,
      'store_address': storeAddress,
      'store_comment': storeComment,
      'store_img_url': storeImgUrl,
      'uid': uid,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // JSON에서 객체로 변환하는 factory 생성자
  factory FoodStoreModel.fromJson(Map<dynamic, dynamic> json) {
    return FoodStoreModel(
      id: json['id'] as int?,
      storeName: json['store_name'] as String,
      storeAddress: json['store_address'] as String,
      storeComment: json['store_comment'] as String,
      storeImgUrl: json['store_img_url'] as String?,
      uid: json['uid'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}