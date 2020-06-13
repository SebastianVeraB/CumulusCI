trigger IngresoTrigger on Ingreso__c (after update, after insert) {
    if(Trigger.isAfter) 
    {
        if(Trigger.isUpdate || Trigger.isInsert)
        {
            AfterUpdateIngresoTriggerHandler handler = new AfterUpdateIngresoTriggerHandler(Trigger.new);
            handler.run();
        }
        
    }
}