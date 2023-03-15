public class BatchPokeMove implements Database.Batchable<Integer>, Database.AllowsCallouts{
    public Iterable<Integer> start(Database.BatchableContext bc) {
        List<Integer> listEnteros = new List<Integer>();

        for(Integer i=1; i<=826; i++){
            listEnteros.add(i);
        }
        return listEnteros;
    }

    public void execute(Database.BatchableContext bc, List<Integer> n){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/move/'+n[0]);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json;charset=UFT-8');
        request.setHeader('Accept', 'application/json');
        HttpResponse response = http.send(request);
        Map<String, Object> mapResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        if(response.getStatusCode() == 200){
        Integer movId = (Integer) mapResponse.get('id');
        Integer movAccuracy = (Integer) mapResponse.get('accuracy');
        Integer movChance = (Integer) mapResponse.get('effect_chance');
        Object movTarget = (Object) mapResponse.get('target');
        Map<String, Object> target = (Map<String, Object>) movTarget;
        String targetName = (String) target.get('name');
        Integer movPriority = (Integer) mapResponse.get('priority');
        List<Object> movEffect = (List<Object>) mapResponse.get('effect_entries'); 
        String movShort;
        Integer movPower = (Integer) mapResponse.get('power');
        Integer movPP = (Integer) mapResponse.get('pp');
        Map<String, Object> movType = (Map<String, Object>) mapResponse.get('type');
        String typeName = (String) movType.get('name');
        String movName = (String) mapResponse.get('name');
        


        for(Object ef : movEffect){
            Map<String, Object> aux =(Map<String, Object>) ef;
            String movSh = (String) aux.get('short_effect');
            movShort = movSh;
           }

           

        
        
        Movimiento__c Movimientos = new Movimiento__c();
        
            Movimientos.Name = movName;
            Movimientos.ExtId__c = movId;
            Movimientos.Type_name__c = typeName;
            Movimientos.accuracy__c = movAccuracy;
            Movimientos.effect_chance__c = movChance;
            Movimientos.target_name__c = targetName;
            Movimientos.Priority__c = movPriority;
            Movimientos.effect_entries_short_effect__c = movShort;
            Movimientos.Power__c = movPower;
            Movimientos.PP__c = movPP; 
           
            //System.debug(Movimientos);
           
            
            insert Movimientos;   
                        
        }    
		
    }
    public void finish(Database.BatchableContext bc){
        system.debug('Finalizo el batch');
    }
}