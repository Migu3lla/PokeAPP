public class BatchPokeHabilidad implements Database.Batchable<Integer>, Database.AllowsCallouts{
    public Iterable<Integer> start(Database.BatchableContext bc) {
        List<Integer> listEnteros = new List<Integer>();
        
        for(Integer i=1; i<=267; i++){
            listEnteros.add(i);
        }
        return listEnteros;
    }

    public void execute(Database.BatchableContext bc, List<Integer> n){
       Http http = new Http();
       HttpRequest request = new HttpRequest();
       request.setEndpoint('https://pokeapi.co/api/v2/ability/'+ n[0]);
       request.setMethod('GET');
       request.setHeader('Content-Type', 'application/json;charset=UFT-8');
       request.setHeader('Accept', 'application/json');
       HttpResponse response = http.send(request);
       Map<String, Object> listres= (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
       if(response.getStatusCode() == 200){
       List<Object> habEffect = (List<Object>) listRes.get('effect_entries');
       String habShort;
       Integer habId = (Integer) listRes.get('id');
       String habName = (String) listRes.get('name');
       
        
       for(Object ef : habEffect){
        Map<String, Object> aux =(Map<String, Object>) ef;
        Object objLan = (Object) aux.get('language');
        Map<String, Object> mapLan = (Map<String, Object>) objLan;
        String namLang = (String) mapLan.get('name');
        String habSh = (String) aux.get('short_effect');
           if(namLang == 'en'){
        habShort = habSh;
           }
        }
         
         for(Object ef : habEffect){
        Map<String, Object> aux =(Map<String, Object>) ef;
        Object objLan = (Object) aux.get('language');
        Map<String, Object> mapLan = (Map<String, Object>) objLan;
        String namLang = (String) mapLan.get('name');
        String habSh = (String) aux.get('short_effect');
           if(namLang == 'en'){
        habShort = habSh;
           }
        }
        
        
        Habilidad__c Habilidad = new Habilidad__c();
        
       
        Habilidad.name = habName;
        Habilidad.ExtId__c = habId;
        Habilidad.effect_entries_short_effect__c = habShort;
               
        

        insert Habilidad;
        //System.debug(Habilidad);
    }
    }
    public void finish(Database.BatchableContext bc){
        system.debug('Finalizo el batch');
    }
}