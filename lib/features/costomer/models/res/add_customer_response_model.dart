class AddCustomerResponseModel {
  final bool success;
  final CustomerData customerData;

  AddCustomerResponseModel({required this.success, required this.customerData});

  factory AddCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    return AddCustomerResponseModel(
      success: json['success'],
      customerData: CustomerData.fromJson(json['data']),
    );
  }
}

class CustomerData {
  final String name;
  final String phone;
  final String address;
  final int points;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  CustomerData({
    required this.name,
    required this.phone,
    required this.address,
    required this.points,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      points: json['points'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
