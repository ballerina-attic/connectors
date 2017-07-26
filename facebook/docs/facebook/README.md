# Facebook Connector

The Facebook connector allows you to access the [Facebook Graph API](https://developers.facebook.com/docs/graph-api) through Ballerina. You can invoke this connector's actions within a Ballerina `main()` function. The following sections provide details on the connector actions and the sample you can use to invoke them.

## Create post
The createPost action creates a post for a user, page, event, or group.

#### Properties

  * id    - The identifier of the user, page, event, or group for which you are creating the post
  * msg   - The main body of the post
  * link  - The URL of a link to attach to the post
  * place - Page ID of a location associated with this post

#### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/page/feed#publish>

## Retrieve a post
The retrievePost action retrieves the post specified by the ID.

#### Properties

  * postId - The post ID
  * fields - The fields to retrieve

#### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/post#read>

## Delete a post
The deletePost action deletes the post specified by the ID.

#### Properties

* postId - The post ID

#### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/post#deleting>

## Update a post
The updatePost action updates the post specified by the ID.

#### Properties

* postId  - The post ID
* msg     - The main body of the post
* tags    - Comma-separated list of user IDs of people tagged in this post
* privacy - Privacy settings of the post

#### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/post#updating>

## Add likes
The addLikes action adds a like for a video, post, status, note, photo, album, or comment.

#### Properties

* objectId - The object ID to like

#### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/object/likes>

## Get likes
The getLikesDetails action retrieves details of the likes for a specified object.

#### Properties

 * objectId - The ID of the object whose likes you want to retrieve
 * fields   - The details to retrieve

#### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/object/likes>

## Delete likes
The deleteLikes action deletes a like for a video, post, status, note, photo, album, or comment.

#### Properties

  * objectId - The ID of the object whose like you want to delete.
  
#### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/object/likes>

## Add comments
The addComments action adds new comments for a photo, picture, etc.

#### Properties

  * objectId      - The ID of the object, such as a page, video, etc.
  * msg           - The comment text
  * attachmentId  - An ID of an unpublished photo
  * attachmentUrl - The URL of an image to include as a photo comment

#### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/object/comments>

## Get comments
The getComments action retrieves comments for an object such as a video, post, status, note, photo, or album.

#### Properties

  * objectId - The ID of the object such as a page, video, etc.
  * fields   - The fields to retrieve
  
#### Related Facebook documentation
<https://developers.facebook.com/docs/graph-api/reference/v2.8/object/comments>

## Sample
1. Get the access_token from: <https://developers.facebook.com/tools/explorer/>

 > **IMPORTANT:** This access token can be used to make API requests on your own account's behalf. Do not share your access token with anyone.

1. Copy the `facebook/sample/facebook/samples.bal` file into the `<ballerina_home>/bin` folder. 
1. Run the following commands to execute the relevant actions:
  *  createPost:   
  `bin$ ./ballerina run samples.bal createPost <token> <id> <message> <link> <place>`
  *  retrievePost:    
  `bin$ ./ballerina run samples.bal retrievePost <token> <postId> <fields>`
  * deletePost:    
  `bin$ ./ballerina run samples.bal deletePost <token> <postId>`
  * updatePost:    
  `bin$ ./ballerina run samples.bal updatePost <token> <postId> <message> <tags> <privacy>`
  * addLikes:    
  `bin$ ./ballerina run samples.bal addLikes <token> <objectId>`
  * getLikesDetails:    
  `bin$ ./ballerina run samples.bal getLikesDetails <token> <objectId> <fields>`
  * deleteLikes:    
  `bin$ ./ballerina run samples.bal deleteLikes <token> <objectId>`
  * addComments:    
  `bin$ ./ballerina run samples.bal addComments <token> <objectId> <message> <attachmentId> <attachmentUrl>`
  * getComments:    
  `bin$ ./ballerina run samples.bal getComments <token> <objectId> <fields>`
