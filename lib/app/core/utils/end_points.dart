class EndPoints {
  static const String baseUrl = "http://localhost:3000/";

  static const String signin = "auth/signin";
  static const String signup = "auth/signup";
  static const String signout = "auth/logout";

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

  static const String getStaffMembers = "staff/getStaffMembers";
  static const String getStaffMember = "staff/getStaffById";
  static const String addStaffMember = "staff/addStaffMember";
  static const String deleteStaffMember = "staff/deleteStaffMember";
  static const String updateStaffMember = "staff/updateStaffMember";

  static const String getServices = "services/getServices";
  static const String getOneService = "services/getOneService";
  static const String addService = "services/addService";
  static const String deleteService = "services/deleteService";
  static const String updateService = "services/updateService";

  static const String getClasses = "classes/getClasses";
  static const String addClass = "classes/addClass";
  static const String getOneClass = "classes/getClass";
  static const String deleteClass = "classes/deleteClass";
  static const String updateClass = "classes/updateClass";

  static const String currentUser = "user/currentUser";
  static const String editProfile = "user/editUser";
}
