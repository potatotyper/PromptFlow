class MainController < ApplicationController
  def home
    @i = 0
    @i2 = 0
    @c = 0
    @ps = PromptSession.new
    if Current.user
      @pss = Current.user.prompt_session
    end
  end
end
