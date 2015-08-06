require 'erb'
require 'yaml'
require 'sinatra/base'
require 'json'

require 'discobolo'
#require 'discobolo/api'
#require 'discobolo/paginator'
#require 'discobolo/web_helpers'

require 'sinatra/base'


module Discobolo

  module WebHelpers
    def client
      Discobolo::Config.client
    end

    def url_for(path)
      base_path = request.script_name
      [base_path,path].join("/")
    end

    def link_to(name, path, options={})
      "<a href='#{url_for(path)}'>#{name}</a>"
    end

  end
end



module Discobolo
  

  class Web < Sinatra::Base
    set :root, File.expand_path(File.dirname(__FILE__) + "/../../web")
    set :public_folder, proc { "#{root}/assets" }
    set :views, proc { "#{root}/views" }
    set :locales, ["#{root}/locales"]
    #set :erb, escape_html: true,
    #          layout_options: {views: 'app/views/layouts'}

    helpers Discobolo::WebHelpers

    class << self

    end

    get "/" do 
     
      @ts = $disque_stats.get_points
      erb :index, layout: :layout
    end

    get "/info" do 
      erb :info, layout: :layout
    end

    get "/stats/processed.json" do 
      content_type :json
      $disque_stats.get_points.to_json
    end

    get "/stats/processed/weeks.json" do 
      content_type :json
      $disque_stats.get_history.to_json
    end

    get "/queues" do
      @queues = Discobolo::Config.queues
      erb :'queues/index' 
    end

    get "/queues/:queue" do
      @queue = params[:queue]
      @page  = params[:page].to_i || 0
      opts   = { page: @page.to_i, count: 30}
      opts.merge!({state: params[:state]}) if params[:state]
      @jobs = client.jscan(@queue, opts).map{|o| o[:results]}
      erb :'queues/show' 
    end

    get "/workers" do 
      erb :'workers/index'
    end

    get "/jobs/:id" do 
      @job = client.show(params[:id])
      erb :'jobs/show'
    end

    get "/jobs/:id/dequeue" do 
      @job = client.dequeue(params[:id])
      redirect url_for("/jobs/#{params[:id]}")
    end

    get "/jobs/:id/dequeue" do 
      @job = client.enqueue(params[:id])
      redirect url_for("/jobs/#{params[:id]}")
    end

    get "/info" do 
      erb :info
    end

  end
end