class Rows {
  String? id;
  List<Cells>? cells;
  List<NonGlobalCells>? nonGlobalCells;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? mdContent;
  String? board;
  int? interestLevel;

  Rows({this.id,
    this.cells,
    this.nonGlobalCells,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.mdContent,
    this.interestLevel,
    this.board});

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    name = json['name'];
    interestLevel = json['interest_level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mdContent = json['md_content'];
    board = json['board'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.cells != null) {
      data['cells'] = this.cells!.map((v) => v.toJson()).toList();
    }
    if (this.nonGlobalCells != null) {
      data['non_global_cells'] =
          this.nonGlobalCells!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['md_content'] = this.mdContent;
    data['interest_level'] = this.interestLevel;
    data['board'] = this.board;
    return data;
  }
}

class Cells {
  String? id;
  String? createdAt;
  String? updatedAt;
  Data? data;
  String? mdContent;
  String? row;
  String? column;

  Cells({this.id,
    this.createdAt,
    this.updatedAt,
    this.data,
    this.mdContent,
    this.row,
    this.column});

  Cells.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    mdContent = json['md_content'];
    row = json['row'];
    column = json['column'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['md_content'] = this.mdContent;
    data['row'] = this.row;
    data['column'] = this.column;
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

class NonGlobalCells {

  NonGlobalCells.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
