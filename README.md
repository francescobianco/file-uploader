# file-uploader
Allows to upload a file and optionally assign a class to it and write meta information about this transaction in the triple store

# Adding to docker compose
To add the file uploader service with all default settings to your mu.semte.ch project add the following snippet to your docker-compose.yml file:
```
	uploader: flowofcontrol/file-uploader
	links:
	  - db:database
	volumes:
	  - ./uploads:/files
```

# Options
This micro-service was extended from the mu-ruby-template so all options offered by the template are offered by this micro-service.

In addtion to those you can also set The following variables:
* FILE_SERVICE_BASE_URI: the uri that will be used to create file URI's from
* FILE_SERVICE_FILE_CLASS: the URI that corresponds to the class you want a file to have
* FILE_SERVICE_FILE_NAME: the predicate (URI) that binds a file to it's file name (this will be the name this file hase in /files and as such will be generated)
* FILE_SERVICE_ORIGINAL_FILE_NAME: the predicate (URI) for the original (uploaded) file name
* FILE_SERVICE_UPLOADED_AT: the predicate (URI) that connects the file to the upload date
* FILE_SERVICE_FILE_STATUS: the predicate (URI) for the file status


# exmaple of a docker-compose.yml set up
This set up shows the file uploader service with all variables set and the upload service connected to the delta-service
```
  uploader:
    image: flowofcontrol/file-uploader
    links:
      - delta:database
    volumes:
      - ./uploads:/files
    environment:
      FILE_SERVICE_BASE_URI: "http://example.com/files/"
      FILE_SERVICE_FILE_CLASS: "http://file-service.com/File"
      FILE_SERVICE_FILE_NAME: "http://file.com/filename"
      FILE_SERVICE_ORIGINAL_FILE_NAME: "http://file.com/originalFilename"
      FILE_SERVICE_UPLOADED_AT: "http://file.com/uploadedAt"
      FILE_SERVICE_FILE_STATUS: "http://file.com/status"
```
