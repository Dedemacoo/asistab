class UserModel {
  final String id;
  final String name;
  final String email;
  final String profilePhotoUrl;
  final bool isBiometricEnabled;
  final bool isDarkMode;
  final int totalRiskScore; // AI tarafından hesaplanan güncel genel stres/risk puanı

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profilePhotoUrl = '',
    this.isBiometricEnabled = false,
    this.isDarkMode = false,
    this.totalRiskScore = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePhotoUrl': profilePhotoUrl,
      'isBiometricEnabled': isBiometricEnabled,
      'isDarkMode': isDarkMode,
      'totalRiskScore': totalRiskScore,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profilePhotoUrl: map['profilePhotoUrl'] ?? '',
      isBiometricEnabled: map['isBiometricEnabled'] ?? false,
      isDarkMode: map['isDarkMode'] ?? false,
      totalRiskScore: map['totalRiskScore']?.toInt() ?? 0,
    );
  }
}
