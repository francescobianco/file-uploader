post "/upload" do
  file_uuid = generate_uuid()

  file_name = "/data/uploads" + file_uuid

  temp_file = File.open(params['file'][:tempfile], "r") do |f|
    File.new(file_name, "w")
    File.open(file_name, "w") do |c|
      c.write(f.read())
    end
  end

  file_uuid = generate_uuid()

  file_uri = ENV['FILE_SERVICE_BASE_URI'] + "/" + file_uuid

  query = "WITH <" + ENV['MU_APPLICATION_GRAPH'] + "> INSERT DATA {\n"

  query += "<" + file_uri + "> a <" + ENV['FILE_SERVICE_FILE_CLASS'] + ">;\n"

  query += "<#{MU_CORE}/uuid> \"" + file_uuid + "\";\n"

  query += "<" + ENV['FILE_SERVICE_FILE_NAME'] + "> \"" + file_name + "\" ;\n"

  query += "<" + ENV['FILE_SERVICE_FILE_STATUS'] + "> \"uploaded\" .\n"

  query += "}"

  update(query)

  "OK"
  
end
