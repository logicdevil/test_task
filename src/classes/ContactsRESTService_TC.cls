@IsTest
private class ContactsRESTService_TC {

	private final static String CONTACT_LAST_NAME = 'TEST Customer';
	private final static String PRODUCT_NAME = 'Standard';
	private final static Decimal COST_PER_MONTH = 10;
	private final static Decimal ATM_FEE_OTHER_CURRENCIES = 0.05;
	private final static Decimal CARD_REPLACEMENT_COST = 7;
	private final static String DUMMY_EXTERNAL_ID = 'abc';
	private final static String DUMMY_NON_EXISTING_EXTERNAL_ID = '123';
	private final static String DUMMY_URL = 'http://dummy.com';

	@TestSetup
	static void setup() {

		Product__c product = TestDataHelper.getProduct(PRODUCT_NAME, false);
		product.Cost_Per_Calendar_Month__c = COST_PER_MONTH;
		product.ATM_Fee_In_Other_Currencies__c = ATM_FEE_OTHER_CURRENCIES;
		product.Card_Replacement_Cost__c = CARD_REPLACEMENT_COST;
		insert product;

		Discount__c discount = TestDataHelper.getDiscount(ConstantsClass.DISCOUNT_TYPE_PERSONAL, product, true);

		Contact singleContact = TestDataHelper.getContact(CONTACT_LAST_NAME, false);
		singleContact.Product__c = discount.Id;
		singleContact.Home_Country__c = ConstantsClass.COUNTRY_FR;
		singleContact.External_Id__c = DUMMY_EXTERNAL_ID;
		insert singleContact;
	}

	@IsTest
	static void getCustomer_NoIdInRequest_Test() {

		RestContext.response = new RestResponse();
		RestRequest request = new RestRequest();
		request.requestURI = DUMMY_URL + '/';
		RestContext.request = request;

		Test.startTest();
		ContactsRESTService.getCustomer();
		Test.stopTest();

		System.assertEquals(ConstantsClass.RESPONSE_CODE_BAD_REQUEST, RestContext.response.statusCode);
		System.assertEquals(ContactsRESTService.ERROR_NO_ID_PROVIDED, String.valueOf(RestContext.response.responseBody.toString()));
	}

	@IsTest
	static void getCustomer_NoContactFound_Test() {

		RestContext.response = new RestResponse();
		RestRequest request = new RestRequest();
		request.requestURI = DUMMY_URL + '/' + DUMMY_NON_EXISTING_EXTERNAL_ID;
		RestContext.request = request;

		Test.startTest();
		ContactsRESTService.getCustomer();
		Test.stopTest();

		System.assertEquals(ConstantsClass.RESPONSE_CODE_NOT_FOUND, RestContext.response.statusCode);
		System.assertEquals(ContactsRESTService.ERROR_NO_CONTACT_FOUND, String.valueOf(RestContext.response.responseBody.toString()));
	}

	@IsTest
	static void getCustomer_SuccessResponse_Test() {

		RestContext.response = new RestResponse();
		RestRequest request = new RestRequest();
		request.requestURI = DUMMY_URL + '/' + DUMMY_EXTERNAL_ID;
		RestContext.request = request;

		Test.startTest();
		ContactsRESTService.getCustomer();
		Test.stopTest();

		System.assertEquals(ConstantsClass.RESPONSE_CODE_SUCCESS, RestContext.response.statusCode);
		ContactsRESTService.CustomerWrapper wrapper = (ContactsRESTService.CustomerWrapper)
				JSON.deserialize(String.valueOf(RestContext.response.responseBody.toString()), ContactsRESTService.CustomerWrapper.class);
		System.assertEquals(CONTACT_LAST_NAME, wrapper.customerName);
		System.assertEquals(PRODUCT_NAME, wrapper.productName);
		System.assertEquals(CARD_REPLACEMENT_COST, wrapper.cardReplacementCost);
		System.assertEquals(ATM_FEE_OTHER_CURRENCIES, wrapper.aTMFeeInOtherCountries);
		System.assertEquals(CARD_REPLACEMENT_COST, wrapper.cardReplacementCost);
		System.assertEquals(ConstantsClass.COUNTRY_FR, wrapper.country);
	}
}