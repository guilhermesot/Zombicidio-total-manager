global class ContagionSchedulable implements Schedulable
{
	
	global void execute(SchedulableContext SC) 
    {   
        this.contagiar();
    }
    
    
    private void contagiar(){
        List<Criatura__c> humanList = [SELECT id, bunker__r.ProtecaoBunker__c, bunker__c, (select id, acrescimoDefesa__c  from RecursosCriatura__r) FROM Criatura__c  where recordtypeId = '0125e000000us5EAAQ'];
        List<Criatura__c> zombieList = [SELECT id FROM Criatura__c where recordtypeId = '0125e000000us5JAAQ'];
        LIST<RecursoCriatura__c> rcDeleteList = new List<RecursoCriatura__c>();
        
        for(Criatura__c zb : zombieList){
            if(humanList.size() == 0) break;
            Criatura__c hmn1 = humanList.get(Math.mod(Integer.valueof(Math.random()*1000),humanList.size()));
            Decimal defesa = 0;
            if(hmn1.recordtypeId  != '0125e000000us5JAAQ')
            {
                //Adicionar proteção do bunker para o humano
                if(hmn1.bunker__c != null)
                {
                    defesa += hmn1.bunker__r.ProtecaoBunker__c;
                }
                //Adicionar proteção dos recursos para a criatura
                if(hmn1.RecursosCriatura__r != null)
                {
                    for(recursoCriatura__c recCri : hmn1.RecursosCriatura__r)
                    {
                        defesa += recCri.acrescimoDefesa__c;
                    }
                }
            }
            Integer DiceRoll = Math.mod(Integer.valueof(Math.random()*100000),100)+1;
            if(DiceRoll > defesa)
            {
                hmn1.recordtypeId  = '0125e000000us5JAAQ';
                hmn1.DataZumbificacao__c = Date.today();
                //Definir o tipo de zumbi que o humano se tornou
                Integer rand = Integer.valueOf(Math.random()*100);
                if(rand < 50){
                      hmn1.TipoZumbi__c = 'Lerdo';                      
                }
                else if(rand < 80){
                      hmn1.TipoZumbi__c = 'Rápido';                      
                }
                else {
                      hmn1.TipoZumbi__c = 'Gordo';                      
                }
                //Deletar os recursos que o humano possuia antes de virar zumbi
                if(hmn1.RecursosCriatura__r != null)
            {
            	rcDeleteList.addall (hmn1.RecursosCriatura__r);
            }
            }
            defesa = 0;
            Criatura__c hmn2 = humanList.get(Math.mod(Integer.valueof(Math.random()*1000),humanList.size()));
            if(hmn2.recordtypeId  != '0125e000000us5JAAQ')
            {
                if(hmn2.bunker__c != null)
                {
                    defesa += hmn2.bunker__r.ProtecaoBunker__c;
                }
                if(hmn2.RecursosCriatura__r != null)
                {
                    for(recursoCriatura__c recCri : hmn2.RecursosCriatura__r)
                    {
                        defesa += recCri.acrescimoDefesa__c;
                    }
                }
            }
            Integer DiceRoll2 = Math.mod(Integer.valueof(Math.random()*100000),100)+1;
            if(DiceRoll2 > defesa)
            {
                hmn2.recordtypeId = '0125e000000us5JAAQ';
                hmn2.DataZumbificacao__c = Date.today();
                //Definir o tipo de zumbi que o humano se tornou
                Integer rand = Integer.valueOf(Math.random()*100);
                if(rand < 50){
                      hmn2.TipoZumbi__c = 'Lerdo';                      
                }
                else if(rand < 80){
                      hmn2.TipoZumbi__c = 'Rápido';                      
                }
                else {
                      hmn2.TipoZumbi__c = 'Gordo';             
                }
                //Deletar os recursos que o humano possuia antes de virar zumbi
                if(hmn2.RecursosCriatura__r != null)
                {
            		rcDeleteList.addall (hmn2.RecursosCriatura__r);
            	}
            }
        }
        update humanList;
        delete rcDeleteList;
    }
}