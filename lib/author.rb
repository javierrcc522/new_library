class Author
  attr_reader(:id,:name)

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
  end

  def self.all
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      id = author.fetch("id").to_i
      name = author.fetch("name")
      authors.push(Author.new({:id => id, :name => name}))
    end
    authors
  end

  def save
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def delete
    DB.exec("DELETE FROM authors WHERE id = #{@id};")
  end

  def ==(another_author)
    (self.id==another_author.id).&(self.name==another_author.name)
  end

  def update(attributes)
  @name = attributes.fetch(:name, @name)
  DB.exec("UPDATE authors SET name = '#{@name}' WHERE id = #{self.id()};")

  attributes.fetch(:id_title, []).each() do |title|
    DB.exec("INSERT INTO books (id_title, id_author) VALUES (#{title}, #{self.id()});")
    end
  end


  def self.find(id)
    found_author = nil
    Author.all().each() do |author|
      if author.id().==(id)
        found_author = author
      end
    end
    found_author
  end

end
