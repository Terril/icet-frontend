class Cells {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? data;
  String? contentStr;
  String? row;
  String? column;

  Cells(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.data,
        this.contentStr,
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
    contentStr = json['content_str'];
    row = json['row'];
    column = json['column'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['data'] = this.data;
    data['content_str'] = this.contentStr;
    data['row'] = this.row;
    data['column'] = this.column;
    return data;
  }
}
