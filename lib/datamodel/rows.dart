import 'package:get/get.dart';
import 'package:icet/logs.dart';

import 'cell.dart';

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
    final Map<String, dynamic> data = Map<String, dynamic>();
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

class Content {
  List<dynamic>? data;
  List<QuillRows>? coData;

  Content({this.data});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = json['data'];
      coData = <QuillRows>[];
      json['data'].forEach((v) {
        coData!.add(QuillRows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuillRows {
  String? insert;
  Attributes? attributes;

  QuillRows({this.attributes, this.insert});

  QuillRows.fromJson(Map<String, dynamic> json) {
    insert = json['insert'];
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['insert'] = this.insert;
    data['attributes'] = this.attributes;
    return data;
  }
}

class Attributes {
  bool? bold;
  bool? italic;
  bool? underline;
  int? header;
  String? list;
  String? link;

  Attributes({
    this.bold,
    this.italic,
    this.underline,
    this.header,
    this.list,
    this.link,
  });

  Attributes.fromJson(Map<String, dynamic> json) {
    bold = json['bold'];
    italic = json['italic'];
    underline = json['underline'];
    header = json['header'];
    list = json['list'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bold'] = this.bold;
    data['italic'] = this.italic;
    data['underline'] = this.underline;
    data['header'] = this.header;
    data['list'] = this.list;
    data['link'] = this.link;
    return data;
  }
}
