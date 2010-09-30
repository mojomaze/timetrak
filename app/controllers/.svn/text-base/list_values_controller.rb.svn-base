class ListValuesController < ApplicationController
  # GET /list_values
  # GET /list_values.xml
  def index
    @list_values = ListValue.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @list_values }
    end
  end

  # GET /list_values/1
  # GET /list_values/1.xml
  def show
    @list_value = ListValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @list_value }
      format.js   { render :layout => false }
    end
  end

  # GET /list_values/new
  # GET /list_values/new.xml
  def new
    @list_value = ListValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @list_value }
    end
  end

  # GET /list_values/1/edit
  def edit
    @list_value = ListValue.find(params[:id])
    respond_to do |format|
      format.html
      format.js   { render :layout => false }
    end
  end

  # POST /list_values
  # POST /list_values.xml
  def create
    @list_value = ListValue.new(params[:list_value])

    respond_to do |format|
      if @list_value.save
        format.html { redirect_to(@list_value, :notice => 'List value was successfully created.') }
        format.xml  { render :xml => @list_value, :status => :created, :location => @list_value }
        format.js   { render :layout => false }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @list_value.errors, :status => :unprocessable_entity }
        format.js   { render :action => "error", :layout => false }
      end
    end
  end

  # PUT /list_values/1
  # PUT /list_values/1.xml
  def update
    @list_value = ListValue.find(params[:id])

    respond_to do |format|
      if @list_value.update_attributes(params[:list_value])
        format.html { redirect_to(@list_value, :notice => 'List value was successfully updated.') }
        format.xml  { head :ok }
        format.js   { render :action => "show", :layout => false }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @list_value.errors, :status => :unprocessable_entity }
        format.js   { render :action => "error", :layout => false }
      end
    end
  end

  # DELETE /list_values/1
  # DELETE /list_values/1.xml
  def destroy
    @list_value = ListValue.find(params[:id])
    @list_value.destroy

    respond_to do |format|
      format.html { redirect_to(list_values_url) }
      format.xml  { head :ok }
      format.js   { render :layout => false }
    end
  end
  
  def sort
    params[:list_value].each_with_index do |id, index|
      ListValue.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
end
