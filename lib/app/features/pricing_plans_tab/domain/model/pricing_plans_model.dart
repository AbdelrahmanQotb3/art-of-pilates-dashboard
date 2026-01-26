class PricingPlansModel {
  final List<PricingPlansEntity> pricingPlans;
  PricingPlansModel({required this.pricingPlans});
  PricingPlansModel copyWith({List<PricingPlansEntity>? pricingPlans}) {
    return PricingPlansModel(pricingPlans: pricingPlans ?? this.pricingPlans);
  }
}

class PricingPlansEntity {
  int? id;
  String? planName;
  double? pricing;
  String? duration;
  String? status;
  String? imageUrl;

  PricingPlansEntity({
    this.id,
    this.planName,
    this.pricing,
    this.duration,
    this.status,
    this.imageUrl,
  });

  PricingPlansEntity copyWith({
    int? id,
    String? planName,
    double? pricing,
    String? duration,
    String? status,
    String? imageUrl,
  }) {
    return PricingPlansEntity(
      id: id ?? this.id,
      planName: planName ?? this.planName,
      pricing: pricing ?? this.pricing,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
