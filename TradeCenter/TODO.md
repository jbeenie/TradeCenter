## Road Map

1. Create Quest trade API framework

    a. Create HTTPKit Framework for making HTTP Requests (DONE)
        

    b. Create QuestTradeKit framework for making REST API calls to Quest trade (DONE)
        - Store Access token within QuestTrade API object ( get it using the GetAccesTokenAction) (DONE)
        - implement unit test to test getting access token ( not done, doesnt make sense to unit test APIs)


 2. Use NSDate within QuestTradeKit API (done)
 		- use NSDate within account actions (done)


 3. Create QuestTradeAccountAdaptor (adaptor)
 	- conforms to AccountManagerDataSource (done)
 	- has a session  (done)
 	- delegates function calls to session (done)
 	
 	- finish implementing Acticity Factory
 	- finish converting  Execution/Order/Balance/Position

 4. Figure out how to get all activities since the beginning of account 
    - partition date interval (done)
    - send api request for each interval in the partition (done)
        - update the QuestTradeAccountAdaptor to send out querry for each interval (done)
        - wait for all querries to be asnwered and return all the data all at once? (done)
    - aggregate data (done)

 5. Add ability to set time zone via Quest trade API




