import 'cell.dart';
import 'contents.dart';
import 'non_cell.dart';

class Columns {
  String? id;
  String? name;
  String? dataType;
  String? createdAt;
  String? updatedAt;
  String? board;
  // Content? content;
  String? description;
  List<Cells>? cells;
  List<NonGlobalCells>? nonGlobalCells;

  Columns(
      {this.id,
        this.name,
        this.cells,
        this.nonGlobalCells,
        this.dataType,
        this.createdAt,
        this.updatedAt,
        this.description,
        // this.content,
        this.board});

  Columns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dataType = json['data_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
   // content = json['description_data'] != null ? Content.fromJson(json['description_data']) : null;
    board = json['board'];
    if (json['cells'] != null) {
      cells = <Cells>[];
      json['cells'].forEach((v) {
        cells!.add(Cells.fromJson(v));
      });
    }
    if (json['non_global_cells'] != null) {
      nonGlobalCells = <NonGlobalCells>[];
      json['non_global_cells'].forEach((v) {
        nonGlobalCells!.add(NonGlobalCells.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['data_type'] = this.dataType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // if (this.content != null) {
    //   data['description_data'] = this.content!.toJson();
    // }
    data['description'] = this.description;
    data['board'] = this.board;
    if (this.cells != null) {
      data['cells'] = this.cells!.map((v) => v.toJson()).toList();
    }
    if (this.nonGlobalCells != null) {
      data['non_global_cells'] =
          this.nonGlobalCells!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ColumnList {
  final List<Columns> list;

  ColumnList({
    required this.list,
  });

  factory ColumnList.fromJsonToList(List<dynamic> parsedJson) {
    List<Columns> list = <Columns>[];
    list = parsedJson.map((i) => Columns.fromJson(i)).toList();

    return ColumnList(list: list);
  }
}