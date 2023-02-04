class placemodel {
  dynamic typeId;
  dynamic amount;
  dynamic serviceAt;
  dynamic description;
  List<OrderAttribute>? orderAttribute;
  List<String>? picture;

  placemodel(
      {this.typeId,
        this.amount,
        this.serviceAt,
        this.description,
        this.orderAttribute,
        this.picture});

  placemodel.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    amount = json['amount'];
    serviceAt = json['service_at'];
    description = json['description'];
    if (json['order_attribute'] != null) {
      orderAttribute = <OrderAttribute>[];
      json['order_attribute'].forEach((v) {
        orderAttribute!.add(new OrderAttribute.fromJson(v));
      });
    }
    picture = json['picture'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['amount'] = this.amount;
    data['service_at'] = this.serviceAt;
    data['description'] = this.description;
    if (this.orderAttribute != null) {
      data['order_attribute'] =
          this.orderAttribute!.map((v) => v.toJson()).toList();
    }
    data['picture'] = this.picture;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_id'] = this.attributeId;
    data['attribute_value'] = this.attributeValue;
    return data;
  }
}
