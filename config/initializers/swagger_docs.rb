Swagger::Docs::Config.register_apis({
  "1.0" => {
    :api_extension_type => :json,
    :api_file_path => "public/",
    :base_path => "http://slamapi.herokuapp.com",
    :clean_directory => false,
    :attributes => {
      :info => {
        "title" => "Slam API",
        "description" => "Waitlist app for table-tennis room",
        "termsOfServiceUrl" => "http://slamapi.herokuapp.com/terms/",
        "contact" => "emeyer@8thlight.com",
        "license" => "Apache 2.0",
        "licenseUrl" => "http://www.apache.org/licenses/LICENSE-2.0.html"
      }
    }
  }
})
