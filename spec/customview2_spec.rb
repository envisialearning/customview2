RSpec.describe Customview2 do
  it "has a version number" do
    expect(Customview2::VERSION).not_to be nil
  end

  it "does something useful" do
    require 'yaml'

    # Load required values on spec/support/application.yml
    YAML.load_file(File.expand_path(File.dirname(__FILE__))+'/support/application.yml').each do |key, value|
      stub_const('ENV', ENV.to_hash.merge({ "#{key}" => "#{value}" }))
    end

    # Customview2.config do |c|
    #   c.host = ENV["TEST_URL"]
    # end

    r = Customview2.connect(email: ENV["TEST_EMAIL"], api_key: ENV['TEST_API_KEY'], url: ENV["TEST_URL"])
        
    expect(Customview2.jwt).not_to be_empty

    project = Customview2::Project.find(ENV['PROJECT_ID'])

    expect(project.id).not_to be_nil
    
  end
end
