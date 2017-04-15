post "/files" do
  file_uuid = generate_uuid()
  file_name = "/files/" + file_uuid
  original_file_name = params['file'][:filename]
  uploaded_at = Time.now.to_s
  status = "uploaded"

  copy_file_from_to(params['file'][:tempfile], file_name)

  store_file_object_in_triple_store(file_uuid, file_name, original_file_name, uploaded_at, status)
  
  generate_JSON_API(file_uuid, file_name, original_file_name, uploaded_at, status)
end


# copies a file object to the destination path
def copy_file_from_to(original_file, destination)
  temp_file = File.open(original_file, "r") do |f|
    File.new(destination, "w")
    File.open(destination, "w") do |c|
      c.write(f.read())
    end
  end
end

# stores the information about the file in the triple store
def store_file_object_in_triple_store(file_uuid, file_name, original_file_name, uploaded_at, status)
  update(generate_query(file_uuid, file_name, original_file_name, uploaded_at, status))
end

# generates a query to persist the file informatino in the triple store
def generate_query(file_uuid, file_name, original_file_name, uploaded_at, status)
  file_uri = ENV['FILE_SERVICE_BASE_URI'] + "/" + file_uuid

  query = "WITH <" + ENV['MU_APPLICATION_GRAPH'] + "> INSERT DATA {"

  query += "<" + file_uri + "> a <" + ENV['FILE_SERVICE_FILE_CLASS'] + ">;"

  query += "<#{MU_CORE}/uuid> \"" + file_uuid + "\";"

  query += "<" + ENV['FILE_SERVICE_FILE_NAME'] + "> \"" + file_name + "\" ;"

  query += "<" + ENV['FILE_SERVICE_ORIGINAL_FILE_NAME'] + "> \"" + original_file_name + "\" ;"

  query += "<" + ENV['FILE_SERVICE_UPLOADED_AT'] + "> \"" + uploaded_at + "\" ;"

  query += "<" + ENV['FILE_SERVICE_FILE_STATUS'] + "> \"" + status + "\" ."

  query += "}"
end

# generates a JSON API representation of the created resource
def generate_JSON_API(file_uuid, file_name, original_file_name, uploaded_at, status)
  JSON.generate({:data =>
                 {
                   :type => "file",
                   :id => file_uuid,
                   :attributes =>
                   {
                     :original_file_name => original_file_name,
                     :uploaded_at => uploaded_at,
                     :status => status,
                   }
                 }
                })
end
