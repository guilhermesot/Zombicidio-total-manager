global class SurvivorSchedulable implements Schedulable{
    
    global void execute(SchedulableContext SC){
        this.contagiar();
    }
    
    
    private void contagiar(){
        List<Criatura__c> humanList = [SELECT id FROM Criatura__c where recordtypeId = '0125e000000us5EAAQ'];
        List<Criatura__c> zombieList = [SELECT id FROM Criatura__c where recordtypeId = '0125e000000us5JAAQ'];
   
		for(Criatura__c zb : zombieList){
            if(humanList.size()== 0) break;
            Criatura__c hmn1 = humanList.get(Math.mod(Integer.valueOf(Math.random()*1000),humanList.size()));
            if( Math.mod(Integer.valueOf(Math.random()*1000) , 2) == 0){
                hmn1.recordtypeId = '0125e000000us5EAAQ';
            }
            else{
            hmn1.recordtypeId = '0125e000000us5JAAQ';
            hmn1.DataZumbificacao__c = Date.today();    
            }  
        } 
        update humanList;
    }   
}