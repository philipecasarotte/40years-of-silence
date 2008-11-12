class Admin::PagesController < Admin::AdminController
	index.before do
		@pages = Page.root_pages
	end

	new_action.before do
		@pages = Page.root_pages
	end
	
	edit.before do
		@pages = Page.root_pages
	end
	
	update.before do
		@pages = Page.root_pages
		params[:page][:parent_ids] = [] unless params[:page][:parent_ids]
	end
end
