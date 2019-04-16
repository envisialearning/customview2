module Customview2
  class Project
    include Her::Model

    use_api Customview2.api

    collection_path "/api/#{Customview2::API_VERSION}/projects"
  end
end