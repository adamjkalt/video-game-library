class Console < ActiveRecord::Base

  has_many :games


  def slug
    name.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Console.all.find { |console| console.slug == slug}
  end

end
