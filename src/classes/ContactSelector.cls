/**
 * Name: Contact Selector
 * Description: This class is used to get Contact records from the DB
 */
public with sharing class ContactSelector {

	public static List<Contact> getContactsByExternalId(String externalId) {

		return [
				SELECT Name,
						Home_Country__c,
						Product__r.Product_Name__c,
						Product__r.ATM_Fee_In_Other_Currencies__c,
						Product__r.Cost_Per_Calendar_Month__c,
						Product__r.Card_Replacement_Cost__c
				FROM Contact
				WHERE External_Id__c = :externalId
				WITH SECURITY_ENFORCED
		];
	}
}