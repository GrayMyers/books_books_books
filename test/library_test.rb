require "minitest/autorun"
require "minitest/pride"
require "./lib/library.rb"
require "./lib/author.rb"

class Test < Minitest::Test
  def setup
    @library = Library.new("Denver Public Library")

    @author1 = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @book1 = @author1.write("Jane Eyre", "October 16, 1847")
    @book2 = @author1.write("The Professor", "1857")
    @book3 = @author1.write("Villette", "1853")

    @author2 = Author.new({first_name: "Harper", last_name: "Lee"})
    @book4 = @author2.write("To Kill a Mockingbird", "July 11, 1960")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Library, @library

    assert_equal "Denver Public Library", @library.name
    assert_equal [], @library.authors
  end

  def test_it_adds_authors
    assert_equal [], @library.authors
    @library.add_author(@author1)
    @library.add_author(@author2)
    assert_equal [@author1, @author2], @library.authors
    # assert_equal [@book1, @book2, @book3, @book4], @library.books
  end
end
