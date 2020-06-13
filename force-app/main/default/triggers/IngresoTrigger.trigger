trigger IngresoTrigger on Ingreso__c (after update) {
    if(Trigger.isAfter) 
    {
        if(Trigger.isUpdate)
        {
            AfterUpdateIngresoTriggerHandler handler = new AfterUpdateIngresoTriggerHandler(Trigger.new);
            handler.run();
        }
        
    }
}