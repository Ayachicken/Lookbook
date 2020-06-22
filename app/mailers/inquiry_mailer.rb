class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)
    @inquiry = inquiry
    mail(
      from: 'system@Lookbook.info',
      to:   'manager@Lookbook.info',
      subject: 'お問い合わせ通知'
    )
  end
end
