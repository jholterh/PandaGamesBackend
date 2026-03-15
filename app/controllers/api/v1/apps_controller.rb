module Api
  module V1
    class AppsController < BaseController
      skip_before_action :authenticate_user!

      # GET /api/v1/apps
      def index
        apps = MiniApp.published.order(play_count: :desc)
        render json: apps.map { |app| app_json(app) }
      end

      # GET /api/v1/apps/:slug
      def show
        app = MiniApp.find_by!(slug: params[:slug])
        render json: app_json(app)
      end

      private

      def app_json(app)
        {
          slug: app.slug,
          name: app.name,
          description: app.description,
          author: app.author,
          category: app.category,
          tags: app.tags,
          thumbnail_url: app.thumbnail_url,
          route_prefix: app.route_prefix,
          version: app.version,
          is_published: app.is_published,
          play_count: app.play_count
        }
      end
    end
  end
end
