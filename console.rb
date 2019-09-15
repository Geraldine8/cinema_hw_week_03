require_relative('models/screening')
require_relative('models/ticket')
require_relative('models/customer')
require_relative('models/film')


require('pry-byebug')

Customer.delete_all()
Film.delete_all()
Screening.delete_all()
Ticket.delete_all()

customer1 = Customer.new({
  'name' => 'Fabiola',
  'funds' => 100,
  })

customer1.save()
# customer1.name = 'Fabiola C.'
# customer1.update()


customer2 = Customer.new({
  'name' => 'Anna',
  'funds' => 150,
  })

customer2.save()

customer3 = Customer.new({
  'name' => 'Lety',
  'funds' => 200,
  })
customer3.save()

film1 = Film.new({
  'title' => 'Matrix 4',
  'price' => 20
  })

film1.save()

film2 = Film.new({
  'title' => 'Eternal sunshine of the spotless mind',
  'price' => 15
  })

film2.save()
# film2.title = 'IT'
# film2.update()

film3 = Film.new({
  'title' => 'Carrie',
  'price' => 15
  })

film3.save()


#========== Advanced extensions: ===============
# 1.Create a screenings table that lets us know what time films are showing

screening1 = Screening.new({
  'show_time' => '13:30',
  'film_id' => film1.id,
  'available_tickets' => 5
  })

screening1.save()


screening2 = Screening.new({
  'show_time' => '17:30',
  'film_id' => film1.id,
  'available_tickets' => 3
  })

screening2.save()

screening3 = Screening.new({
  'show_time' => '20:30',
  'film_id' => film1.id,
  'available_tickets' => 4
  })

screening3.save()


ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id,
  'screening_id' => screening1.id
  })

ticket1.save()

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id,
  'screening_id' => screening2.id
  })

ticket2.save()

ticket3 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film3.id,
  'screening_id' => screening2.id
  })
ticket3.save()

#======== Basic Extensions ====================
#1
ticket4 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film1.id,
  'screening_id' => screening1.id
  })

ticket4.save()
customer2.buy_ticket(ticket4)
customer2.update()

#2

customer2.tickets_bought()

#3
film1.customers_watch_film()


binding.pry
nil
