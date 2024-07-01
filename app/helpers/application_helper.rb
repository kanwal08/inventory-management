module ApplicationHelper
  def flash_class(type)
    case type
    when :notice 
        "success"       
    when :alert
        "danger"
        
    else
        type
    end
    
  end
end
