class InvoiceMailer < ActionMailer::Base
  
  def client_invoice(invoice, resend)
    @invoice = invoice
    @projects = @invoice.find_totals_by_project
    
    revised = resend ? " (REVISED)" : ""
    subject = "Invoice #{@invoice.number}#{revised}: #{@invoice.start_date.strftime("%m-%d-%Y")} - #{@invoice.end_date.strftime("%m-%d-%Y")}"
    
    @activities = @invoice.invoice_activities
    
    # create html/xls atttachment
    xls_file_name = "#{ @invoice.number}-invoice-detail.xls"
    xls_content = render_to_string(:template =>'invoices/detail', :layout => false)
    
    # create csv formatted iif attachment
    iif_file_name = "winkler-time-#{@invoice.end_date.strftime('%Y%m%d')}.iif"
    iif_content = @invoice.to_iif
    
    attachments[xls_file_name] = { :content => xls_content }
    attachments[iif_file_name] = { :content => iif_content }
    
    mail(:from => "#{@invoice.user.full_name } <#{@invoice.user.email}>", :to => "#{@invoice.client.billing_name } <#{@invoice.client.billing_email}>", :subject => subject)
  end
end
