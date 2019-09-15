require_relative("../db/sql_runner")

class Ticket

  attr_accessor :id, :customer_id, :film_id

  def initialize(options)
    @id = options['iid'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save() #Create
    sql = "INSERT INTO tickets (customer_id, film_id, screening_id)
    VALUES ($1, $2, $3) RETURNING id"
    values = [@customer_id, @film_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id, screening_id) = ($1, $2, $3) WHERE id = $3"
    values = [@customer_id, @film_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

  #Basic Extensions
  #1 .Buying tickets should decrease the funds of the customer by the price
  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql, values).first
    return Film.new(film)
  end


  #Class Method
  def self.all() #Read
    sql = "SELECT * FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    result = tickets.map{|ticket| Ticket.new(ticket)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end
















end
