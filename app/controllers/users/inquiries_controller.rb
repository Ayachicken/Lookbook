class Users::InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(inquiry).deliver
      redirect_to user_inquiry_complete_path
    else
      render :new
    end
  end

  def complete
  end

  private
  def inquiry_params
    params.require(:inquiry),permit(:name, :message, :email)
end
