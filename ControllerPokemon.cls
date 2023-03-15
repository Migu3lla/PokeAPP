public with sharing class ControllerPokemon {
    @AuraEnabled(cacheable=true)
    public static List<Pokemon__c> searchPoke(String name) {
        
        String consulta;
        if(String.isNotBlank(name)){
        consulta = 'SELECT Name FROM Pokemon__c WHERE Name'+'LIKE \'%' + name + '%\'';
        
         List<Pokemon__c> pokemon = Database.query(consulta);
        
            return pokemon;

        }else{
            return getPoke();
        }
        
       
    }

    @AuraEnabled(cacheable=true)
    public static List<Pokemon__c> getPoke() {
        List<Pokemon__c> poke = [SELECT Name, Imagen__c, heigth__c, weigth__c, Habilidad__c, 
        types__c, StatsAttack__c, StatsDefense__c, StatsSpeed__c, statshp__c, 
        Slot1__c, Slot2__c, Slot3__c, Slot4__c 
        FROM Pokemon__c ORDER BY ExtId__c ASC];
        return poke;
    }
}
