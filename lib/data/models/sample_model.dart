import '../../domain/entities/sample_entity.dart';

class SampleModel extends SampleEntity {
  SampleModel({
    required int id,
    required String title,
    required String imageUrl,
  }) : super(id: id, title: title, imageUrl: imageUrl);

  factory SampleModel.fromJson(Map<String, dynamic> json) {
    return SampleModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'imageUrl': imageUrl};
  }

  factory SampleModel.fromMap(Map<String, dynamic> map) {
    return SampleModel(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'imageUrl': imageUrl};
  }
}
