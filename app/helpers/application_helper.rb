module ApplicationHelper
  def devise_controller?
    devise_controller_names.include?(controller_name)
  end

   private

   def devise_controller_names
    %w[registrations sessions passwords confirmations]
  end
end
