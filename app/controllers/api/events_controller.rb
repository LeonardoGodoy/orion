module Api
  class EventsController < ::ApiController
    before_action :set_event, only: [:show]

    def index
      @events = EventSearch.new(search_params).results
      render_success_array(@events, EventSerializer)
    end

    def show
      render_success(@event, EventSerializer)
    end

    def create
      form = CreateEventForm.new(event_params)
      form.user_id = current_user.id

      if form.perform
        render_created(form.event, EventSerializer)
      else
        render_errors(form.errors)
      end
    end

    def update
      form = UpdateEventForm.new(update_event_params)
      form.user_id  = current_user.id
      form.event_id = params[:id]

      if form.perform
        render_success(form.event, EventSerializer)
      else
        render_errors(form.errors)
      end
    end

    def destroy
      form = DeleteEventForm.new(event_id: params[:id])
      form.user_id = current_user.id

      if form.perform
        render_success(form.event, EventSerializer)
      else
        render_errors(form.errors)
      end
    end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def search_params
      params.permit(:title, :group_id, :user_id)
    end

    def event_params
      params.require(:event).permit(:title, :content, :date, :group_id)
    end

    def update_event_params
      params.require(:event).permit(:title, :content, :date)
    end
  end
end
