# frozen_string_literal: true

module ApplicationHelper
  
  def flash_handle
    if flash['alert']
      content_tag :div, class: 'alert alert-danger mt-3', role: 'alert' do
        flash['alert'].html_safe
      end
    elsif flash['notice']
       content_tag :div, class: 'alert alert-success mt-3', role: 'alert' do
        flash['notice'].html_safe
      end
    end
  end

  def bootstrap_class_for flash_type    
    { success: 'success', error: 'danger', alert: 'warning', notice: 'info' } [flash_type] || flash_type.to_s    
  end
  
  def bootstrap_flash_translate(type, msg)
    case type
    when "notice"
      "info"
    when "error"
      "danger"
    when "alert"
      if msg == "You need to sign in or sign up before continuing." then
        "info"
      else
        "danger"  
      end      
    else
      type
    end    
  end

  
  # def boostrap_class(alert)
  #   { success: 'alert-success', error: 'alert-danger', notice: 'alert-success', warning: 'alert-warning',
  #     danger: 'alert-danger', alert: 'alert-danger' }[alert.to_sym]
  # end

  # def flash_messages(_opts = {})
  #   flash.each do |msg_type, message|
  #     # concat(content_tag(:div, message, class: "alert #{boostrap_class(msg_type.to_sym)} fade in") do
  #     concat(content_tag(:div, message, class: "alert #{boostrap_class(msg_type.to_sym)}") do
  #       concat(content_tag(:button, id: 'close-button', class: 'close', type: :button, data: { dismiss: 'alert' },
  #                                   'aria-label' => :Close) do
  #                concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
  #              end)
  #       concat message
  #     end)
  #   end
  #   nil
  # end

  def user_type(path)
    if path.include?('owner')
      'Landlord'
    elsif path.include?('tenant')
      'Tenant'
    else
      ''
    end
  end
end
