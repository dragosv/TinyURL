require 'digest'

class MainController < ApplicationController
  def index
    @token = Token.new
  end

  def create
    @token = Token.new
    @token.url = params[:url]
    @token.token = generate_token(params[:url])

    begin
      @token.save!

      flash.now[:notice] = 'Token ' + @token.token + ' was created for url ' + @token.url
    rescue ActiveRecord::RecordInvalid => e
      flash.now[:alert] = e.message
    rescue Exception => e
      flash.now[:alert] = 'Unexpected error occurred'
    end

    render :index
  end

  def redirect
    token = Token.find_by :token => params[:token]

    if token.nil?
      head 404
      return
    end

    visit = Visit.new
    visit.token = token
    visit.ip = request.remote_ip
    visit.save!

    redirect_to token.url
  end

  def info
    @token = Token.find_by :token => params[:token]

    if @token.nil?
      head 404
      return
    end

    @visitor_count = Visit.where(token_id: @token.id).count
  end

  private

  def generate_token(url)
    sha1 = Digest::SHA1.new
    sha1.update url
    sha1.hexdigest[0..7]
  end
end
