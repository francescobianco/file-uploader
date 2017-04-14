# file-uploader
Allows to upload a file and optionally assign a class to it and write meta information about this transaction in the triple store

# exmaple docker-compose.yml set up
```
  uploader:
    image: uploader
    links:
      - db:database
    ports:
      - "5555:80"
    volumes:
      - ./uploads:/data/uploads
    environment:
      FILE_SERVICE_BASE_URI: "http://example.com/files/"
      FILE_SERVICE_FILE_CLASS: "http://file-service.com/File"
      FILE_SERVICE_FILE_NAME: "http://file.com/filename"
      FILE_SERVICE_FILE_STATUS: "http://file.com/status"
```
