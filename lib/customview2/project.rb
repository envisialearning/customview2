module Customview2
  class Project
    include Her::Model

    use_api Customview2.api

    collection_path "/api/#{Customview2::API_VERSION}/projects"

    class << self

      def create_campaign(id, params = {})
        post "/api/v1/projects/#{id}/create_campaign", params
      end

      def update_contact_lifetime_value(guid, params = {})
        #post "/api/v1/contacts/#{guid}/update_contact_lifetime_value", params
      end
    end
  end
end