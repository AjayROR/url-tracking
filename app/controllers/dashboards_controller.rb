require 'reloader/sse'

class DashboardsController < ApplicationController
  include ActionController::Live
  before_action :authenticate_user!

  def index
    @urls = current_user.urls
  end

  def track
    response.headers['Content-Type'] = 'text/event-stream'
    sse = Reloader::SSE.new(response.stream)
    latest_updated_url = current_user.last_updated_url

    if url_recently_updated? latest_updated_url
      begin
        all_urls = current_user.urls
        sse.write(all_urls, event: 'results')
      rescue IOError
        # When the client disconnects, we'll get an IOError on write
      ensure
        sse.close
      end
    end
  end

  private
  def url_recently_updated? recent_updated_url
    recent_updated_url.updated_at > 2.seconds.ago or
    recent_updated_url.created_at > 2.seconds.ago
  end

end