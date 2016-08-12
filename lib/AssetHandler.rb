class AssetHandler < Sinatra::Base
  configure do
    set :root, File.expand_path('../../',__FILE__)
    set :views, settings.root + '/public'
    # enable :coffeescript
    set :jsdir, 'js'
  end

  get '/js/*.js' do
    pass
    # pass unless settings.coffeescript?
    # last_modified File.mtime(settings.root+'/assets/'+settings.jsdir)
    # cache_control :public, :must_revalidate
    # # coffee (settings.jsdir + '/' + params[:splat].first).to_sym
    # pass
  end

  get '/js/*.js' do
    pass
    # pass unless settings.coffeescript?
    # last_modified File.mtime(settings.root+'/assets/'+settings.jsdir)
    # cache_control :public, :must_revalidate
    # # coffee (settings.jsdir + '/' + params[:splat].first).to_sym
    # pass
  end

  get '/css/*.css' do
    pass
  end

  get '/feed/*.gif' do
    pass
  end

end
