@IsTest
private class ConstantsClass_TC {

	@IsTest
	static void test() {

		Test.startTest();
		String value = ConstantsClass.COUNTRY_FR; //There is nothing to test in the constants class so it is enough to reference it for static variables loading and code coverage
		Test.stopTest();
	}
}