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

    end
  end
end