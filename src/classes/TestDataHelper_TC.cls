@IsTest
private class TestDataHelper_TC {

	private static final String DUMMY_NAME = 'Test';

	@IsTest
	static void allMethods_WithoutInsert_Test() {

		Test.startTest();
		TestDataHelper.getContact(DUMMY_NAME, false);
		TestDataHelper.getDiscount(ConstantsClass.DISCOUNT_TYPE_PERSONAL, null, false);
		TestDataHelper.getProduct(DUMMY_NAME, false);
		Test.stopTest();

		//no asserts needed as the main responsibility for the Test Data Helper is to create records without errors due to validation rules, required fields, etc.
	}

	@IsTest
	static void allMethods_WithInsert_Test() {

		Test.startTest();
		TestDataHelper.getContact(DUMMY_NAME, true);
		Product__c product = TestDataHelper.getProduct(DUMMY_NAME, true);
		TestDataHelper.getDiscount(ConstantsClass.DISCOUNT_TYPE_PERSONAL, product, true);
		Test.stopTest();

		//no asserts needed as the main responsibility for the Test Data Helper is to create records without errors due to validation rules, required fields, etc.
	}
}