public with sharing class AfterUpdateIngresoTriggerHandler {

    @testVisible private Set< Id > meses;

    @testVisible private List< Mes__c > mesesWithGastosAndIngresos;
    
    @testVisible private list< Ingreso__c > newIngresos;

    @testVisible private list< Gasto__c > DiezmosToUpdate;

    public AfterUpdateIngresoTriggerHandler(list< Ingreso__c > newIngresos) 
    {
       this.newIngresos = newIngresos;
       meses = new Set< Id >();
       mesesWithGastosAndIngresos = new List< Mes__c >();
       DiezmosToUpdate = new List< Gasto__c >();

    }

    public void run() 
    {
        getAllMesesFromIngresos();
        queryMesWithDiezmoAndIngresos();
        updateUnpaidDiezmosMontos();
    }

    @testVisible
    private void getAllMesesFromIngresos() 
    {
        for( Ingreso__c ingreso : newIngresos )
        {
            meses.add( ingreso.Mes__c );
        }
    }

    @testVisible
    private void  queryMesWithDiezmoAndIngresos() 
    {
        mesesWithGastosAndIngresos = [  
                                        SELECT id, 
                                                (SELECT Monto__c, Pago__c 
                                                FROM Gastos__r 
                                                WHERE Categoria__c = 'Diezmo'
                                                LIMIT 1), 
                                                        (SELECT Monto__c 
                                                        FROM Ingresos__r)
                                        FROM Mes__c 
                                        WHERE Id 
                                        IN :meses 
                                    ];
    }

    @testVisible
    private void updateUnpaidDiezmosMontos() 
    {
        for (Mes__c mes :mesesWithGastosAndIngresos ) 
        {
           
            if( diezmoNotPaid( mes ) )
            {
                updateDiezmoMonto(mes);
            }
        }
        upsert DiezmosToUpdate;
    }

    private void updateDiezmoMonto(Mes__c mes) 
    {
        Gasto__c diezmo = mes.Gastos__r[0];
        Decimal acumulatedMonto = 0.0;

        for( Ingreso__c ingreso : mes.Ingresos__r)
        {
            acumulatedMonto += ingreso.Monto__c;
        }

        diezmo.Monto__c = acumulatedMonto * 0.1;
        DiezmosToUpdate.add( diezmo );
    }

    private boolean diezmoNotPaid( Mes__c mes ) 
    {
        if( mes.Gastos__r.size() > 0 ) 
        {
            return !mes.Gastos__r[0].Pago__c;
        }
        else return false;
       

    }
    
    
}