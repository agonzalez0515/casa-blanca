require 'pony'

get '/' do
  erb :index
end

get '/portfolio' do
  erb :portfolio
end

get '/about' do
  erb :about
end

get '/services' do
  erb :services
end

get '/contact' do
  erb :contact
end

post '/contact' do
  configure_pony
  name = params[:name]
  sender_email = params[:email]
  message = params[:message]
  logger.error params.inspect

  begin
    Pony.mail(
      :from => "#{name}, <#{sender_email}>",
      :to => 'the-sad-clown@hotmail.com',
      :subject =>"#{name} has contacted you",
      :body => "#{message}, #{sender_email}",
    )
    erb :'_success'
    rescue
      @exception = $!
      erb :'_boom'
    end
  end

def configure_pony
  Pony.options = {
    :via => :smtp,
    :via_options => {
      :address              => 'smtp.gmail.com',
      :port                 => '587',
      :user_name            => ENV['TEMP_USERNAME'],
      :password             => ENV['TEMP_PASSWORD'],
      :authentication       => :plain,
      :enable_starttls_auto => true,
      :domain               => 'localhost.localdomain'
    }
  }

end
