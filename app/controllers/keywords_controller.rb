class KeywordsController < ApplicationController
  def create
    is_error = false
    begin
      keyword = Keyword.new(
        :favorite_id => keyword_params["favorite_id"],
        :title => keyword_params["title"],
      )
      unless keyword.valid? && keyword.save
        is_error = true
      end
    rescue StandardError => e
      puts e.message
      is_error = true
    end
    if is_error
      redirect_back fallback_location: root_path, alert: "An error occurred. Please try again later."
    else
      redirect_back fallback_location: root_path, notice: "Added new keyword."
    end
  end

  def destroy
    # TODO: delete keyword
  end

  def keyword_params
    params.require(:keyword).permit(:favorite_id, :title)
  end
end
