FROM semtech/mu-ruby-template:2.4.0-ruby2.3

MAINTAINER Jonathan Langens <jonathan.langens@tenforce.com>

ENV FILE_SERVICE_BASE_URI "http://mu.semte.ch/vocabularies/file-service/files/"

ENV FILE_SERVICE_FILE_CLASS "http://mu.semte.ch/vocabularies/file-service/File"

ENV FILE_SERVICE_FILE_NAME "http://mu.semte.ch/vocabularies/file-service/filename"

ENV FILE_SERVICE_ORIGINAL_FILE_NAME "http://mu.semte.ch/vocabularies/file-service/originalFilename"

ENV FILE_SERVICE_UPLOADED_AT "http://mu.semte.ch/vocabularies/file-service/uploadedAt"

ENV FILE_SERVICE_FILE_STATUS "http://mu.semte.ch/vocabularies/file-service/status"

