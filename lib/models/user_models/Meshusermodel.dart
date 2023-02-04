class Meshusermodel {
  int? status;
  String? message;
  List<Data>? data;

  Meshusermodel({this.status, this.message, this.data});

  Meshusermodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  dynamic catAttribute;

  Data({this.id, this.name, this.image, this.catAttribute});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    catAttribute=json['catAttribute'];
    // if (json['cat_attribute'] != null) {
    //   catAttribute = <Null>[];
    //   json['cat_attribute'].forEach((v) {
    //     catAttribute!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['catAttribute']= this.catAttribute;
    // if (this.catAttribute != null) {
    //   data['cat_attribute'] =
    //       this.catAttribute!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}