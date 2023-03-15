public with sharing class HelperBatchPokemon {
    
        public static Pokemon__c getPokemones(Integer n){
           Http http = new Http();
           HttpRequest request = new HttpRequest();
           request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+ n);
           request.setMethod('GET');
           request.setHeader('Content-Type', 'application/json;charset=UFT-8');
           request.setHeader('Accept', 'application/json');
           HttpResponse response = http.send(request);
           Map<String,Object> mapResponse = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
           Pokemon__c Poke = new Pokemon__c();
            if(response.getStatusCode() == 200){
            String pokeName = (String) mapResponse.get('name');
            Integer pokeId = (Integer) mapResponse.get('id');
            Integer pokeH = (Integer) mapResponse.get('height');
            Integer pokeW = (Integer) mapResponse.get('weight');
            List<Object> pokeTypes = (List<Object>) mapResponse.get('types');
            Map<String, Object> pokeImg = (Map<String, Object>) mapResponse.get('sprites');
            String img = (String) pokeImg.get('front_default');
            List<Object> pokeStats = (List<Object>) mapResponse.get('stats');
            List<Object> pokeAbilities =(List<Object>) mapResponse.get('abilities');
            List<Object> moves = (List<Object>) mapResponse.get('moves');
            String abName;
            String pokeType;
            String movName;
            Integer pokeSlot;
            Integer statHp;
            Integer statAt;
            Integer statSp;
            Integer statDef;
               
               //TIPOS
               for(Object p : pokeTypes){
                   Map<String, Object> po = (Map<String, Object>) p;
                   Object type = (Object) po.get('type');
                   Integer slot = (Integer) po.get('slot');
                   Map<String, Object> ty = (Map<String, Object>) type;
                   String name = (String) ty.get('name');
                       
               }
             
    
              //STATS
            
               for(Object s : pokeStats){
                   Map<String, Object> st = (Map<String, Object>) s;
                   Integer base = (Integer) st.get('base_stat');
    
                   
                   Object stat = (Object) st.get('stat');
                   Map<String, Object> t = (Map<String, Object>) stat;
                   String nam = (String) t.get('name');
                   
    
                 if(nam == 'hp'){
                       statHp = base;
                    
                   }
                   
                   if(nam == 'attack'){
                       statAt= base;
                   }
    
                     if(nam == 'defense'){
                       statDef = base;
                   }
    
                   if(nam == 'speed'){
                       statSp = base;
                   }  
                   
               }
    
    
               
            
              //HABILIDADES
              
               for(Object ab : pokeAbilities){
                   Map<String, Object> h = (Map<String, Object>) ab;
                   Object ha = (Object) h.get('ability');
                   Map<String, Object> nom =(Map<String, Object>) ha;
                   String namHab = (String) nom.get('name');
                   abName = namHab;
               }
    
    
               //MOVIMIENTOS
    
               for(Object listMov : moves){
                Map<String, Object> mapMov = (Map<String, Object>) listMov;
                Object move = (Object) mapMov.get('move');
                Map<String, Object> mapNom = (Map<String, Object>) move;
                String MName = (String) mapNom.get('name');
                movName = MName;
               }
    
    
            Poke.Name = pokeName; 
            Poke.ExtId__c = pokeId; 
            Poke.heigth__c = pokeH; 
            Poke.weigth__c = pokeW;
            Poke.imagen__c = img; 
            Poke.StatsAttack__c = statAt; 
            Poke.StatsDefense__c = statDef;
            Poke.StatsSpeed__c = statSp; 
            Poke.statshp__c = statHp;
    
    
            //CONSULTAS
            List<Habilidad__c> queryH = [SELECT Id, Name FROM Habilidad__c];  
            List<Movimiento__c> queryM = [SELECT Id, Name FROM Movimiento__c];
    
            //MATCH HABILIDAD
                for(Habilidad__c hp : queryH){
                    if((abName == hp.Name) && (abName != null)){
                        Poke.Habilidad__c = hp.Id;
                    }
                }
    
              
                
                    //MATCH MOVIMIENTOS
                    
                       for(Integer i = 1; i<=4; i++){
                    for(Movimiento__c mp : queryM){
                        
                        if((movName == mp.name) && (i ==1) && (movName != null)){
                            Poke.Slot1__c = mp.Id;
                        }else{
                            Poke.Slot1__c = ' ';
                        }
        
                        if((movName == mp.name) && (i ==2) && (movName != null)){
                            Poke.Slot2__c = mp.Id;
                        }else{
                            Poke.Slot2__c = ' ';
                        }
        
                        if((movName == mp.name) && (i ==3) && (movName != null)){
                            Poke.Slot3__c = mp.Id;
                        }else{
                            Poke.Slot3__c = ' ';
                        }
    
                        if((movName == mp.name) && (i ==4) && (movName != null)){
                            Poke.Slot4__c = mp.Id;
                        }else{
                            Poke.Slot4__c = ' ';
                        }
                        }
                    }
    
                  //GENERATION
            
                  GenerationPokemon specie = new GenerationPokemon();
                for(Integer i = 1; i<=9; i++){
                
                  for(String nam : specie.getGeneration(i)){
                if(nam ==pokeName){
                    Poke.Generation__c = i;   
                }
                }
                }
                
           }
            //System.debug(Poke);
            return Poke;
        }
    }
