global class AddHumanBunker implements Schedulable
{
	
	global void execute(SchedulableContext SC) 
    {   
        this.addHuman();
    }
    
	private void addHuman(){
        List<Criatura__c> humanList = [SELECT id FROM Criatura__c where recordtypeId = '0125e000000us5EAAQ'];
   		List<Bunker__c> bunkerList = [SELECT id FROM Bunker__c];
		
        //pegar um número aleatório e definir em qual bunker o humano ira ficar
        for(Criatura__c hm : humanList){
        	if(Integer.valueOf(Math.random()*1000) <= 1 ) //ilha
        	{
            	hm.Bunker__c = 'a015e00000Pjp9EAAR';
        	}
        	else if(Integer.valueOf(Math.random()*1000) <= 10) //Subterranêo
        	{
            	hm.Bunker__c = 'a015e00000Pjp9PAAR';
        	}
            else if(Integer.valueOf(Math.random()*1000) <= 120) //Montanha
        	{
            	hm.Bunker__c = 'a015e00000Pjp9nAAB'; 
            }
            else if(Integer.valueOf(Math.random()*1000) <= 200) // Floresta
        	{
            	hm.Bunker__c = 'a015e00000Pjp9iAAB';
            }
            else if(Integer.valueOf(Math.random()*1000) <= 300) // Presídio
        	{
            	hm.Bunker__c = 'a015e00000NkRiaAAF';
            }
            else if(Integer.valueOf(Math.random()*1000) <= 400) // Cidade
        	{
            	hm.Bunker__c = 'a015e00000Pjp9OAAR';
        	}
                else{
                    hm.Bunker__c = null;
                }
        }    
        update humanList;
  
}
}