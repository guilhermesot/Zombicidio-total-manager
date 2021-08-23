public with sharing class ContagiarBatchable implements Database.Batchable<Criatura__c>{
    public ContagiarBatchable() {}

    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT id, Criatura__c.RecordTypeId, bunker__r.protecaoBunker__c, '+
                                        'bunker__c, (select id, acrescimoDefesa__c from RecursosCriatura__r) FROM Criatura__c');
    }

    public void execute(Database.BatchableContext BC, List<Criatura__c> scope)
    {
        List<Criatura__c> hum = new List<Criatura__c>();
        List<Criatura__c> zom = new List<Criatura__c>();


    }

    private List<Criatura__c> preencheListaCriaturaRecordType(id recordtype, List<Criatura__c> listP)
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
