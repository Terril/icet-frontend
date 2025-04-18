import 'package:icet/datamodel/rows.dart';
import 'columns.dart';

class Boards {
  String? id;
  List<Columns>? columns;
  List<Rows>? rows;
  String? name;
  String? createdAt;
  String? updatedAt;

  Boards(
      {this.id,
      this.columns,
      this.rows,
      this.name,
      this.createdAt,
      this.updatedAt});

  Boards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['columns'] != null && json["columns"].isNotEmpty) {
      columns = <Columns>[];
      json['columns'].forEach((v) {
        columns!.add(Columns.fromJson(v));
      });
    }
    if (json['rows'] != null && json["rows"].isNotEmpty) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(Rows.fromJson(v));
      });
    }
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (columns != null) {
      data['columns'] = columns!.map((v) => v.toJson()).toList();
    }
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class BoardList {
  final List<Boards> list;

  BoardList({
    required this.list,
  });

  factory BoardList.fromJsonToList(List<dynamic> parsedJson) {
    List<Boards> list = <Boards>[];
    list = parsedJson.map((i) => Boards.fromJson(i)).toList();

    return BoardList(list: list);
  }
}
