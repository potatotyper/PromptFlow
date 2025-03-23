require 'net/http'
require 'uri'
require 'json'

class BadfeedbackController < ApplicationController
  def get_feedback
    @bf = BadFeedback.new(get_params)
    @ps = PromptSession.find_by(uid: get_params[:prompt_session_id])
    if @ps 
      puts "BAD FEEDBACK PROCCESS"
      @ps.dislike_count = @ps.dislike_count + 1
      @bf.comment = get_params[:comment]
      @bf.save
      url = URI.parse('https://excited-frog-reasonably.ngrok-free.app/rewrite')

      # Create the request object
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https') # Enable SSL for HTTPS
    
      # Create the POST request
      request = Net::HTTP::Post.new(url.path, 'Content-Type' => 'application/json')
    
      # Add the request body (if needed)
      request.body = {
        prompt: @ps.system_prompt,
        feedback: @bf.comment
      }.to_json
    
      # Send the request and get the response
      response = http.request(request)
    
      # Parse the response
      if response.is_a?(Net::HTTPSuccess)
        json_response = JSON.parse(response.body)
        new_string = json_response["new"]
        @ps.feedback = new_string
        puts "Response: #{response.body}"
      else
        puts "Error: #{response.code} - #{response.message}"
      end
      
      @ps.save

      url = URI.parse('https://excited-frog-reasonably.ngrok-free.app/similarity')
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Post.new(url.path, 'Content-Type' => 'application/json')
      puts @ps.system_prompt
      puts @ps.feedback
      puts "COMPARE ABOVE"
      request.body = {
        prompt1: @ps.system_prompt,
        prompt2: @ps.feedback
      }.to_json

      response = http.request(request)

      if response.is_a?(Net::HTTPSuccess)
        # Parse the JSON response
        json_response = JSON.parse(response.body)
        # Extract the value of the "new" key
        new_int = json_response["similarity"]*100
        @ps.prompt_sim = new_int
        @ps.save
      else
        puts "Error: #{response.code} - #{response.message}"
      end
      render json: @ps.prompt_sim
    else
      render json: "ps not found"
    end
  end

  private
  def get_params
    params.permit(:prompt_session_id, :comment)
  end
end
