class Columns {
  String? id;
  String? name;
  String? dataType;
  String? createdAt;
  String? updatedAt;
  String? board;

  Columns(
      {this.id,
        this.name,
        this.dataType,
        this.createdAt,
        this.updatedAt,
        this.board});

  Columns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dataType = json['data_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    board = json['board'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['data_type'] = this.dataType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['board'] = this.board;
    return data;
  }
}