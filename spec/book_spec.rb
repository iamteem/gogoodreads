require 'spec_helper'

describe GoGoodreads::Book do
  use_vcr_cassette 'book_by_isbn'

  before(:each) do
    GoGoodreads.configure do |config|
      config.api_key = "1IlntIwcUm5CpTbQhu7Zg"
    end
  end

  describe ".show_by_isbn" do
    context "isbn is 0441172717" do
      subject { GoGoodreads::Book.show_by_isbn("0441172717") }

      its(:title)              { should == "Dune (Dune Chronicles, #1)" }
      its(:isbn)               { should == "0441172717" }
      its(:isbn13)             { should == "9780441172719" }
      its(:asin)               { should be_nil }
      its(:image_url)          { should == "http://photo.goodreads.com/books/1170430859m/53732.jpg" }
      its(:small_image_url)    { should == "http://photo.goodreads.com/books/1170430859s/53732.jpg" }
      its(:description)        { should == %(This Hugo and Nebula Award winner tells the sweeping tale of a desert planet called Arrakis, the focus of an intricate power struggle in a byzantine interstellar empire. Arrakis is the sole source of Melange, the &quot;spice of spices.&quot; Melange is necessary for interstellar travel and grants psychic powers and longevity, so whoever controls it wields great influence. The troubles begin when stewardship of Arrakis is transferred by the Emperor from the Harkonnen Noble House to House Atreides.  The Harkonnens don't want to give up their privilege, though, and through sabotage and treachery they cast young Duke Paul Atreides out into the planet's harsh environment to die.  There he falls in with the Fremen, a tribe of desert dwellers who become the basis of the army with which he will reclaim what's rightfully his. Paul Atreides, though, is far more than just a usurped duke. He might be the end product of a very long-term genetic experiment designed to breed a super human; he might be a messiah.  His struggle is at the center of a nexus of powerful people and events, and the repercussions will be felt throughout the Imperium. Dune is one of the most famous science fiction novels ever written, and deservedly so.  The setting is elaborate and ornate, the plot labyrinthine, the adventures exciting. Five sequels follow. --Brooks Peck) }
      its(:num_pages)          { should == 535 }
      its(:authors)            { should have(1).items }
      its(:url)                { should == "http://www.goodreads.com/book/show/53732.Dune" }
      its(:link)               { should == "http://www.goodreads.com/book/show/53732.Dune" }
      its(:reviews)            { should have(28).items }
      its(:average_rating)     { should == 3.93 }
      its(:text_reviews_count) { should == 345 }
      its(:language_code)      { should == "eng" }
      its(:publisher)          { should be_nil }
      its(:publication_date)   { should be_nil }
    end
  end
end
