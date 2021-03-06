module Bagpipes
  module Controllers
    module MessagesController
      def self.included(base)
        base.class_eval do
          include AuthenticatedSystem
          
          before_filter :require_topic
          before_filter :require_member_login, :except => :show

          layout 'bagpipes'
        end
      end

      def new
        @parent = @topic.messages.find_by_id(params[:parent_id])
        parent_params = @parent ? {
          :parent_id => @parent.id,
          :title => "Re: #{@parent.title}"
        } : {}

        @message = @topic.messages.build(parent_params)
      end

      def show
        @message = @topic.messages.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "This message no longer exists"
        redirect_to @topic
      end

      def create
        @message = @topic.messages.build(params[:message].merge({:user => current_user}))

        if @message.save
          flash[:notice] = "You have created a new message in \"#{@topic.title}\""
          redirect_to @message.parent ? topic_message_path(@topic, @message.parent) : @topic
        else
          flash.now[:form_error] = @message
          render :action => 'new'
        end
      end
      
      def destroy
        @message = Message.find(params[:id]).destroy
        redirect_to topic_path(params[:topic_id])
      end

      private
      def require_topic
        @topic = Topic.find(params[:topic_id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "This parent topic no longer exists"
        redirect_to topics_path
      end

      def require_member_login
        unless logged_in? && current_user
          flash[:error] = "You must be a member of the forum to do that"
          redirect_to new_session_path
        end
      end

      include FlashErrorsHelper
      protected :grab_errors_from_object
      protected :grab_errors_for_flash
    end
  end
end