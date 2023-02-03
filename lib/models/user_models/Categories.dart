class Categoriesmodel
{
  dynamic id;
  dynamic message;
  dynamic data;

  Categoriesmodel({this.id,this.message,this.data});

  Categoriesmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

}

class Data {
  dynamic id;
  dynamic name;
  dynamic image;
  dynamic cat_attribute;

  Data({this.id, this.name,this.image,this.cat_attribute});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    cat_attribute = json['cat_attribute'] != null ? Cat_attribute.fromJson(json['cat_attribute']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
      data['name']=name;
    data['image']=image  ;
    if (cat_attribute != null) {
      data['car_attribute'] = this.cat_attribute.toJson();
    }
    return data;
  }
}

class Cat_attribute {
  dynamic id;
  dynamic attribute_id;
  dynamic category_id;
  dynamic attribute;

  Cat_attribute({this.id, this.attribute_id,this.category_id,this.attribute});

  Cat_attribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attribute_id = json['attribute_id'];
    category_id = json['category_id'];
    attribute = json['attribute'] != null ? Attribute.fromJson(json['attribute']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['attribute_id']=attribute_id;
    data['category_id']=category_id  ;
    if (attribute != null) {
      data['attribute'] = attribute!.toJson();
    }
    return data;
  }
}



class Attribute {
  dynamic id;
  dynamic name;
  dynamic type;
  dynamic attribute_value;

  Attribute({this.id, this.name,this.type,this.attribute_value});

  Attribute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    attribute_value = json['attribute_value'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name']=name;
    data['type']=type  ;
    if (attribute_value != null) {
      data['attribute_value'] = attribute_value!.toJson();
    }
    return data;
  }
}

class Attribute_value {
  dynamic id;
  dynamic name;
  dynamic attribute_id;
  dynamic order;

  Attribute_value({this.id, this.name,this.attribute_id,this.order});

  Attribute_value.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    attribute_id = json['attribute_id'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name']=name;
    data['attribute_id']=attribute_id  ;
    data['attribute_id'] = attribute_id;
    return data;
  }
}


