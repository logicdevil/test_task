/**
 * Name: Test Data Helper
 * Description: This class is used to create a basic version of the object populating only required fields
 * IMPORTANT! Don't populate non-required fields in this class. All functionality specific fields should be populated in the respective test class
 */
public with sharing class TestDataHelper {

	public static Contact getContact(String lastName, Boolean isInsert) {

		Contact singleContact = new Contact();
		singleContact.LastName = lastName;
		//all required fields should be populated here

		if(isInsert) {
			insert singleContact;
		}

		return singleContact;
	}

	public static Product__c getProduct(String name, Boolean isInsert) {

		Product__c product = new Product__c();
		product.Name = name;
		product.Country__c = ConstantsClass.COUNTRY_FR;
		//all required fields should be populated here

		if(isInsert) {
			insert product;
		}

		return product;
	}

	public static Discount__c getDiscount(String discountType, Product__c product, Boolean isInsert) {

		Discount__c discount = new Discount__c();
		discount.Type__c = discountType;
		discount.Product__c = product?.Id;
		//all required fields should be populated here

		if(isInsert) {
			insert discount;
		}

		return discount;
	}
}