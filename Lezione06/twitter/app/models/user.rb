class User
  attr_accessor :username, :email
  attr_reader :id, :errors
  
  @@users = []
  
  def User.all
    @@users
  end
  
  def User.find(id)
    @@users.find {|user| user.id == id.to_i }
  end
  
  def initialize(params={})
    @username = params[:username]
    @email = params[:email]
  end

  def save
    if valid?
      @@users << self
      @id = @@users.size
      return true
    end
    false
  end
  
  def update_attributes(params)
    @username = params[:username] if params[:username].present?
    @email = params[:email] if params[:email].present?    
    return valid?
  end
  
  def to_s
    "@#{username}"
  end
  
  def valid?
    validate
    @errors.empty?
  end
  
  def validate
    @errors = []
    @errors << "Username can't be blank" if @username.blank?
    @errors << "Email can't be blank" if @email.blank?
    if @email.present? && !@email.index("@")
      @errors << "Email format is wrong" 
    end
  end
end

User.new(:username => "pippo", :email => "pippo@disney.com").save
User.new(:username => "pluto", :email => "pluto@disney.com").save
