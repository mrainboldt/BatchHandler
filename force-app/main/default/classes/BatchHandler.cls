/**
 * @description framework for batch classes
 */
global virtual class BatchHandler implements Database.Batchable<sObject>, Schedulable, Database.Stateful 
{
    private String query;
    public Batch_Handler__c handler = this.getHandler();
    public String batchHandlerName;
    public Datetime lastRun;
    public Set<Id> ids;

    public BatchHandler(){}

    global virtual Database.QueryLocator start(Database.BatchableContext BC) 
    {
        System.debug(this.getQuery());
        return Database.getQueryLocator(this.getQuery());
    }

    private void executeSchedule(SchedulableContext SC) 
    {
        Integer batchsize = this.handler == null 
                            ? 200 : Integer.valueOf(this.handler.Batch_Size__c);
        
        Database.executebatch(this, batchsize);
    }

    global void execute(SchedulableContext SC)
    {
        this.handler = this.getHandler(); 
        this.executeSchedule(SC);
    }

    global virtual void execute(Database.BatchableContext BC, List<SObject> scope){}
    
    global virtual void finish(Database.BatchableContext BC) 
    {
        this.updateHandler();
    }

    /**
     * @description updates the handler with the last time it ran
     */
    public void updateHandler()
    {
        if(handler == null)
        {
            handler = this.getHandler();
        }           

        if(handler == null)
        {
            handler = new Batch_Handler__c();
            handler.Name = this.batchHandlerName;
        }
        handler.Last_Run__c = System.now();
        upsert handler Name;
    }

    /**
     * @description get the handler for the running job
     * @return   returns the handler for the running batch class
     */
    global Batch_Handler__c getHandler()
    {
        return Batch_Handler__c.getInstance(this.batchHandlerName);
    }

    /**
     * @description get the last time the job ran based on the date in the Job manager
     * @return   datetime of the last time the job ran if null returns yesterday at current time
     */
    global DateTime getLastRun()
    {
        this.handler = this.getHandler();
        this.lastRun = this.handler != null && this.handler.Last_Run__c != null
                ? this.handler.Last_Run__c
                : System.now().addDays(-1);
        System.debug(this.lastRun);
        return this.lastRun;
    }

    /**
     * @description gets the query for the batch job
     * @return   a string for the current query
     */
    global virtual String getQuery()
    {
        return this.query;
    }

}