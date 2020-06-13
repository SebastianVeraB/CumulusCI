public with sharing class AfterUpdateIngresoTriggerHandler {

    @testVisible private Set< Id > meses;

    @testVisible private List< Gasto__c > DiezmosFromMes;
    
    @testVisible private list< Ingreso__c > newIngresos;

    public AfterUpdateIngresoTriggerHandler(list< Ingreso__c > newIngresos) 
    {
       this.newIngresos = newIngresos;
       meses = new Set< Id >();
       DiezmosFromMes = new List< Gasto__c >();
       
    }

    public void run() 
    {
        System.debug('rnning');
        getAllMesesFromIngresos(newIngresos);
        System.debug('rnning');
        queryDiezmosFromCorrespondingMes();
        System.debug('rnning');
        updateUnpaidDiezmosMontos();
        System.debug('rnning');
    }

    @testVisible
    private void getAllMesesFromIngresos(list< Ingreso__c > newIngresos) 
    {
        for( Ingreso__c ingreso : newIngresos)
        {
            meses.add(ingreso.Mes__c);
        }
    }

    @testVisible
    private void  queryDiezmosFromCorrespondingMes() 
    {
        DiezmosFromMes = [  SELECT id, Monto__c, Monto_Dependiente__c 
                            FROM Gasto__c 
                            WHERE Mes__c 
                            IN :meses 
                            AND Categoria__c = 'Diezmo'];
    }

    @testVisible
    private void updateUnpaidDiezmosMontos() 
    {
        for (Gasto__c diezmo :DiezmosFromMes) 
        {
            if( !diezmo.Pago__c )
            {
                diezmo.Monto__c = diezmo.Monto_Dependiente__c;
            }
        }
        update DiezmosFromMes;
    }
    
    
}