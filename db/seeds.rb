# frozen_string_literal: true

Category.delete_all
Category.create!([
                   { name: 'Банкетки' },
                   { name: 'Диван для отдыха в положении сидя' },
                   { name: 'Диван-кровать' },
                   { name: 'Диван-софа' },
                   { name: 'Диваны' },
                   { name: 'Диваны и кресла' },
                   { name: 'Диваны угловые' },
                   { name: 'Кресла' },
                   { name: 'Кресла-мешки' },
                   { name: 'Кухонные уголки' },
                   { name: 'Кухонный диван' },
                   { name: 'Кушетки' },
                   { name: 'Подлокотник' },
                   { name: 'Стулья' }
                 ])

OrderStatus.delete_all
OrderStatus.create!([
                      { id: 1, name: 'В процессе' },
                      { id: 2, name: 'На доставке' },
                      { id: 3, name: 'Доставлен' },
                      { id: 4, name: 'Отменен' }
                    ])

City.delete_all
City.create!([
               { name: 'Астана' },
               { name: 'Алматы' },
               { name: 'Карагада' },
               { name: 'Актобе' }
             ])
