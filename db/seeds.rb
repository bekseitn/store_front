# frozen_string_literal: true

Category.delete_all

OrderStatus.delete_all
OrderStatus.create!([
                      { id: 1, name: 'New' },
                      { id: 2, name: 'Processing' },
                      { id: 3, name: 'Shipped' },
                      { id: 4, name: 'Delivered' },
                      { id: 5, name: 'Cancelled' }
                    ])

City.delete_all
