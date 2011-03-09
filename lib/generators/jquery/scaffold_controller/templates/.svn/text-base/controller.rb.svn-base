class <%= controller_class_name %>Controller < ApplicationController
  helper_method :sort_column, :sort_direction
  
  respond_to :html, :js
  
  # GET <%= route_url %>
  def index
    params[:page] ||= 1
    params[:search] ||= params[:term]
    @<%= plural_table_name %> = <%= class_name %>.search(params[:search], params[:page], sort_column, sort_direction)
    respond_with @<%= plural_table_name %>
  end
  
  # GET <%= route_url %>/1
  # GET <%= route_url %>/1.js
  def show
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    respond_with @<%= singular_table_name %> do |format|
      format.js   { render :layout => false }
    end
  end

  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    respond_with @<%= singular_table_name %> do |format|
      format.html { render :action => "show" }
    end
  end

  # GET <%= route_url %>/1/edit
  def edit
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    respond_with @<%= singular_table_name %> do |format|
      format.js { render :action => "edit", :layout => false }
    end
  end
  
  # POST <%= route_url %>
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>
    @<%= orm_instance.save %>
    respond_with @<%= singular_table_name %> do |format|
      if @<%= singular_table_name %>.invalid?
        format.js { render :action => "error", :layout => false }
      else
        format.js { render :action => "update", :layout => false }
      end
    end
  end

  # PUT <%= route_url %>/1
  def update
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    respond_with @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %> do |format|
      if @<%= singular_table_name %>.invalid?
        format.js { render :action => "error", :layout => false }
      else
        format.js { render :action => "update", :layout => false }
      end
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.destroy %>
    respond_with @<%= singular_table_name %>
  end
  
  def list_action
    case params[:action_type]
    when 'delete'
      params[:action_id].each do |id|
        @<%= singular_table_name %> = <%= orm_class.find(class_name, "id") %>
        @<%= orm_instance.destroy %>
      end
      params[:page] ||= 1
      @<%= plural_table_name %> = <%= class_name %>.search(params[:search], params[:page], sort_column, sort_direction)
      respond_with @<%= plural_table_name %> do |format|
        format.js   { render :action => "destroy", :layout => false }
      end
    end
  end
  
  private
  
  def sort_column
    # set defualt sort column
    <%  default_sort = ''
        default_sort = attributes.first.name if attributes.first  %>
    session["<%= singular_table_name %>_sort_column"] ||= '<%= default_sort %>'
    session["<%= singular_table_name %>_sort_column"] = <%= class_name %>.column_names.include?(params[:sort]) ? params[:sort] : session["<%= singular_table_name %>_sort_column"]
  end
  
  def sort_direction
    # set default sort direction
    session["<%= singular_table_name %>_sort_direction"] ||= 'asc'
    session["<%= singular_table_name %>_sort_direction"] = %w[asc desc].include?(params[:direction]) ? params[:direction] : session["<%= singular_table_name %>_sort_direction"]
  end
end
