Description
===========
This is the gmail connector with the following actions. And the action is being invoked in a ballerina main function.

Prerequisites
=============
1. Create a project and create an app for this project by visiting https://console.developers.google.com/
2. Obtain the following parameters
    * Client Id
    * Client Secret
    * Redirect URI
    * Access Token
    * Refresh Token

IMPORTANT: This access token and refresh token can be used to make API requests on your own account's behalf. Do not share your access token, client  secret with anyone.


How to run this connector actions
=================================

Place the gmailConnector into {BALLERINA_HOME}/samples.

To run the actions of the Gmail connector run the below command for each actions.

NOTE
====

If the template parameter is indicate as optional you must pass null as default value to run this action.

1. getUserProfile

bin$ ./ballerina run ../samples/gmailConnector/gmailConnector.bal getUserProfile <userId:-Required> <accessToken:-Required>

2. createDraft

bin$ ./ballerina run ../samples/gmailConnector/gmailConnector.bal createDraft <userId:-Required> <accessToken:-Required> <to:-Optional> <subject:-Optional> <from:-Optional> <"messageBody":-Optional> <cc:-Optional> <bcc:-Optional> <id:-Optional> <threadId:-Optional>

3. updateDraft

./ballerina run ../samples/gmailConnector/gmailConnector.bal updateDraft <userId:-Required> <accessToken:-Required> <draftId:Required> <to:-Optional> <subject:-Optional> <from:-Optional> <"messageBody":-Optional> <cc:-Optional> <bcc:-Optional> <id:-Optional> <threadId:-Optional>

4. readDraft

./ballerina run ../samples/gmailConnector/gmailConnector.bal readDraft <userId:-Required> <accessToken:-Required> <draftId:-Required> <format:-Optional but default "null">

5. listDrafts

./ballerina run ../samples/gmailConnector/gmailConnector.bal listDrafts <userId:-Required> <accessToken:-Required> <includeSpamTrash> <maxResults> <pageToken> <q>

6. deleteDraft

./ballerina run ../samples/gmailConnector/gmailConnector.bal deleteDraft <userId:-Required> <accessToken:-Required> <draftId:-Required>

7. listHistory

./ballerina run ../samples/gmailConnector/gmailConnector.bal listHistory <userId:-Required> <accessToken:-Required> <labelId:-Optional but default "null"> <maxResults:-Optional but default null> <pageToken:-Optional but default null> <startHistoryId:-Required>

8. createLabel

./ballerina run ../samples/gmailConnector/gmailConnector.bal createLabel <userId:-Required> <accessToken:-Required> <labelName:-Required> <messageListVisibility:-Required> <labelListVisibility:-Required> <types:-Optional but default null> <messagesTotal:-Optional but default null> <messagesUnread:-Optional but default null> <threadsTotal:-Optional but default null> <threadsUnread:-Optional but default null>

9. deleteLabel

./ballerina run ../samples/gmailConnector/gmailConnector.bal deleteLabel <userId:-Required> <accessToken:-Required> <labelId:-Required>

10. listLabels

./ballerina run ../samples/gmailConnector/gmailConnector.bal listLabels <userId:-Required> <accessToken:-Required>

11. updateLabel

./ballerina run ../samples/gmailConnector/gmailConnector.bal updateLabel <userId:-Required> <accessToken:-Required> <labelId:-Required> <labelName:-Required> <messageListVisibility:-Required> <labelListVisibility:-Required> <types:-Optional but default null> <messagesTotal:-Optional but default null> <messagesUnread:-Optional but default null> <threadsTotal:-Optional but default null> <threadsUnread:-Optional but default null>

12. readLabel

./ballerina run ../samples/gmailConnector/gmailConnector.bal readLabel <userId:-Required> <accessToken:-Required> <labelId:-Required>

13. readThread

./ballerina run ../samples/gmailConnector/gmailConnector.bal readThread <userId:-Required> <accessToken:-Required> <threadId:-Required> <format> <metaDataHeaders>

14. listThreads

./ballerina run ../samples/gmailConnector/gmailConnector.bal listThreads <userId:-Required> <accessToken:-Required> <includeSpamTrash> <labelIds> <maxResults> <pageToken> <q>

15. deleteThread

./ballerina run ../samples/gmailConnector/gmailConnector.bal deleteThread <userId:-Required> <accessToken:-Required> <threadId:-Required>

16. trashThread

./ballerina run ../samples/gmailConnector/gmailConnector.bal trashThread <userId:-Required> <accessToken:-Required> <threadId:-Required>

17. unTrashThread

./ballerina run ../samples/gmailConnector/gmailConnector.bal unTrashThread <userId:-Required> <accessToken:-Required> <threadId:-Required>

18. listMails

./ballerina run ../samples/gmailConnector/gmailConnector.bal listMails <userId:-Required> <accessToken:-Required> <includeSpamTrash> <labelIds> <maxResults> <pageToken> <q>

19. sendMail

./ballerina run ../samples/gmailConnector/gmailConnector.bal sendMail <userId:-Required> <accessToken:-Required> <to:-Optional> <subject:-Optional> <from:-Optional> <"messageBody":-Optional> <cc:-Optional> <bcc:-Optional> <id:-Optional> <threadId:-Optional>

20. readMail

./ballerina run ../samples/gmailConnector/gmailConnector.bal readMail <userId:-Required> <accessToken:-Required> <messageId:-Required> <format> <metaDataHeaders>

21. deleteMail

./ballerina run ../samples/gmailConnector/gmailConnector.bal deleteMail <userId:-Required> <accessToken:-Required> <messageId:-Required>

22. trashMail

./ballerina run ../samples/gmailConnector/gmailConnector.bal trashMail <userId:-Required> <accessToken:-Required> <messageId:-Required>

23. unTrashMail

./ballerina run ../samples/gmailConnector/gmailConnector.bal unTrashMail <userId:-Required> <accessToken:-Required> <messageId:-Required>
