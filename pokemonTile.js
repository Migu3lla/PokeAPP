import { LightningElement, api} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class PokemonTile extends NavigationMixin(LightningElement) {

    @api poke;

    navigateToRecordViewPage() {
        // View a custom object record.
        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
                recordId: this.poke.Id,
                objectApiName: "Pokemon__c", 
                actionName: "view"
            }
        });
    }

}