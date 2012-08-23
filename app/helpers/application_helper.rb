module ApplicationHelper


  def slug(name)
    str = "#{name}"
    str.gsub! /['`]/,""
    str.gsub! /\s*@\s*/, " at "      
    str.gsub! /\s*&\s*/, " and "
    str.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'  
    str.gsub! /_+/,"_"
    str.gsub! /\A[_\.]+|[_\.]+\z/,""
    str.downcase!
    return str
  end

end
