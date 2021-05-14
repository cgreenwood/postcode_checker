class ApplicationController < ActionController::Base
  ALLOWED_LSOAS = %w(Southwark Lambeth).freeze

  before_action :flash_clear, only: :checker

  before_action :check_postcode, only: :checker

  def home
    render 'checker'
  end

  def checker
    response = PostcodeApi.check_postcode(postcode_params[:text])
    if response['result']['lsoa'].present? && ALLOWED_LSOAS.any? { |lsoa| response['result']['lsoa'].include?(lsoa) }
      flash[:success] = "Good news! It appears as though you're in our service area."
    else
      flash[:danger] = "Sorry it doesn't look like we can reach you."
    end
  end

  def check_postcode
    return if helpers.check_postcode_format(postcode_params[:text])

    flash[:danger] = "Sorry we couldn't recognise your postcode. Please try again."
    redirect_to root_path
  end

  def flash_clear
    flash.clear
  end

  def postcode_params
    params.require(:postcode).permit(:text)
  end
end
