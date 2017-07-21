# Gmail Connector

The Gmail connector allows you to access the [Gmail REST API](https://developers.google.com/gmail/api/) through Ballerina. 
You can invoke this connector's actions within a Ballerina `main()` function. The following sections provide details on 
the connector actions and the sample you can use to invoke them.

## getUserProfile
The getUserProfile action helps to Get the current user's Gmail profile.

#### Related Gmail documentation
[getUserProfile](https://developers.google.com/gmail/api/v1/reference/users/getProfile)

## createDraft
The createDraft action helps to Creates a new draft with the DRAFT label.

#### Properties
* createDraft - It is a struct. Which contains all optional parameters (to,subject,from,messageBody,cc,bcc,id,threadId) to create draft message.
    
    Description for struct parameters,
    * to (Optional)- Receiver mail ID
    * subject (Optional)- Subject of the message
    * from (Optional)- Sender mail ID
    * messageBody (Optional)- Entire message body
    * cc (Optional)- To whom sender need to cc the mail
    * bcc (Optional)- To whom sender need to bcc the mail
    * id (Optional)- Id of the draft to create
    * threadId (Optional)- thread Id of the draft to reply

#### Related Gmail documentation
[createDraft](https://developers.google.com/gmail/api/v1/reference/users/drafts/create)

## updateDraft
The updateDraft action helps to Replaces a draft's content.

#### Properties

* draftId (Mandatory) - The ID of the draft to update
* updateDraft - It is a struct. Which contains all optional parameters (to,subject,from,messageBody,cc,bcc,id,threadId) to update draft.
    
    Description for struct parameters,
    * to (Optional)- Receiver mail ID
    * subject (Optional)- Subject of the message
    * from (Optional)- Sender mail ID
    * messageBody (Optional)- Entire message body
    * cc (Optional)- To whom sender need to cc the mail
    * bcc (Optional)- To whom sender need to bcc the mail
    * id (Optional)- Id of the draft to update
    * threadId (Optional)- thread Id of the draft to reply

#### Related Gmail documentation
[updateDraft](https://developers.google.com/gmail/api/v1/reference/users/drafts/update)

## readDraft
The readDraft action helps to Gets the specified draft.

#### Properties

* draftId (Mandatory)- The ID of the draft to retrieve
* readDraft - It is a struct. Which contains all optional parameters (format) to read draft.

    Description for struct parameters,
        * format (Optional)- The format to return the draft in

#### Related Gmail documentation
[readDraft](https://developers.google.com/gmail/api/v1/reference/users/drafts/get)

## listDrafts
The listDrafts action helps to Lists the drafts in the user's mailbox.

#### Properties
* listDrafts - It is a struct. Which contains all optional parameters (includeSpamTrash,maxResults,pageToken,q) to list drafts.

    Description for struct parameters,
    * includeSpamTrash (Optional)- Include messages from SPAM and TRASH in the results
    * maxResults (Optional)- Maximum number of messages to return
    * pageToken (Optional)- Page token to retrieve a specific page of results in the list
    * q (Optional)- Only return messages matching the specified query. Supports the same query format as the Gmail search box

#### Related Gmail documentation
[listDrafts](https://developers.google.com/gmail/api/v1/reference/users/drafts/list)

## deleteDraft
The deleteDraft action helps to Immediately and permanently deletes the specified draft. Does not simply trash it.

#### Properties

* draftId (Mandatory)- The ID of the draft to delete

#### Related Gmail documentation
[deleteDraft](https://developers.google.com/gmail/api/v1/reference/users/drafts/delete)

## listHistory
The listHistory action helps Lists the history to of all changes to the given mailbox. History results are returned in chronological order (increasing historyId)

#### Properties
* startHistoryId - Returns history records after the specified startHistoryId.
* listHistory - It is a struct. Which contains all optional parameters (labelId,maxResults,pageToken) to list history.

    Description for struct parameters,
    * labelId (Optional)- Only return messages with a label matching the ID
    * maxResults (Optional)- The maximum number of history records to return
    * pageToken (Optional)- Page token to retrieve a specific page of results in the list
    * startHistoryId (Optional)- Returns history records after the specified startHistoryId

#### Related Gmail documentation
[listHistory](https://developers.google.com/gmail/api/v1/reference/users/history/list)

## createLabel
The createLabel action helps to Creates a new label.

#### Properties

* labelName (Mandatory)- The display name of the label
* messageListVisibility (Mandatory)- The visibility of messages with this label in the message list in the Gmail web interface
* labelListVisibility (Mandatory)- The visibility of the label in the label list in the Gmail web interface
* createLabel - It is a struct. Which contains all optional parameters (types,messagesTotal,messagesUnread,threadsTotal,threadsUnread)

    Description for struct parameters,
    * types (Optional)- The owner type for the label
    * messagesTotal (Optional)- The total number of messages with the label
    * messagesUnread (Optional)- The number of unread messages with the label
    * threadsTotal (Optional)- The total number of threads with the label
    * threadsUnread (Optional)- The number of unread threads with the label

#### Related Gmail documentation
[createLabel](https://developers.google.com/gmail/api/v1/reference/users/labels/create)

## deleteLabel
The deleteLabel action helps to Immediately and permanently deletes the specified label and removes it from any messages and threads that it is applied to.

#### Properties

* labelId (Mandatory)- The ID of the label to delete

#### Related Gmail documentation
[deleteLabel](https://developers.google.com/gmail/api/v1/reference/users/labels/delete)

## listLabels
The listLabels action helps to Lists all labels in the user's mailbox.

#### Related Gmail documentation
[listLabels](https://developers.google.com/gmail/api/v1/reference/users/labels/list)

## updateLabel
The updateLabel action helps to Updates the specified label.

#### Properties

* labelId (Mandatory)- The ID of the label to update
* labelName (Mandatory)- The display name of the label
* messageListVisibility (Mandatory)- The visibility of messages with this label in the message list in the Gmail web interface.
* labelListVisibility (Mandatory)- The visibility of the label in the label list in the Gmail web interface.
* updateLabel - It is a struct. Which contains all optional parameters (types,messagesTotal,messagesUnread,threadsUnread).

    Description for struct parameters,
    * types (Optional)- The owner type for the label
    * messagesTotal (Optional)- The total number of messages with the label
    * messagesUnread (Optional)- The number of unread messages with the label
    * threadsTotal (Optional)- The total number of threads with the label
    * threadsUnread (Optional)- The number of unread threads with the label

#### Related Gmail documentation
[updateLabel](https://developers.google.com/gmail/api/v1/reference/users/labels/update)

## readLabel
The readLabel action helps to Gets the specified label.

#### Properties

* labelId (Mandatory)- The ID of the label to retrieve

#### Related Gmail documentation
[readLabel](https://developers.google.com/gmail/api/v1/reference/users/labels/get)

## readThread
The readThread action helps to Gets the specified thread.

#### Properties

* threadId (Mandatory)- The ID of the thread to retrieve
* readThread - It is a struct. Which contains all optional parameters (format,metaDataHeaders).

    Description for struct parameters,
    * format (Optional)- The format to return the thread in
    * metaDataHeaders (Optional)- When given and format is METADATA, only include headers specified

#### Related Gmail documentation
[readThread](https://developers.google.com/gmail/api/v1/reference/users/threads/get)

## listThreads
The listThreads action helps to Lists the threads in the user's mailbox.

#### Properties

* listThreads - It is a struct. Which contains all optional parameters (includeSpamTrash,labelIds,maxResults,pageToken,q).

    Description for struct parameters,
    * labelIds (Optional)- Only return messages with labels that match all of the specified label IDs
    * includeSpamTrash (Optional)- Include messages from SPAM and TRASH in the results
    * maxResults (Optional)- Maximum number of messages to return
    * pageToken (Optional)- Page token to retrieve a specific page of results in the list
    * q (Optional)- Only return messages matching the specified query. Supports the same query format as the Gmail search box

#### Related Gmail documentation
[listThreads](https://developers.google.com/gmail/api/v1/reference/users/threads/list)

## deleteThread
The deleteThread action helps to Immediately and permanently deletes the specified thread. This operation cannot be undone. Prefer threads.trash instead.

#### Properties

* threadId (Mandatory)- The ID of the thread to delete

#### Related Gmail documentation
[deleteThread](https://developers.google.com/gmail/api/v1/reference/users/threads/delete)

## trashThread
The trashThread action helps to Moves the specified thread to the trash.

#### Properties

* threadId (Mandatory)- The ID of the thread to Trash

#### Related Gmail documentation
[trashThread](https://developers.google.com/gmail/api/v1/reference/users/threads/trash)

## unTrashThread
The unTrashThread action helps to Removes the specified thread from the trash.

#### Properties

* threadId (Mandatory)- The ID of the thread to unTrash

#### Related Gmail documentation
[unTrashThread](https://developers.google.com/gmail/api/v1/reference/users/threads/untrash)

## listMails
The listMails action helps to Lists the messages in the user's mailbox.

#### Properties

* listMails - It is a struct. Which contains all optional parameters (includeSpamTrash,labelIds,maxResults,pageToken,q).

    Description for struct parameters,
    * labelIds (Optional)- Only return messages with labels that match all of the specified label IDs
    * includeSpamTrash (Optional)- Include messages from SPAM and TRASH in the results
    * maxResults (Optional)- Maximum number of messages to return
    * pageToken (Optional)- Page token to retrieve a specific page of results in the list
    * q (Optional)- Only return messages matching the specified query. Supports the same query format as the Gmail search box

#### Related Gmail documentation
[listMails](https://developers.google.com/gmail/api/v1/reference/users/messages/list)

## sendMail
The sendMail action helps to Sends the specified message to the recipients.

#### Properties

* sendMail - It is a struct. Which contains all optional parameters (to,subject,from,messageBody,cc,bcc,id,threadId).

    Description for struct parameters,
    * to (Optional)- Receiver mail ID
    * subject (Optional)- Subject of the message
    * from (Optional)- Sender mail ID
    * messageBody (Optional)- Entire message body
    * cc (Optional)- To whom sender need to cc the mail
    * bcc (Optional)- To whom sender need to bcc the mail
    * id (Optional)- Id of the message to reply
    * threadId (Optional)- To whom sender need to bcc the mail

#### Related Gmail documentation
[sendMail](https://developers.google.com/gmail/api/v1/reference/users/messages/send)

## modifyExistingMessage
The modifyExistingMessage action helps to Modifies the labels on the specified message.

#### Properties

* messageId (Mandatory)- The ID of the message to modifies the labels
* addLabelIds (Mandatory)- A list of IDs of labels to add to this message
* removeLabelIds (Mandatory)- A list IDs of labels to remove from this message

#### Related Gmail documentation
[modifyExistingMessage](https://developers.google.com/gmail/api/v1/reference/users/messages/modify)

## readMail
The readMail action helps to Gets the specified message.

#### Properties
* messageId - Id of the message to retrieve.
* readMail - It is a struct. Which contains all optional parameters (format,metaDataHeaders).

    Description for struct parameters,
    * messageId (Optional)- The ID of the message to retrieve
    * format (Optional)- The format to return the message in
    * metaDataHeaders (Optional) - When given and format is METADATA, only include headers specified.

#### Related Gmail documentation
[readMail](https://developers.google.com/gmail/api/v1/reference/users/messages/get)

## deleteMail
The deleteMail action helps to Immediately and permanently deletes the specified message. This operation cannot be undone. Prefer messages.trash instead.

#### Properties

* messageId (Mandatory)- The ID of the message to delete

#### Related Gmail documentation
[deleteMail](https://developers.google.com/gmail/api/v1/reference/users/messages/delete)

## trashMail
The trashMail action helps to Moves the specified message to the trash.

#### Properties

* messageId (Mandatory)- The ID of the message to trash

#### Related Gmail documentation
[trashMail](https://developers.google.com/gmail/api/v1/reference/users/messages/trash)

## unTrashMail
The unTrashMail action helps to Removes the specified message from the trash.

#### Properties

* messageId (Mandatory)- The ID of the message to unTrash

#### Related Gmail documentation
[unTrashMail](https://developers.google.com/gmail/api/v1/reference/users/messages/untrash)


## How to use

#### Prerequisites

1. Obtain the following parameters

* Client Id
* Client Secret
* Redirect URI
* Access Token
* Refresh Token

2. Follow the below steps to obtain the above credentials to use the Gmail connector:
     ##### Creating a Client ID and Client Secret   
        1. As the email sender, navigate to the URL https://console.developers.google.com/projectselector/apis/credentials 
           and log in to your google account.
        2. If you do not already have a project, create a new project and navigate to Create Credential -> OAuth client ID.
        3. At this point, if the consent screen name is not provided, you will be prompted to do so.
        4. Select the Web Application option and create a client. Provide  https://developers.google.com/oauthplayground 
           as the redirect URL under Authorized redirect URIs and click on Create. The client ID and client secret will 
           then be displayed.
        5. See Gmail API documentation https://developers.google.com/gmail/api/auth/web-server for details on creating 
           the Client ID and Client Secret.
        6. Click on the Library on the side menu, and select Gmail API. Click enable.
        
     ##### Obtaining the Access Token and Refresh Token
       Follow these steps to automatically refresh the expired token when connecting to Google API:
        1. Navigate to the URL https://developers.google.com/oauthplayground and click on the gear wheel at the top right 
           corner of the screen and select the option Use your own OAuth credentials. Provide the client ID and client secret 
           you previously created and click on Close.
        2. Now under Step 1, select Gmail API from the list of APIs and check all the scopes listed down and click on 
           Authorize APIs. You will then be prompted to allow permission, click on Allow.
        3. In Step 2, click on Exchange authorization code for tokens to generate and display the access token and refresh token.
        
        
>**IMPORTANT** This access token and refresh token can be used to make API requests on your own account's behalf. Do not share your access token, client  secret with anyone.

3. copy gmail/sample/gmail/samples.bal into `<ballerina_home>`/bin$ folder

4. Run the following commands to execute the relevant actions:

>**NOTE** If the template parameter is indicate as optional you must pass null as default value to run this action.

* getUserProfile  
`bin$ ./ballerina run main samples.bal getUserProfile <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional>`
* createDraft  
`bin$ ./ballerina run main samples.bal createDraft  <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional>`
* updateDraft  
`bin$ ./ballerina run main samples.bal updateDraft <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <draftId:Required>`
* readDraft  
`bin$ ./ballerina run main samples.bal readDraft <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <draftId:-Required>`
* listDrafts  
`bin$ ./ballerina run main samples.bal listDrafts <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional>`
* deleteDraft  
`bin$ ./ballerina run main samples.bal deleteDraft <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <draftId:-Required>`
* listHistory  
`bin$ ./ballerina run main samples.bal listHistory <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <startHistoryId:-Required>`
* createLabel  
`bin$ ./ballerina run main samples.bal createLabel <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <labelName:-Required> <messageListVisibility:-Required> <labelListVisibility:-Required>`
* deleteLabel  
`bin$ ./ballerina run main samples.bal deleteLabel <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <labelId:-Required>`
* listLabels  
`bin$ ./ballerina run main samples.bal listLabels <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional>`
* updateLabel  
`bin$ ./ballerina run main samples.bal updateLabel <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <labelId:-Required> <labelName:-Required> <messageListVisibility:-Required> <labelListVisibility:-Required>`
* readLabel  
`bin$ ./ballerina run main samples.bal readLabel <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <labelId:-Required>`
* readThread  
`bin$ ./ballerina run main samples.bal readThread <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <threadId:-Required>`
* listThreads  
`bin$ ./ballerina run main samples.bal listThreads <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional>`
* deleteThread  
`bin$ ./ballerina run main samples.bal deleteThread <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <threadId:-Required>`
* trashThread  
`bin$ ./ballerina run main samples.bal trashThread <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <threadId:-Required>`
* unTrashThread  
`bin$ ./ballerina run main samples.bal unTrashThread <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <threadId:-Required>`
* listMails  
`bin$ ./ballerina run main samples.bal listMails <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional>`
* sendMail  
`bin$ ./ballerina run main samples.bal sendMail <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional>`
* modifyExistingMessage  
`bin$ ./ballerina run main samples.bal modifyExistingMessage <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <messageId:-Required> <addLabelIds:-Either addLabelIds or removeLabelIds is required> <removeLabelIds:- Either addLabelIds or removeLabelIds is required>`
* readMail  
`bin$ ./ballerina run main samples.bal readMail <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <messageId:-Required>`
* deleteMail  
`bin$ ./ballerina run main samples.bal deleteMail <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <messageId:-Required>`
* trashMail  
`bin$ ./ballerina run main samples.bal trashMail <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <messageId:-Required>`
* unTrashMail  
`bin$ ./ballerina run main samples.bal unTrashMail <userId:-Required> <accessToken:-Required> <refreshToken:-Optional> <clientId:-Optional> <clientSecret:-Optional> <messageId:-Required>`