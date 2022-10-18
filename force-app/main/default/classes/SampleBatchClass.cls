/**
 * @description an example of how to implement the BatchHandler
 */
global class SampleBatchClass extends BatchHandler
{

	
	global SampleBatchClass() 
	{
		//name of the batch handler custom setting record
		//usually aligns to the name batch class;
		this.batchHandlerName = 'SampleBatchClass';
	}

	global override String getQuery()
	{
		return 'SELECT Id'
				+ ' FROM SObject';
	}

   	override global void execute(Database.BatchableContext BC, List<SObject> scope) 
	{	
		//batch class logic
	}
	
}