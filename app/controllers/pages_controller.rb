class PagesController < ApplicationController
  # Place here the permalinks of pages that will have custom processing
  # Then, define the function in this class
  # (for permalink 'tell-a-friend', define function 'tell_a_friend')
  CUSTOM_ACTIONS = %w(contact)


  def show
    @page = Page.find_by_permalink(params[:permalink])

    func = params[:permalink].gsub('-','_')
    
    go = true
    
    # if the permalink is 'register', for example, call the 'register'
    # function in this class... the function should return true or false
    go = self.send(func) if CUSTOM_ACTIONS.include?(func)
    
    # don't render anything else if the above funcion was called and returned false
    return go unless go
    
    # check if there is a personalized view to this page
    fname = "#{func}.html.erb"
    fname = 'show.html.erb' unless File.exist?(File.join("#{RAILS_ROOT}/app/views/pages", fname))
    
    # if there is no such page and no personalized view, go home
    if fname == 'show.html.erb' && @page.nil?
      params[:old_permalink] = params[:permalink]
      params[:permalink] = 'page-not-found'
      show
      return false
    end
	
    if params[:permalink] == 'trailer'
	    body = render_to_string(:action => fname, :layout => 'trailer')
	elsif params[:permalink] == 'home'
	    body = render_to_string(:action => fname, :layout => 'flash')
	elsif params[:permalink] == 'degung' or params[:permalink] == 'kereta' or params[:permalink] == 'budi' or params[:permalink] == 'lanny'
		body = render_to_string(:action => fname, :layout => 'popup')
	else
		body = render_to_string(:action => fname)
	end
	
    while(m = body.match(/%const\[([A-Z0-9\._:]+?)\]%/))
      body.sub!("%const[#{m[1]}]%", Module.const_get(m[1]))
    end
    while(m = body.match(/%params\[([a-z0-9_\[\]]+?)\]%/))
      body.sub!("%params[#{m[1]}]%", params.send('[]', m[1].to_sym))
    end
    
	render :text => body
    
  end

  def contact
    if request.post?
      Mailer.deliver_contact(params[:contact])
      flash[:notice] = 'Your message was sent.'
      session[:contact_params] = nil
      redirect_to(:permalink => 'contact')
      return false
    end
    return true
  end

end
