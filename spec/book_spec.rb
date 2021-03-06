require("spec_helper")

describe(Book) do
  describe(".all") do
    it("starts off with no book") do
      expect(Book.all()).to(eq([]))
    end
  end

  describe("#id") do
    it("tells you the name of the book and author") do
      book = Book.new({:id => 1})
      expect(book.id()).to(eq(1))
    end
  end

  describe("#id_author") do
    it("tells you the author of the book and author") do
      book = Book.new({:id_author => 2})
      expect(book.id_author()).to(eq(2))
    end
  end

  describe("#id_title") do
    it("sets its ID when you save it") do
      book = Book.new({:id => 1, :id_author => 2, :id_title => 3})
      book.save()
      expect(book.id_title()).to(eq(3))
    end
  end

  describe("#save") do
    it("lets you save books to the database") do
      book = Book.new({:id => 1, :id_author => 2, :id_title => 3})
      book.save()
      expect(Book.all()).to(eq([book]))
    end
  end

  describe("#==") do
    it("is the same book if it has the same name") do
      book1 = Book.new({:id => nil, :id_author => nil, :id_title => nil})
      book2 = Book.new({:id => nil, :id_author => nil, :id_title => nil})
      expect(book1).to(eq(book2))
    end
  end

  describe(".find") do
    it("returns a book by its ID") do
      book1 = Book.new({:id => nil, :id_author => 2, :id_title => 3})
      book1.save()
      book2 = Book.new({:id => nil, :id_author => 2, :id_title => 3})
      book2.save()
      expect(Book.find(book2.id())).to(eq(book2))
    end
  end

  describe("#update") do
    it("lets you add another title") do
      book = Book.new({:id_title => 2, :id_author => 3})
      book.save()
      title = Title.new({:id => 1, :title => "Chicken Little"})
      title.save()
      author = Author.new({:id => 1, :name => "Javi"})
      author.save()
      book.update({:id => [title.id, author.id]})
    expect(book).to(eq([title, author]))
    end
  end

  # describe("#books") do
  #   it("returns an array of tasks for that book") do
  #     test_author = Author.new({:id => 1, :name => 'Dan'})
  #     test_author.save()
  #     test_title = Title.new({:id => 1, :title => 'Chiken Little'})
  #     test_title.save()
  #     test_book = Book.new({:id => 1, :id_author => test_author.id, :id_title => test_title.id})
  #     test_book.save()
  #     expect(Book.all).to eq([test_book])
  #   end
  # end
end
