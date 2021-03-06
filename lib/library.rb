class Library
  attr_reader :name, :books, :authors, :checked_out_books
  def initialize(name)
    @name = name
    @authors = []
    @checked_out_books = []
    @book_popularity_hash = {}
  end

  def add_author(author)
    @authors << author
  end

  def books
    @authors.flat_map do |author|
      author.books
    end
  end

  def publication_time_frame_for(author)
    {
      start: find_year_first_book_written(author),
      end: find_year_last_book_written(author)
    }
  end

  def find_year_first_book_written(author)
    first_book = author.books.min_by do |book|
      book.publication_year.to_i
    end
    first_book.publication_year
  end

  def find_year_last_book_written(author)
    last_book = author.books.max_by do |book|
      book.publication_year.to_i
    end
    last_book.publication_year
  end

  def checkout(book)
    if book_exists(book) && book_is_free(book)
      checked_out_books << book
      add_popularity(book)
      true
    else
      false
    end
  end

  def return(book)
    checked_out_books.delete(book)
  end

  def book_exists(book)
    books.include?(book)
  end

  def book_is_free(book)
    !checked_out_books.include?(book)
  end

  def add_popularity(book)
    @book_popularity_hash[book] ||= 0
    @book_popularity_hash[book] += 1
  end

  def most_popular_book
    @book_popularity_hash.max_by do |book,times_checked_out|
      times_checked_out
    end[0]
  end
end
