class Cleaner {
  Cleaner(
      {required this.cleanerId,
      required this.cleanerName,
      required this.serviceName,
      required this.cleanerAddress,
      required this.cleanerMobile,
      this.feedback,
      this.status,
      this.cBookingId});
  String cleanerId;
  String cleanerName;
  String serviceName;
  String cleanerAddress;
  String cleanerMobile;
  String? cBookingId;
  double? feedback;
  bool? status;

  static Cleaner fromJson(Map<String, dynamic> json) => Cleaner(
      cleanerId: json["id"],
      cleanerName: json["name"],
      serviceName: json["service-name"],
      cleanerAddress: json["address"],
      cleanerMobile: json["mobile"],
      feedback: json["feedback"],
      status: json["status"],
      cBookingId: json["current-booking-id"]);

  Map<String, dynamic> toJson() => {
        "id": cleanerId,
        "name": cleanerName,
        "service-name": serviceName,
        "address": cleanerAddress,
        "mobile": cleanerMobile,
        "status": true,
        "current-booking-id": null,
        "feedback": 1
      };
}
