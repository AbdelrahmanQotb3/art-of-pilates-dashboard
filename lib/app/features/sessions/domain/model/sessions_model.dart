class SessionsModel {
  String? message;
  List<SessionEntity>? sessions;

  SessionsModel({this.message, this.sessions});

  SessionsModel copyWith({String? message, List<SessionEntity>? sessions}) {
    return SessionsModel(
      message: message ?? this.message,
      sessions: sessions ?? this.sessions,
    );
  }
}

class SessionEntity {
  final String? id;
  final String? startTime;
  final String? endTime;
  final String? serviceId;
  final String? staffMemberId;
  final String? serviceName; // lightweight ref to avoid circular imports
  final String? staffName; // lightweight ref

  SessionEntity({
    this.id,
    this.startTime,
    this.endTime,
    this.serviceId,
    this.staffMemberId,
    this.serviceName,
    this.staffName,
  });

  SessionEntity copyWith({
    String? id,
    String? startTime,
    String? endTime,
    String? serviceId,
    String? staffMemberId,
    String? serviceName,
    String? staffName,
  }) {
    return SessionEntity(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      serviceId: serviceId ?? this.serviceId,
      staffMemberId: staffMemberId ?? this.staffMemberId,
      serviceName: serviceName ?? this.serviceName,
      staffName: staffName ?? this.staffName,
    );
  }
}
