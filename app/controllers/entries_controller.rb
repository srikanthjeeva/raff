class EntriesController < ApplicationController
  respond_to :json

  def index
    respond_with Entry.all
  end

  def show
    response = ""
    headers = {
      'AppKey' => "97105e14f1ddf016",
      'Authorization' => "b072cd6de4a8cde92ab6ec8b8030dca25a43"
    }
    proxy = Net::HTTP::Proxy('proxy.cognizant.com', 6050, "systompun", "password-1")
    proxy.start('csocial.cognizant.com', :use_ssl => true, :verify_mode => OpenSSL::SSL::VERIFY_NONE) { |http|
      response = http.get("/api/v2/people/#{params[:id]}", headers)
    }
    responsebody = response.body
    parsed_result = JSON.parse(responsebody)
    respond_with parsed_result
  end

  def create
    respond_with Entry.create(params[:entry])
  end

  def update
    respond_with Entry.update(params[:id], params[:entry])
  end

  def destroy
    respond_with Entry.destroy(params[:id])
  end
end
