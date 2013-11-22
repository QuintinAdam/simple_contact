require_dependency "simple_contact/application_controller"

module SimpleContact
  class ContactController < ApplicationController
    def new
      @message = SimpleContact::Message.new
    end

    def create
      @message = SimpleContact::Message.new(params[:message])
      if @message.valid?
        ContactMailer.contact_message(@message).deliver
        redirect_to main_app.root_path, notice: I18n.translate(:mailer_success_message)
      else
        flash.now.alert = "#{I18n.translate(:mailer_error_message)}"
        render :new
      end
    end
  end


end