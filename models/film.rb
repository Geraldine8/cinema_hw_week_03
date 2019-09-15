require_relative("../db/sql_runner")

class Film

  attr_accessor :title, :price, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2)
    RETURNING id"
    values= [@title, @price]
    film = SqlRunner.run(sql,values).first
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id WHERE tickets.film_id = $1"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    result = customer_data.map{|customer| Customer.new(customer)}
    return result
  end

  #Basic Extension
  #3.Check how many customers are going to watch a certain film

  def customers_watch_film()
    sql = "SELECT count(*) FROM tickets WHERE film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first()
    return result['count'].to_i
  end

  #Advanced extensions:
  #2. Write a method that finds out what is the most popular time (most tickets sold) for a given film

  def most_tickets_sold_by_film()
    sql = "SELECT screening_id, COUNT (screening_id)
    FROM tickets WHERE film_id = $1
    GROUP BY screening_id "
    values = [@id]
    result =  SqlRunner.run(sql, values)
    most_sold_screening = result.max_by{|screening| screening['count']}
    return Screening.find(most_sold_screening['screening_id'])
  end


  # def most_tickets_sold_by_film()
  #   sql = "SELECT screening_id, COUNT (screening_id)
  #   FROM tickets WHERE film_id = $1
  #   GROUP BY screening_id "
  #   values = [@id]
  #   result =  SqlRunner.run(sql, values).first
  #   return Screening.find(result['screening_id'])
  # end

  #PDA
  def self.order_by_film_name()
    sql = "SELECT * FROM films ORDER BY title"
    result = SqlRunner.run(sql)
    films = result.map{|film| Film.new(film)}
    return films #retornando el arreglo de objects
  end

  #Class Method
  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map{|film| Film.new(film)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
