class SupplierData{
  int?	id;
  String? name;
  String? contact_number;
  String? email;
  String? address;
  String? services_provided;
  DateTime? created_at;
  DateTime? updated_at;

  SupplierData(
      {this.id,
      this.name,
      this.contact_number,
      this.email,
      this.address,
      this.services_provided,
      this.created_at,
      this.updated_at});

  @override
  String toString() {
    return 'SupplierData{name: $name, contact_number: $contact_number, email: $email, address: $address, services_provided: $services_provided}';
  }
}