class PromptsessionController < ApplicationController
  def get_prompt
    @ps = PromptSession.find_by(uid: params[:uid])
    if @ps 
      render json: {response: @ps.system_prompt}  
    else
        render json: {error: "No prompt"}
    end
  end

  def new
    @ps = PromptSession.new
  end

  def set_prompt
    @ps = PromptSession.new(prompt_params)
    @ps.like_count = 0
    @ps.dislike_count = 0
    @ps.user_id = Current.user.id
    if @ps.save
      render json: { message: "Prompt session created successfully" }
    else
      render :new, notice: "UID already in use"
    end
  end

  def update_prompt
    @ps = PromptSession.find_by(uid: uprompt_params[:uid])
    if @ps 
      @ps.system_prompt = uprompt_params[:system_prompt]
      render json: @ps.system_prompt  
    else
      render json: {error: "No prompt"}
    end
  end



  private
  def prompt_params
    params.require(:prompt_session).permit(:uid, :system_prompt, :like_count, :dislike_count)
  end

  def uprompt_params
    params.require(:prompt_session).permit(:uid, :system_prompt)
  end
end
