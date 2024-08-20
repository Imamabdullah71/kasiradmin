class Infaq {
  final int id;
  final int userId;
  final double jumlahInfaq;
  final DateTime tanggalInfaq;

  Infaq({
    required this.id,
    required this.userId,
    required this.jumlahInfaq,
    required this.tanggalInfaq,
  });

  factory Infaq.fromJson(Map<String, dynamic> json) {
    return Infaq(
      id: int.parse(json['id']),
      userId: int.parse(json['user_id']),
      jumlahInfaq: double.parse(json['jumlah_infaq']),
      tanggalInfaq: DateTime.parse(json['tanggal_infaq']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'user_id': userId.toString(),
      'jumlah_infaq': jumlahInfaq.toString(),
      'tanggal_infaq': tanggalInfaq.toIso8601String(),
    };
  }
}
