require 'test_helper'

class BookTest < Test::Unit::TestCase
  def setup
    GoGoodreads.configure do |config|
      config.api_key = "1IlntIwcUm5CpTbQhu7Zg"
    end
  end

  def test_show_by_isbn
    VCR.use_cassette('book_by_isbn') do
      book = GoGoodreads::Book.show_by_isbn("0441172717")
      assert_equal "Dune (Dune Chronicles, #1)", book.title
      assert_equal "0441172717", book.isbn
      assert_equal "9780441172719", book.isbn13
      assert_nil   book.asin
      assert_equal "http://photo.goodreads.com/books/1170430859m/53732.jpg", book.image_url
      assert_equal "http://photo.goodreads.com/books/1170430859s/53732.jpg", book.small_image_url
      assert_equal %(This Hugo and Nebula Award winner tells the sweeping tale of a desert planet called Arrakis, the focus of an intricate power struggle in a byzantine interstellar empire. Arrakis is the sole source of Melange, the &quot;spice of spices.&quot; Melange is necessary for interstellar travel and grants psychic powers and longevity, so whoever controls it wields great influence. The troubles begin when stewardship of Arrakis is transferred by the Emperor from the Harkonnen Noble House to House Atreides.  The Harkonnens don't want to give up their privilege, though, and through sabotage and treachery they cast young Duke Paul Atreides out into the planet's harsh environment to die.  There he falls in with the Fremen, a tribe of desert dwellers who become the basis of the army with which he will reclaim what's rightfully his. Paul Atreides, though, is far more than just a usurped duke. He might be the end product of a very long-term genetic experiment designed to breed a super human; he might be a messiah.  His struggle is at the center of a nexus of powerful people and events, and the repercussions will be felt throughout the Imperium. Dune is one of the most famous science fiction novels ever written, and deservedly so.  The setting is elaborate and ornate, the plot labyrinthine, the adventures exciting. Five sequels follow. --Brooks Peck),
        book.description
      assert_equal 535, book.num_pages
      assert_equal 1, book.authors.size
      assert_equal "http://www.goodreads.com/book/show/53732.Dune", book.url
      assert_equal "http://www.goodreads.com/book/show/53732.Dune", book.link
      assert_equal 28, book.reviews.size
      assert_equal 3.93, book.average_rating
      assert_equal 345, book.text_reviews_count
      assert_equal "eng", book.language_code
      assert_nil   book.publisher
      assert_nil   book.publication_date
    end
  end

  def test_show_by_isbn_nil_on_not_found
    VCR.use_cassette('book_by_isbn_not_found') do
      book = GoGoodreads::Book.show_by_isbn("9780935998603")
      assert_nil book
    end
  end
end
