class ApplicationController < ActionController::Base
  protect_from_forgery
  # for testing  
  def printa(a)
    p "======================"
    p "======================"
    p "======================"
    p a
    p "======================"
    p "======================"
    p "======================"
  end 
end
