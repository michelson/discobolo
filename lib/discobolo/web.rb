require 'erb'
require 'yaml'
require 'sinatra/base'

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

    def relative_time(start_time)
      #start_time = start_time.is_a?(Integer) ? Time.at(start_time) : start_time
      diff_seconds = start_time
      case start_time
      when 0 .. 59
        out = "in #{diff_seconds.round(2)} seconds"
      when 60 .. (3600-1)
        out = "in #{(diff_seconds/60).round(2)} minutes"
      when 3600 .. (3600*24-1)
        out = "in #{(diff_seconds/3600).round(2)} hours"
      when (3600*24) .. (3600*24*30) 
        out = "in #{diff_seconds/(3600*24).round(2)} days"
      else
        out = start_time.strftime("%m/%d/%Y")
      end
      out
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
      erb :index, layout: :layout
    end

    get "/info" do 
      erb :info, layout: :layout
    end

    get "/queues" do
      @queues = Discobolo::Config.queues
      erb :'queues/index' 
    end

    get "/queues/:queue" do
      @queue = params[:queue]
      @page = params[:page].to_i || 0
      @jobs = client.jscan(@queue, @page.to_i, 30).map{|o| o[:results]}
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