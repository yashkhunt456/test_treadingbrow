class MemberMailer < ApplicationMailer
    default from: 'your-salon@example.com'
  
    def redemption_notification(member, service, remaining_services)
      @member = member
      @service = service
      @remaining_services = remaining_services
  
      mail(
        to: @member.email,
        subject: "Combo Service Redeemed"
      )
    end
  end
  