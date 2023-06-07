class Client {
  int? id;
  String? profileImage;
  String gender;
  String dateOfBirth;
  String phoneNumber;
  String workStatus;
  String familyStatus;
  bool hasChildren;

  Client({
    this.id,
    this.profileImage = '',
    this.gender = 'male',
    this.dateOfBirth = '',
    this.phoneNumber = '+',
    this.workStatus = '',
    this.familyStatus = '',
    this.hasChildren = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'profile_image': profileImage,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'phone_number': phoneNumber,
      'work_status': workStatus,
      'family_status': familyStatus,
      'has_children': hasChildren.toString(),
    };
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      profileImage: json['profile_image'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      phoneNumber: json.containsKey('phone_number') ? json['phone_number'] : '',
      workStatus: json['work_status_name'],
      familyStatus: json['family_status_name'],
      hasChildren: json['has_children'] == 'true',
    );
  }
}
