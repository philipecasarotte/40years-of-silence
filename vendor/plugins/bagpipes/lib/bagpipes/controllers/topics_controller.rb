module Bagpipes
  module Controllers
    module TopicsController
      def self.included(base)
        base.class_eval do
          include AuthenticatedSystem
          
          before_filter :require_member_admin, :only => [:new, :create]

          layout 'bagpipes'
        end
      end

      def index
        @topics = Topic.by_title.all
      end

      def show
        @topic = Topic.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "That topic no longer exists"
        redirect_to topics_path
      end

      def new
        @topic = Topic.new
      end

      def create
        @topic = Topic.new(params[:topic])

        if @topic.save
          flash[:notice] = "The topic \"#{@topic.title}\" has been created"
          redirect_to topics_path
        else
          flash[:form_error] = @topic
          render :action => 'new'
        end
      end

      include FlashErrorsHelper
      protected :grab_errors_from_object
      protected :grab_errors_for_flash

      private
      def require_member_admin
        unless logged_in? && current_user && current_user.administrator?
          flash[:error] = "You must be a forum administrator to do that"
          redirect_to admin_login_path
        end
      end
    end
  end
end