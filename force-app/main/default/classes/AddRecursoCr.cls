public class AddRecursoCr {

    public void recHumano(){
        
        List<Criatura__c> rcHumano = [SELECT id,(SELECT id FROM RecursosCriatura__r) FROM Criatura__c WHERE RecordTypeId = '0125e000000us5EAAQ'];
        List<Recurso__c> recursoList = [SELECT id FROM Recurso__c];
        
        for(Criatura__c hum : rcHumano){
            Recurso__c rec1 = recursoList.get(Math.mod(Integer.valueof(Math.random()*1000),recursoList.size()));
   
        }
    }
}