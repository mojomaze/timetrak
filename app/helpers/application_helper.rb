module ApplicationHelper
  
  # returns a list of names/id's from Lists based on the passed list_name 
  def get_pick_list(list_name)
    @list = List.find_by_name( list_name ).list_values.collect{|v| [ v.name, v.value ] }
  end
  
  def time_format(time)
    if time
      time.strftime("%I:%M %p")
    end
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc" 
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
end
