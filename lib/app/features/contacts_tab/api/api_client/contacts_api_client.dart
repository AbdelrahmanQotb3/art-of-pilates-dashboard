import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/core/utils/end_points.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/contacts_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/create_contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/delete_contact_response.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/data/model/update_contact_response.dart';
import 'package:retrofit/retrofit.dart';
part 'contacts_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@injectable
abstract class ContactsApiClient {
  @factoryMethod
  factory ContactsApiClient(Dio dio) = _ContactsApiClient;

  @GET(EndPoints.getContacts)
  Future<ContactsResponse> getContacts();

  @GET(EndPoints.getContact)
  Future<ContactResponse> getContact(@Query("contactId") int id);

  @DELETE(EndPoints.deleteContact)
  Future<DeleteContactResponse> deleteContact(@Query("contactId") int id);

  @PATCH(EndPoints.updateContact)
  Future<UpdateContactResponse> updateContact(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );

  @POST(EndPoints.createContact)
  Future<CreateContactResponse> createContact(
    @Body() Map<String, dynamic> body,
  );
}
