class AdminModel {
  int? status;
  String? message;
  Data? data;

  AdminModel({
    this.status,
    this.message,
    this.data,
  });

  AdminModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  Vendor? vendor;

  Data({
    this.token,
    this.vendor,
  });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    vendor = json['Vendor'] != null ? Vendor.fromJson(json['Vendor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (vendor != null) {
      data['Vendor'] = vendor!.toJson();
    }
    return data;
  }
}

class Vendor {
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? email;
  String? userName;
  String? referralCode;
  String? userType;
  Null image;
  VendorDetails? vendorDetails;

  Vendor({
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.email,
    this.userName,
    this.referralCode,
    this.userType,
    this.image,
    this.vendorDetails,
  });

  Vendor.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
    userName = json['user_name'];
    referralCode = json['referral_code'];
    userType = json['user_type'];
    image = json['image'];
    vendorDetails = json['vendor_details'] != null
        ? VendorDetails.fromJson(json['vendor_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['address'] = address;
    data['email'] = email;
    data['user_name'] = userName;
    data['referral_code'] = referralCode;
    data['user_type'] = userType;
    data['image'] = image;
    if (vendorDetails != null) {
      data['vendor_details'] = vendorDetails!.toJson();
    }
    return data;
  }
}

class VendorDetails {
  String? userId;
  String? cnic;
  String? experience;
  Null experienceCertImg;
  Null cnicFrontImg;
  String? cnicBackImg;
  String? gender;

  VendorDetails({
    this.userId,
    this.cnic,
    this.experience,
    this.experienceCertImg,
    this.cnicFrontImg,
    this.cnicBackImg,
    this.gender,
  });

  VendorDetails.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    cnic = json['cnic'];
    experience = json['experience'];
    experienceCertImg = json['experience_cert_img'];
    cnicFrontImg = json['cnic_front_img'];
    cnicBackImg = json['cnic_back_img'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['cnic'] = cnic;
    data['experience'] = experience;
    data['experience_cert_img'] = experienceCertImg;
    data['cnic_front_img'] = cnicFrontImg;
    data['cnic_back_img'] = cnicBackImg;
    data['gender'] = gender;
    return data;
  }
}
