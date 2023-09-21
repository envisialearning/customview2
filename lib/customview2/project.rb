module Customview2
  class Project
    include Her::Model

    use_api Customview2.api

    collection_path "/api/#{Customview2::API_VERSION}/projects"

    class << self

      def create_campaign(id, params = {})
        post "/api/v1/projects/#{id}/create_campaign", params
      end

      #needs campaign guid, lists all assessments
      def get_assessments(id, params = {})
        get "/api/v1/projects/#{id}/participants", params
      end

      def create_participant(id, params = {})
        post "/api/v1/projects/#{id}/participants", params
      end

      def update_participant(id, params = {})
        post "/api/v1/projects/#{id}/participants/update/#{params[:guid]}", params[:participant]
      end

      def assessment_status(id, params = {})
        get "/api/v1/projects/#{id}/participants/status/#{params[:guid]}", params
      end

      def get_report_data(id, params = {})
        get "/api/v1/projects/#{id}/participants/report_data/#{params[:guid]}", params
      end

      #
      def generate_otp(id, params = {})
        get "/api/v1/projects/#{id}/participants/authorize/#{params[:guid]}", params
      end

      def get_status(id, params = {})
        post "/api/v2/projects/#{id}/status", params
      end

      #using V2
      def get_clients()
        get "/api/v2/clients"
      end

      def get_campaigns(client_id)
        get "/api/v2/projects/list", {client_id: client_id}
      end

      #needs campaign guid, lists all assessments/participants with flags for invoicing
      def get_participants(id, params = {})
        get "/api/v2/projects/#{id}/participants", params
      end

      #needs campaign guid, lists all assessments/participants with flags for invoicing
      def get_assessment_status(id, params = {})
        get "/api/v2/projects/#{id}/participants/status/#{params[:guid]}", params
      end

      def get_report_scores(id, params = {})
        get "/api/v2/projects/#{id}/participants/report_scores/#{params[:guid]}", params
      end

      def get_project_demographics(id, params = {})
        get "/api/v2/projects/#{id}/demographics", params
      end

      def get_demographics(id, params = {})
        get "/api/v2/projects/#{id}/participants/demographics/#{params[:guid]}", params
      end

      #needs campaign guid, lists all reports with links, or you can pass a report_guid to get the link
      def get_report_links(id, params = {})
        use_api Customview2.api
        get "/api/v2/projects/#{id}/participants/report_links/#{params[:guid]}", params
      end

      #needs campaign guid, lists all reports with links, or you can pass a report_guid to get the link
      def get_assessment_links(id, params = {})
        use_api Customview2.api
        get "/api/v2/projects/#{id}/participants/assessment_links/#{params[:guid]}", params
      end

    end
  end
end