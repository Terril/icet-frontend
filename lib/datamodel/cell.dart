import 'package:get/get_utils/get_utils.dart';

import 'contents.dart';

class Cells {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? data;
  Content? content;
  String? row;
  String? column;

  Cells(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.data,
        this.content,
        this.row,
        this.column});

  Cells.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['data'] is String)
    {
      data = json['data'];
    }
    content = json['content'] != null ? Content.fromJson(json['content']) : null;
    row = json['row'];
    column = json['column'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['data'] = this.data;
    data['row'] = this.row;
    data['column'] = this.column;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}
