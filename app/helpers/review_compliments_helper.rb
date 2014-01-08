module ReviewComplimentsHelper

  def all_compliments
    @all_compliments ||= Compliment.all
  end

end
