import 'contents.dart';

class Rows {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? mdContent;
  Content? content;
  String? board;
  int? interestLevel;

  Rows(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.mdContent,
      this.content,
      this.interestLevel,
      this.board});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    interestLevel = json['interest_level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mdContent = json['md_content'];

    content = json['content'] != null ? Content.fromJson(json['content']) : null;
    board = json['board'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['md_content'] = this.mdContent;
    data['content'] = this.content;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['interest_level'] = this.interestLevel;
    data['board'] = this.board;
    return data;
  }
}

class Data {
  //Data({});

  Data.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
