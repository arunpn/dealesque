require 'spec_helper_without_rails'

class MockOfferWithItem
  Surrogate.endow self
  define_accessor(:item)
end

describe MockOfferWithItem do
  it "is a subset of Offer" do
    expect(Offer).to substitute_for(MockOfferWithItem, subset: true)
  end
end

describe Item do
  context "with attributes" do
    %w{id title url group list_price images offers more_offers_url}.each do |property|
      it "has #{property}" do
        expect(subject).to respond_to(property)
        expect(subject).to respond_to("#{property}=")
      end
    end

    context "with images" do
      let(:subject) { item = Item.new; item.images = {"small" => ItemImage.new}; item }

      it "coerces keys to symbol" do
        expect(subject.images.keys).to eq([:small])
      end
    end

    context "with offers" do
      let(:subject) { item = Item.new; item.offers = [MockOfferWithItem.new]; item }

      it "sets offer item to self" do
        expect(subject.offers.first.item).to eq(subject)
      end

      context "when appending offers" do
        let(:offer_to_append) { MockOfferWithItem.new }

        it "appends to existing offers" do
          subject.append_offers([offer_to_append])
          expect(subject.offers.size).to eq(2)
        end

        it "appended offers reference item" do
          subject.append_offers([offer_to_append])
          expect(offer_to_append.item).to eq(subject)
        end

        it "does not duplicate offers" do
          10.times { subject.append_offers([offer_to_append]) }
          expect(subject.offers.size).to eq(2)
        end
      end
    end
  end

  context "when comparing" do
    let(:first) { Item.new(id: "A123456")}
    let(:second) { Item.new(id: "A123456")}

    it "compares items with the same ID as the same" do
      expect(first == second).to eq(true)
    end
  end

  context "when initializing" do
    context "with images" do
      let(:attributes) { {images: {"thumbnail" => ItemImage.new}} }
      let(:subject) { Item.new(attributes) }

      it "coerces keys to symbol" do
        expect(subject.images.keys).to eq([:thumbnail])
      end
    end

    context "with defaults" do
      {id: "", title: "", url: "", group: "", list_price: Price::NOT_AVAILABLE, images: {}, offers: [], more_offers_url: ""}.each do |property, default_value|
        it "has defaults #{property} to '#{default_value}'" do
          expect(subject.public_send(property)).to eq(default_value)
        end
      end
    end

    context "without supplied attributes" do
      it "requires attribute hash" do
        expect { Item.new(nil) }.to raise_error(ArgumentError)
      end
    end

    context "with supplied attributes" do
      let(:attributes) { {id: 1, title: "Shoulda coulda woulda", url: "http://some.url", group: "book", list_price: Price.new, images: {}, offers: [], more_offers_url: "http://more_offers.url"} }
      let(:subject) { Item.new(attributes) }

      it "fills up from supplied attributes" do
        attributes.each do |attribute, value|
          expect(subject.public_send(attribute)).to eq(value)
        end
      end
    end
  end
end