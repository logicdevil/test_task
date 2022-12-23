import {LightningElement, api, wire} from 'lwc';
import {getRecord} from "lightning/uiRecordApi";
import CUSTOMER_DISCOUNT_ID from '@salesforce/schema/Case.Contact.Product__c';
import NO_DATA_AVAILABLE from '@salesforce/label/c.No_Data_Available'
import {handleError} from "c/utils";

const CUSTOMER_FIELDS = [CUSTOMER_DISCOUNT_ID];

export default class CustomerProductInformation extends LightningElement {

    @api recordId;
    discountId;
    noDataMessage = NO_DATA_AVAILABLE;
    isShowSpinner = true;

    @wire(getRecord, {recordId : '$recordId', fields : CUSTOMER_FIELDS})
    _getDiscountRecord(result) {
        if (result?.data) {
            this.discountId = result.data.fields?.Contact?.value?.fields?.Product__c?.value;
        } else if (result?.error) {
            handleError(result.error, true);
        }
        this.isShowSpinner = false;
    }

    get isShowNoDataMessage() {
        return !this.discountId;
    }
}