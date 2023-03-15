public class BatchPokemon implements Database.Batchable<Integer>, Database.AllowsCallouts{
    public Iterable<Integer> start(Database.BatchableContext bc) {
        List<Integer> listEnteros = new List<Integer>();

        for(Integer i=1; i<=898; i++){ //898
            listEnteros.add(i);
        }
        return listEnteros;
    }

    public void execute(Database.BatchableContext bc, List<Integer> n){
       
        for(Integer num : n){
       Pokemon__c Poke = helperbatch.getPokemones(num);
       insert Poke;
      
       //System.debug(Poke);
        }
        }
        

        
    
       

    
    public void finish(Database.BatchableContext bc){
        system.debug('Finalizo el batch');
    }

}