@IsTest
private class ContactSelector_TC {

	private final static String CONTACT_LAST_NAME = 'TEST Customer';
	private final static String DUMMY_EXTERNAL_ID = 'abc';

	@TestSetup
	static void setup() {

		Contact singleContact = TestDataHelper.getContact(CONTACT_LAST_NAME, false);
		singleContact.External_Id__c = DUMMY_EXTERNAL_ID;
		insert singleContact;
	}

	@IsTest
	static void test() {

		Test.startTest();
		List<Contact> contacts = ContactSelector.getContactsByExternalId(DUMMY_EXTERNAL_ID);
		Test.stopTest();

		System.assertEquals(1, contacts.size());
	}
}