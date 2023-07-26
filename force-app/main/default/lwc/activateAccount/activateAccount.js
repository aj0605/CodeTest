import { LightningElement,api } from 'lwc';
import activateAccountwWithSummary from'@salesforce/apex/activateAccountClass.activateAccountwWithSummary';

export default class ActivateAccount extends LightningElement {
    @api recordId; 
    isLoading=false;   
    handleClick(){
        var activationSummary = this.template.querySelector('[data-id="activationSummary"]');
        if (activationSummary.value ==null || activationSummary.value =='') {
            activationSummary.setCustomValidity('Account Activation Summary is required.');
            activationSummary.reportValidity();
            return;
          } else {
            activationSummary.setCustomValidity('');
            activationSummary.reportValidity();
          }
          this.isLoading=true;   
          activateAccountwWithSummary(
            {
            recordId : this.recordId,
            accountSummary : activationSummary.value
        }).then(result=>{
            this.isLoading=false;   
            console.log(result);
        }).catch(error=>{
            this.isLoading=false;   
            console.log(error);
        });

    }
}
