
# Raaws

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'raaws', :git => "http://github.com/charly/raaws"

And then execute:

    $ bundle

## Usage

This library tries to reflect at best Amazon Associate API. 
Originaly AAWS was destined to retrieve informations on items, 
and it'll probably stay it's main use.
Now it has become a rich API with
 
  * Item : ItemSearch, & ItemLookUp 
  * Tags, Lists, Sellers List, Customer Content, Transactions.
  * a full blown RESTfull Cart.
  * a lot more Search Indexes & consequent params
  * a huge set of Response Group
  

## Real world

What happens in practice is you build a url with lots of params and amazon answer
with an XML file containing all the answers you've requested.

Example (without authentication/page/response) :

http://ecs.amazonaws.com/onca/xml?
Operation=ItemSearch&
SearchIndex=DVD&
Director=Charlie%20Chaplin&
Title=Modern%20Times

The most important here is the **Operation** parameter which tells amazon 
if you're looking for items or willing to modify the cart.
The second most important, when dealing with collections, is in which 
**Index** you're going to search (book, dvd, toy, music etc).


## So how does RAAWS work

# for collection
``` ruby
  RAAWS::Item.search :dvd_index do |dvd|  
    dvd.director = "Charlie Chaplin"  
    dvd.title = "Modern Times"  
  end
```

# for member
``` ruby
  RAAWS::Item.look_up :asin => long_number
```
 
# for PUT
``` ruby
  RAAWS::Cart.add :asin => numnumnum
```

## Misc

is this library totally overkill ?

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
