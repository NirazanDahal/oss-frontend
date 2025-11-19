class AddCustomerRequestModel {
  final String name;
  final String phone;
  final String address;

  AddCustomerRequestModel({
    required this.name,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'phone': phone, 'address': address};
  }
}
