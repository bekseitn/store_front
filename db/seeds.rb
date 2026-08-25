# frozen_string_literal: true

Category.delete_all
Category.create!([
                   { name: 'Benches' },
                   { name: 'Sofas for sitting' },
                   { name: 'Sofa beds' },
                   { name: 'Couches' },
                   { name: 'Sofas' },
                   { name: 'Sofas and armchairs' },
                   { name: 'Corner sofas' },
                   { name: 'Armchairs' },
                   { name: 'Bean bag chairs' },
                   { name: 'Kitchen nooks' },
                   { name: 'Kitchen sofas' },
                   { name: 'Daybeds' },
                   { name: 'Armrests' },
                   { name: 'Chairs' }
                 ])

OrderStatus.delete_all
OrderStatus.create!([
                      { id: 1, name: 'In progress' },
                      { id: 2, name: 'Out for delivery' },
                      { id: 3, name: 'Delivered' },
                      { id: 4, name: 'Cancelled' }
                    ])

City.delete_all
City.create!([
               { name: 'Astana' },
               { name: 'Almaty' },
               { name: 'Karaganda' },
               { name: 'Aktobe' }
             ])
