global class ScheduleMesCreation implements Schedulable {
    global void execute(SchedulableContext ctx) {
        DateTime dt = Datetime.now();
        String month = dt.format('MMMM');
        Mes__c mes = new Mes__c(Name = month);
        insert mes;
    }
}