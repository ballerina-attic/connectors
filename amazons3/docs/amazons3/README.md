# Amazon S3 Connector
  The Amazon S3 connector allows you to access the Amazon S3 REST API through ballerina. And the actions are being invoked
  with a ballerina main function. The following section provide you the details on connector operations.

## Get list of Buckets
  This amazon S3 action  returns a list of all buckets owned by the authenticated sender of the request.

###### Properties

###### Related Amazon S3 documentation
  * <http://docs.aws.amazon.com/AmazonS3/latest/API/RESTServiceGET.html>

## Get list of Objects
 This amazon S3 action returns some or all (up to 1,000) of the objects in a bucket.

###### Properties
  * bucketName - The relevant Bucket name

###### Related Amazon S3 documentation
  * <http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGET.html>

## Create Bucket
  This amazon S3 action creates a new bucket.

###### Properties
  * bucketName - The relevant Bucket name

###### Related Amazon S3 documentation
  * <http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUT.html>

## Delete Bucket
 This amazon S3 action deletes the bucket named in the URI.

###### Properties
  * bucketName - The relevant Bucket name

###### Related Amazon S3 documentation
  * <http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketDELETE.html>

## Get Object
  This amazon S3 action retrieves object from Amazon S3.

###### Properties
  * bucketName - The relevant Bucket name
  * objectName - The relevant Object name

###### Related Amazon S3 documentation
  * <http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectGET.html>

## Delete Object
  This amazon S3 action deletes object from Amazon S3.

###### Properties
  * bucketName - The relevant Bucket name
  * objectName - The relevant Object name

###### Related Amazon S3 documentation
  * <http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectDELETE.html>

## Put Object
  This amazon S3 action adds an object to a bucket.

###### Properties
  * bucketName - The relevant Bucket name
  * objectName - The relevant Object name
  * payload - The file that needed to be added to the bucket

###### Related Amazon S3 documentation
  * <http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectPUT.html>


## How to use

###### Prerequisites
 1. Create a amazon lambda account by visiting <https://aws.amazon.com/s3/>
 2. Obtain the following parameters
   * Access key ID.
   * Secret access key.
   * Server region.

###### Run the Sample
- copy amazons3/sample/amazons3/samples.bal into <ballerina_home>/bin$ folder
- Run the following commands to execute the relevant action.
  1. get bucket list:
  `bin$ ./ballerina run samples.bal getBucketList <accessKeyId> <secretAccessKey> <region>`
  2. get object list:
  `bin$ ./ballerina run samples.bal getObjectList <accessKeyId> <secretAccessKey> <region> <bucketName>`
  3. create bucket:
  `bin$ ./ballerina run samples.bal createBucket <accessKeyId> <secretAccessKey> <region> <bucketName>`
  4. delete bucket:
  `bin$ ./ballerina run samples.bal deleteBucket <accessKeyId> <secretAccessKey> <region> <bucketName>`
  5. get object:
  `bin$ ./ballerina run samples.bal getObject <accessKeyId> <secretAccessKey> <region> <bucketName>`
  6. delete object:
  `bin$ ./ballerina run samples.bal deleteObject <accessKeyId> <secretAccessKey> <region> <bucketName>`
  7. put object:
  `bin$ ./ballerina run samples.bal putObject <accessKeyId> <secretAccessKey> <region> <bucketName>`
