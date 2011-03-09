<%
  # build search query on all attributes
  query = []
  params = []
  attributes.each do |a|
    query << "#{a.name} LIKE ?"
    params << "search"
  end

%>
class <%= class_name %> < <%= parent_class_name.classify %>
<% attributes.select {|attr| attr.reference? }.each do |attribute| -%>
  belongs_to :<%= attribute.name %>
<% end -%>

 # sets the default pagination limit
 cattr_reader :per_page
 @@per_page = 40
 
 # search or return all
 def self.search(query, page, sort_column, sort_direction)
   if query
     search = "%#{query}%"
     return order(sort_column+" "+sort_direction).where("<%= query.join(' OR ') %>", <%= params.join(',') %>).paginate(:page => page, :per_page => self.per_page)
  end
  order(sort_column+" "+sort_direction).paginate(:page => page, :per_page => self.per_page)
 end
end
