class Item
  include Comparable

  attr_accessor :id, :title, :url, :group, :list_price
  attr_reader :images, :offers

  def initialize(attributes = {})
    raise ArgumentError.new("Missing attributes") unless attributes

    {id: "", title: "", url: "", group: "", list_price: Price::NOT_AVAILABLE, images: {}, offers: []}.each do |property, default_value|
      send("#{property}=", attributes[property] || default_value)
    end

    coerce_images_keys_to_symbol
  end

  def <=>(other)
    id <=> other.id
  end

  def images=(images)
    @images = images
    coerce_images_keys_to_symbol
  end

  def offers=(offers)
    @offers = offers.each { |offer| offer.item = self }
  end

  private

  # TODO solve this in roar / representable
  # coercion in roar causes problems for collections:
  #   * all properties must be coerced (those that aren't are skipped)
  #   * all the chain must use coercion
  #   * hashes can't be serialized
  def coerce_images_keys_to_symbol
    coerced = {}
    @images.each { |type, image| coerced[type.to_sym] = image }
    @images = coerced
  end
end