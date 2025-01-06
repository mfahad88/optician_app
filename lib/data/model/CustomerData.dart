class CustomerData{
  int? id;
  String? fullName;
  String? contactNumber;
  String? address;
  DateTime? createdDate;
  DateTime? updatedDate;

  CustomerData(this.id, this.fullName, this.contactNumber, this.address,
      this.createdDate, this.updatedDate);

  @override
  String toString() {
    return 'CustomerData{id: $id, fullName: $fullName, contactNumber: $contactNumber, address: $address, createdDate: $createdDate, updatedDate: $updatedDate}';
  }
}