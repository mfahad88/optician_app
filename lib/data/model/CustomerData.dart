class CustomerData{
  int? id;
  String? fullName;
  String? contactNumber;
  String? address;
  String? email;
  DateTime? createdDate;
  DateTime? updatedDate;

  CustomerData(this.id, this.fullName, this.contactNumber, this.address,this.email,
      this.createdDate, this.updatedDate);

  @override
  String toString() {
    return 'CustomerData{id: $id, fullName: $fullName, contactNumber: $contactNumber, address: $address, email: $email, createdDate: $createdDate, updatedDate: $updatedDate}';
  }
}