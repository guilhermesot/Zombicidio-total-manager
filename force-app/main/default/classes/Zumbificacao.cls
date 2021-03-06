public class Zumbificacao 
{
	@InvocableMethod (label='Transforma Zumbi')
    public static void zumbificar(List<id> ids)
    {
        System.debug(ids);
        List<Criatura__c> criList = [SELECT id, bunker__r.name, (SELECT id FROM RecursosCriatura__r) FROM Criatura__c WHERE id in : ids];
        List<RecursoCriatura__c> rcDeleteList = new List<RecursoCriatura__c>();
        for(Criatura__c cr : criList){
        	String tipoZumbi = '';
        	integer rand = Math.mod(Integer.valueOf(Math.random()*100000),100);
        	if(rand < 50 )
        	{
            	tipozumbi = 'Lerdo';
        	}
        	else if(rand < 80){
            	tipozumbi = 'Rápido';
        	}
        	else
        	{
            	tipozumbi = 'Gordo';
        	}
            cr.tipoZumbi__c = tipoZumbi;
            if(cr.RecursosCriatura__r != null)
            {
            	rcDeleteList.addall (cr.RecursosCriatura__r);
            }
        }
        update criList;
        delete rcDeleteList;
    }
}