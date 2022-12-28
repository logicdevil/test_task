/**
 * Name: Contacts REST Service
 * Description: This class is used by external systems to perform operations on the Contact object
 */
@RestResource(UrlMapping='/customers/*')
global with sharing class ContactsRESTService {

	@TestVisible
	private static final String ERROR_NO_CONTACT_FOUND = 'No Contact found by given external Id.'; //error messages specific to the functionality are stored in the class responsible for the functionality
	@TestVisible
	private static final String ERROR_NO_ID_PROVIDED = 'External Id is not provided/found in the request.';

	@HttpGet
	global static void getCustomer() {

		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		String errorMessage;
		CustomerWrapper wrapper = new CustomerWrapper();

		try {

			String externalId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1); //get the external id from the URI

			if (String.isBlank(externalId)) {

				res.statusCode = ConstantsClass.RESPONSE_CODE_BAD_REQUEST;
				errorMessage = ERROR_NO_ID_PROVIDED;
			} else {

				List<Contact> contacts = ContactSelector.getContactsByExternalId(externalId);

				if (contacts.isEmpty()) {    //external Id is unique so the system will find either one or none contacts

					res.statusCode = ConstantsClass.RESPONSE_CODE_NOT_FOUND;
					errorMessage = ERROR_NO_CONTACT_FOUND;
				} else {

					Contact singleContact = contacts[0];
					Discount__c product = singleContact.Product__r;

					wrapper.customerName = singleContact.Name;
					wrapper.productName = product?.Product_Name__c;
					wrapper.cardReplacementCost = product?.Card_Replacement_Cost__c; //cost is returned with already applied discount
					wrapper.aTMFeeInOtherCountries = product?.ATM_Fee_In_Other_Currencies__c;
					wrapper.costPerCalendarMonth = product?.Cost_Per_Calendar_Month__c;
					wrapper.country = singleContact?.Home_Country__c;

					res.statusCode = ConstantsClass.RESPONSE_CODE_SUCCESS;
				}
			}
		} catch (Exception exc) {

			res.statusCode = ConstantsClass.RESPONSE_CODE_INTERNAL_ERROR;
			errorMessage = ConstantsClass.ERROR_MESSAGE_UNHANDLED;
			// todo Exception should be logged here to the internal or external system, depending on the requirements
		}

		res.responseBody = Blob.valueOf(String.isBlank(errorMessage) ? JSON.serialize(wrapper) : errorMessage);
	}

	@TestVisible
	class CustomerWrapper {

		@TestVisible
		String customerName;
		@TestVisible
		String productName;
		@TestVisible
		String country;
		@TestVisible
		Decimal costPerCalendarMonth;
		@TestVisible
		Decimal aTMFeeInOtherCountries;
		@TestVisible
		Decimal cardReplacementCost;
	}
}