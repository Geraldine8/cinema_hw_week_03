require_relative("../db/sql_runner")

class Screening

  attr_accessor :id, :show_time, :film_id, :available_tickets

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @show_time = options['show_time']
    @film_id = options['film_id'].to_i
    p options['available_tickets']
    @available_tickets = options['available_tickets'].to_i
  end

  def save() #Create
    sql = "INSERT INTO screenings (show_time, film_id, available_tickets)
    VALUES ($1, $2, $3) RETURNING id"
    values = [@show_time, @film_id, @available_tickets]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  #Advanced extensions:
  #2. Write a method that finds out what is the most popular time (most tickets sold) for a given film

  def self.find(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    screening = SqlRunner.run(sql, values).first
    # p screening
    return Screening.new(screening)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
