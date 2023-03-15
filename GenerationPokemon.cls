public class GenerationPokemon {
    public  List<String>  getGeneration(Integer n) {
             //GET 
          
             List<String> listGeneration = new List<String>();
               Integer i = 1;    
                   Http http = new Http();
                   HttpRequest request = new HttpRequest();
                   request.setEndpoint('https://pokeapi.co/api/v2/generation/'+ i);
                   request.setMethod('GET');
                   request.setHeader('Content-Type', 'application/json;charset=UFT-8');
                   request.setHeader('Accept', 'application/json');
                   HttpResponse response = http.send(request);
                   Map<String,Object> mapResponse = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
                   List<Object> listSpecies = (List<Object>) mapResponse.get('pokemon_species');
         
                       
                       for(Object s : listSpecies){
                  Map<String, Object> mapSpec = (Map<String, Object>) s;
                  String name = (String) mapSpec.get('name');           	
                       
                   listGeneration.add(name);
                   }
                   
               
                   return listGeneration;
              
   
       }
   
   }