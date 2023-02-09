class placemodel {
  dynamic category_id;
  dynamic amount;
  dynamic serviceAt;
  dynamic description;
  List<OrderAttribute>? orderAttribute;
  List<String>? picture;

  placemodel(
<<<<<<< HEAD
      {this.category_id,
=======
      {this.typeId,
>>>>>>> a1321cf006979a111a3fc902270a404bad567b8d
      this.amount,
      this.serviceAt,
      this.description,
      this.orderAttribute,
      this.picture});

  placemodel.fromJson(Map<String, dynamic> json) {
    category_id = json['category_id'];
    amount = json['amount'];
    serviceAt = json['service_at'];
    description = json['description'];
    if (json['order_attribute'] != null) {
      orderAttribute = <OrderAttribute>[];
      json['order_attribute'].forEach((v) {
        orderAttribute!.add(OrderAttribute.fromJson(v));
      });
    }
    picture = json['picture'].cast<String>();
  }

  Map<String, dynamic> toJson() {
<<<<<<< HEAD
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.category_id;
    data['amount'] = this.amount;
    data['service_at'] = this.serviceAt;
    data['description'] = this.description;
    if (this.orderAttribute != null) {
      data['order_attribute'] =
          this.orderAttribute!.map((v) => v.toJson()).toList();
=======
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type_id'] = typeId;
    data['amount'] = amount;
    data['service_at'] = serviceAt;
    data['description'] = description;
    if (orderAttribute != null) {
      data['order_attribute'] = orderAttribute!.map((v) => v.toJson()).toList();
>>>>>>> a1321cf006979a111a3fc902270a404bad567b8d
    }
    data['picture'] = picture;
    return data;
  }
}

class OrderAttribute {
  dynamic attributeId;
  dynamic attributeValue;

  OrderAttribute({this.attributeId, this.attributeValue});

  OrderAttribute.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    attributeValue = json['attribute_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute_id'] = attributeId;
    data['attribute_value'] = attributeValue;
    return data;
  }
}
