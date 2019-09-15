require_relative("../db/sql_runner")

class Customer

  attr_accessor :id, :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save() #Create
    sql = "INSERT INTO customers (name, funds)
    VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end


  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #Show which films a customer has booked to see
  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    result = film_data.map{|film| Film.new(film)}
    return result
  end

  #Basic Extensions
  #1 .Buying tickets should decrease the funds of the customer by the price
  def buy_ticket(ticket)
    film = ticket.film()
    @funds -= film.price
  end

  #2. Check how many tickets were bought by a customer

  def tickets_bought()
    sql = "SELECT count(*) FROM tickets WHERE customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first()
    p result
    return result['count'].to_i
  end


  #Class Method
  def self.all() #Read
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map{|customer| Customer.new(customer)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
