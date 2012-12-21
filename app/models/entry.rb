class Entry < ActiveRecord::Base
  attr_accessible :name, :username

  validates_presence_of :username
  validates_uniqueness_of :username

  before_create :add_name

  def add_name
    response = ""
    headers = {
      'AppKey' => "97105e14f1ddf016",
      'Authorization' => "b072cd6de4a8cde92ab6ec8b8030dca25a43"
    }
    proxy = Net::HTTP::Proxy('proxy.cognizant.com', 6050, "systompun", "password-1")
    proxy.start('csocial.cognizant.com', :use_ssl => true, :verify_mode => OpenSSL::SSL::VERIFY_NONE) { |http|
      response = http.get("/api/v2/people/#{self.username}", headers)
    }
    responsebody = response.body
    parsed_result = JSON.parse(responsebody)
    self.name = parsed_result["displayName"]
  end
end
