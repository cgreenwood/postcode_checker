class ApplicationController < ActionController::Base
  ALLOWED_LSOAS = %w(Southwark Lambeth).freeze

  before_action { flash.clear }

  def home
    render 'checker'
  end

  def checker
    if helpers.check_postcode_format(postcode_params[:text])
      response = PostcodeApi.check_postcode(postcode_params[:text])
      if response['result']['lsoa'].present? && ALLOWED_LSOAS.any? { |lsoa| response['result']['lsoa'].include?(lsoa)}
        flash[:success] = "Good news! It appears as though you're in our service area."
      else
        flash[:danger] = "Sorry it doesn't look like we can reach you."
      end
    else
      flash[:danger] = "Sorry we couldn't recognise your postcode. Please try again."
    end
  end

  def postcode_params
    params.require(:postcode).permit(:text)
  end
end
