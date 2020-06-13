@isTest
public with sharing class Test_AfterUpdateIngreso {



    @isTest
    public static void given_MesesWithIngresos_WhenCalling_getAllMesesFromIngresos_Expected_SetWithMeses() 
    {
        Ingreso__c ingreso1 = new Ingreso__c( Mes__C = TestUtility.getFakeId(Ingreso__c.getSObjectType(), '0' ) );

        AfterUpdateIngresoTriggerHandler handler = new AfterUpdateIngresoTriggerHandler( new Ingreso__c[]
        {
            ingreso1
        });
        
        Test.startTest();
        handler.getAllMesesFromIngresos();
        Test.stopTest();

        System.assertEquals(1, handler.meses.size());
    }
    
    @isTest
    public static void given_AMesWithIngresos_When_UpdateOneIngreso_Expected_GastoDiezmoMontoUpdated() 
    {
        

    }
}
