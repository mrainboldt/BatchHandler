# BatchHandler
A way to let Admins manage their batch classes.

## A few notes...
### How to call a class implementing BatchHandler
If you want to call a batch class that implements this handler just call it like a normal batch class.
Database.executeBatch(new SampleBatchClass());

### For scheduling a batch class...
Option 1: you can schedule the class programatically
Option 2: implement Schedulable directly on your batch class and then it will appear for selection in the setup menu
