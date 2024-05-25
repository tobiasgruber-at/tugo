class KeywordsController < ApplicationController
  def create
    error_message = nil
    begin
      @keyword = Keyword.new(keyword_params)
      unless @keyword.valid? && @keyword.save
        error_message = @keyword.errors.full_messages[0]
      end
    rescue StandardError => e
      puts e.message
      error_message = "An error occurred. Please try again later."
    end
    if not error_message.nil?
      redirect_back fallback_location: root_path, alert: error_message
    else
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    begin
      Keyword.destroy(params[:id])
      redirect_back fallback_location: root_path
    rescue StandardError => e
      puts e.message
      redirect_back fallback_location: root_path, alert: "An error occurred. Please try again later."
    end
  end

  def keyword_params
    params.require(:keyword).permit(:favorite_id, :title)
  end
end
