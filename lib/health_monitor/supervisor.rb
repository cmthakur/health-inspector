class Supervisor
  attr_accessor :services

  def initialize(_args)
    @services = ServiceLoader.new.services
  end

  def check
    {

    }
  end
end
