public class ZerarZumbi {
	
    private void tornarZumbiHumano(){
       
        List<Criatura__c> criaturaList = [Select id FROM Criatura__c WHERE RecordTypeId <> '0125e000000us5EAAQ'];
    	
        for(Criatura__c cri : criaturaList){
            cri.RecordTypeId = '0125e000000us5EAAQ';
        }
        update criaturaList;
  
    }
    
}