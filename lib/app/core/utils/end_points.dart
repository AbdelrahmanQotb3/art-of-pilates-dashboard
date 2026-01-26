class EndPoints {
  static const String baseUrl = "http://localhost:3000/";

  static const String signin = "auth/signin";
  static const String signup = "auth/signup";

  static const String getContacts = "contacts/getContacts";
  static const String getContact = "contacts/getContact";
  static const String deleteContact = "contacts/deleteContact";
  static const String updateContact = "contacts/updateContact/{id}";
  static const String createContact = "contacts/createContact";

  static const String getPricingPlans = "pricing-plans/getPlans";
  static const String getPlan = "pricing-plans/getPlanById";
  static const String addPlan = "pricing-plans/addPlan";
  static const String deletePlan = "pricing-plans/deletePlanById";
  static const String updatePlan = "pricing-plans/updatePlan/{id}";
}
