# Facebook Connector

The Facebook connector allows you to access the Facebook Graph API through ballerina. And the actions are being invoked
with a ballerina main function. The following section provide you the details on connector operations.

## Create post
The createPost action allows to create a post for user, page, event or group.

###### Properties
  * id    - The identifier of the user or page or event or group for which to create the post.
  * msg   - The main body of the post.
  * link  - The URL of a link to attach to the post.
  * place - Page ID of a location associated with this post.

###### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/page/feed#publish>

## Retrieve a post
The retrievePost action allows to retrieve the post specified by the id.

###### Properties
  * postId - The post ID.
  * fields - The fields to retrieve which belongs to an object.

###### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/post#read>

## Delete a post
The deletePost action allows to delete a post specified by the id.

###### Properties
  * postId - The post ID.

###### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/post#deleting>

## Update a post
The updatePost action allows to update the post specified by the id.

###### Properties
   * postId  - The post ID.
   * msg - The main body of the post.
   * tags    - Comma-separated list of user IDs of people tagged in this post. 
   * privacy - Privacy settings of the post.

###### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/post#updating>

## Add likes
The addLikes action allows to add a like for a video, posts, status, note, photo, album or comment.

###### Properties
  * objectId - The object ID to add like.

###### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/object/likes>

## Get like details
The getLikesDetails action allows to retrieve the like details for a specified object.

###### Properties
   * objectId - The object ID to retrieve the like details.
   * fields   - The fields to retrieve.

###### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/object/likes>

## Delete likes
The deleteLikes action allows to delete a like for a video, posts, status, note, photo, album or comment.

###### Properties
  * objectId - The object ID to delete the like.
  
###### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/object/likes>

## Add comments
The addComments action allows to add new comments for a photo, picture etc.

###### Properties
  * objectId      - The ID of the object such as a page, video, etc.
  * msg       - The comment text.
  * attachmentId  - An ID of an unpublished photo.
  * attachmentUrl - The URL of an image to include as a photo comment.

###### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/object/comments>

## Get comments
The getComments action allows to get comments for an object such as video, posts, status, note, photo, and album.

###### Properties
  * objectId      - The ID of the object such as a page, video, etc.
  * fields   - The fields to retrieve.
  
###### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/object/comments>

## How to use

###### Prerequisites
1.  Get the access_token from <https://developers.facebook.com/tools/explorer/>

**IMPORTANT:** This access token can be used to make API requests on your own account's behalf. Do not share your access token with anyone.

###### Invoke the actions
- Place the faacebook directory into {BALLERINA_HOME}/samples.
- To run the following commands to execute the relevant action.
  1. createPost:   
  `bin$ ./ballerina run ../samples/facebook/src/ClientConnector createPost <token> <message> <link> <place>`
  2. retrievePost:    
  `bin$ ./ballerina run ../samples/facebook/src/ClientConnector retrievePost <token> <postId> <fields>`
  3. deletePost:    
  `bin$ ./ballerina run ../samples/facebook/src/ClientConnector deletePost <token> <postId>`
  4. updatePost:    
  `bin$ ./ballerina run ../samples/facebook/src/ClientConnector updatePost <token> <postId> <message> <tags> <privacy>`
  5. addLikes:    
  `bin$ ./ballerina run ../samples/facebook/src/ClientConnector addLikes <token> <objectId>`
  6. getLikesDetails:    
  `bin$ ./ballerina run ../samples/facebook/src/ClientConnector getLikesDetails <token> <objectId> <fields>`
  7. deleteLikes:    
  `bin$ ./ballerina run ../samples/facebook/src/ClientConnector deleteLikes <token> <objectId> <fields>`
  8. addComments:    
  `bin$ ./ballerina run ../samples/facebook/src/ClientConnector addComments <token> <objectId> <message> <attachmentId> <attachmentUrl>`
  9. getComments:    
  `bin$ ./ballerina run ../samples/facebook/src/ClientConnector getComments <token> <objectId> <fields>`