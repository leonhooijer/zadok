# Zadok

[![Gem Version](https://badge.fury.io/rb/zadok.svg)](https://badge.fury.io/rb/zadok)
[![Maintainability](https://api.codeclimate.com/v1/badges/36a46de7e667c1a73fc3/maintainability)](https://codeclimate.com/github/leonhooijer/zadok/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/36a46de7e667c1a73fc3/test_coverage)](https://codeclimate.com/github/leonhooijer/zadok/test_coverage)

**Why Zadok?**

Zadok was apoointed by king David to manage his treasuries while he was on the run. This gem is made to manage your application resources. Also the name sounds catchy. 

Some background information:

*"Zadok (Hebrew: צדוק‎ Tsadoq, meaning "Righteous") or Zadoq is a legendary priest, said to be descended from Eleazar the son of Aaron (1 Chron 6:4-8).[1] He aided King David during the revolt of his son Absalom and was subsequently instrumental in bringing King Solomon to the throne. After Solomon's building of The First Temple in Jerusalem, Zadok was the first High Priest to serve there."*

Source: [Wikipedia](https://en.wikipedia.org/wiki/Zadok).


**Nehemiah 13:13**:
*"And I made treasurers over the treasuries, Shelemiah the priest, and Zadok the scribe, and of the Levites, Pedaiah: and next to them was Hanan the son of Zaccur, the son of Mattaniah: for they were counted faithful, and their office was to distribute unto their brethren."*

Source: [Bilbe.com](https://www.bible.com/bible/1/NEH.13.13)

## About this gem

I created this gem while working for [De Praktijk Index](https://www.depraktijkindex.nl). After having written several applications through the years I noticed that much of the functionallity is always the same (just simple CRUD). I wrote this gem to standardize this so I have to write less code when setting up a new application. Also this gem should help me in maintaining applications since a simple `bunle update zadok` would now be enough to update an application.

## Setup 

Just run `gem install zadok` or add `gem "zadok"` to your Gemfile.

To use Zadok in a controller just inherit it:
```ruby
class SampleController < ZadokController
  load_and_authorize_resource!
  
  protected
  
  def sample_params
    params.require(:sample).permit!
  end
  alias resource_params sample_params

  def resource_name
    "sample"
  end

  def resources
    @samples
  end
  alias search_model resources

  def resource
    @sample
  end

  def filter_and_paginate_resources!
    @samples = filtered_resources.paginate(page: page, per_page: per_page)
  end

  def filtered_resources
    current_search.result
  end

  def filters_namespace
    "Filters::Samples".constantize
  end

  def index_attributes
    %i[id name]
  end

  def new_attributes
    {
      name: { type: :text_field }
    }
  end

  def edit_attributes
    {
      name: { type: :text_field }
    }
  end
end
```

Then you should have full CRUD-functionallity for the Sample class.
