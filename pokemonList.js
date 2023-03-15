import { LightningElement, wire} from 'lwc';
import searchPoke from "@salesforce/apex/ControllerPokemon.searchPoke";
export default class PokemonList extends NavigationMixin(LightningElement) {   

    name = '';
    pokemon;
    
    @wire(searchPoke, {name: '$name'})

    loadPokemon(result) {
		this.pokemon = result;
		
	}
    handleSearchTermChange(event) {
	
		window.clearTimeout(this.delayTimeout);
		const name = event.target.value;
		searchPoke ({ name: name })
		.then(result => {
			this.pokemon = result;
		})
		.catch(error => {
			console.error(error);
		});
		this.delayTimeout = setTimeout(() => {
			this.name = name;
		}, 100);
	}
   
	
	/*get hasResults() {
		return (this.pokemon.data.length > 0);
	}*/
	

}