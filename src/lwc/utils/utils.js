import {ShowToastEvent} from "lightning/platformShowToastEvent";

const isString = (value) => {
    return typeof value === 'string' || value instanceof String;
};

const handleError = (error, doShowToast, doLogInConsole, toastMode = 'dismissable') => {

    let message = '';
    if (isString(error)) {
        message = error;
    } else if (error.body) {
        if (Array.isArray(error.body)) {
            message = error.body.map(e => e.message).join(', ');
        } else if (typeof error.body.message === 'string') {
            let outputErrors = error.body.output ? error.body.output.errors : null;
            if (outputErrors && outputErrors.length) {
                outputErrors.forEach(curError => message += (curError.message + '; '));
            } else {
                message = error.body.message;
            }
        } else if (error.body.pageErrors) {
            message = error.body.pageErrors.map(e => e.message).join(', ');
        }
    } else if (error.detail && error.detail.detail) {
        message = error.detail.detail;
    } else {
        message = 'Unknown error';
    }

    if (doLogInConsole) {
        console.log(message);
    }

    if (doShowToast) {
        showToast('Error', message, 'error', toastMode);
    }
};

const showToast = (title, message, variant, mode) => {
    const showToast = new ShowToastEvent({
        title: title,
        message: message,
        variant: variant,
        mode: mode
    });
    dispatchEvent(showToast);
};

export {handleError, showToast}