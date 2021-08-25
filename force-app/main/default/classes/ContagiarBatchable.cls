public with sharing class ContagiarBatchable implements Database.Batchable<sObject>{
    
    private String ZombieId =  Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Zumbi').getRecordTypeId();
    private String HumanId  =  Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Humano').getRecordTypeId();

    static final integer ZombieSpread = 2;
    
    
    public ContagiarBatchable() {}

    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT id, Criatura__c.RecordTypeId, bunker__r.protecaoBunker__c, '+
                                        'bunker__c, (select id, acrescimoDefesa__c from RecursosCriatura__r) FROM Criatura__c');
    }

    public void execute(Database.BatchableContext BC, List<sObject> scope)
    {
        List<Criatura__c> criList = (List<Criatura__c>) scope;
        Map<id,Criatura__c> criUpdateList = new Map<id,Criatura__c>();
        List<Criatura__c> humList = preencheListaCriaturaRecordType(HumanId, criList);
        List<Criatura__c> zumList = preencheListaCriaturaRecordType(ZombieId, criList);
        LIST<RecursoCriatura__c> rcDeleteList = new List<RecursoCriatura__c>();
        for(Criatura__c zum : zumList){
            for(integer i=0; i<ZombieSpread; i++){
                Criatura__c cri = (Criatura__c) Util.GetRandomIten(humList);
                Decimal defesa = this.getDefense(cri);
                Integer DiceRoll = Math.mod(Integer.valueof(Math.random()*100000),100)+1;
                if(DiceRoll > defesa){
                    cri.recordtypeId  = ZombieId;
                    cri.DataZumbificacao__c = Date.today();
                    //Definir o tipo de zumbi que o humano se tornou
                    Integer rand = Integer.valueOf(Math.random()*100);
                    if(rand < 50)
                        cri.TipoZumbi__c = 'Lerdo';                      
                    else if(rand < 80)
                        cri.TipoZumbi__c = 'Rápido';                      
                    else cri.TipoZumbi__c = 'Gordo';                      
                    //Deletar os recursos que o humano possuia antes de virar zumbi
                    if(cri.RecursosCriatura__r != null)
            	        rcDeleteList.addall (cri.RecursosCriatura__r);
                    criUpdateList.put(cri.id,cri);
                }
            }
        }
        update criUpdateList.values();
    }

    private Decimal getDefense(Criatura__c hmn1)
    {
        Decimal defesa = 0;
        if(hmn1.recordtypeId  != ZombieId)
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
        return defesa;
    }
    
    private List<Criatura__c> preencheListaCriaturaRecordType(id recordtype, List<Criatura__c> listaP)
    {
        List<CRiatura__c> cri = new List<Criatura__c>();
        for(Criatura__c crip: listaP)
        {
            if(crip.recordtypeId == recordtype) cri.add(crip);
        }
        return cri;
    }
    
    public void finish(Database.BatchableContext BC){
    }
}