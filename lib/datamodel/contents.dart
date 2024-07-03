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
