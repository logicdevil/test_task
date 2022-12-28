/**
 * Name: Constants Class
 * Description: This method should be used for commonly used literals
 * IMPORTANT! All frontend values (text that is visible to the customer) should be stored in Custom Labels
 */
public with sharing class ConstantsClass {

	/* Response Codes */
	public final static Integer RESPONSE_CODE_SUCCESS = 200;
	public final static Integer RESPONSE_CODE_BAD_REQUEST = 400;
	public final static Integer RESPONSE_CODE_INTERNAL_ERROR = 500;
	public final static Integer RESPONSE_CODE_NOT_FOUND = 404;

	/* Backend errors */
	public final static String ERROR_MESSAGE_UNHANDLED = 'Unexpected error occurred. Please contact Administrator for more details.'; //generic message stored in the constants class

	/* Other */
	public final static String COUNTRY_FR = 'FR';
	public final static String DISCOUNT_TYPE_PERSONAL = 'Personal';
}