## Road Map

1. Create Quest trade API framework

    a. Create HTTPKit Framework for making HTTP Requests (DONE)
        

    b. Create QuestTradeKit framework for making REST API calls to Quest trade (DONE)
        - Store Access token within QuestTrade API object ( get it using the GetAccesTokenAction) (DONE)
        - implement unit test to test getting access token ( not done, doesnt make sense to unit test APIs)


 2. Use NSDate within QuestTradeKit API (done)
 		- use NSDate within account actions (done)


 3. Create QuestTradeAccountAdaptor (adaptor)
 	- conforms to AccountManagerDataSource, s
 	- has a session manager 
 	- delegates function calls to session of session manager
 	- do conversion inside this class

 4. Add ability to set time zone via Quest trade API

