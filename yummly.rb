require 'yummly'
require 'pp'
require 'json'

# The api key I signed up for
Yummly.configure do |c|
  c.app_id = "02c7fa68"
  c.app_key = "d5a9789f8281ded99865e3c2f21819c1"
end
# Number of results per page
PAGE_SIZE = 40


def search(query, ingredient=nil, course=nil, page_number=0)
  # To see your search_param options, see the yummly api docs:
  # https://developer.yummly.com/documentation#Parameters
  # You should be able to add them to this hash, and pass them as the
  # second parameter
  search_params = {
    "allowedIngredient[]" => ingredient,
    "allowedCourse[]" => course,
    maxResult: PAGE_SIZE, start: PAGE_SIZE * page_number
  }

  # https://github.com/twmills/yummly  - This guy created a gem, so we are just hitting the yummly api.
  # The first parameter is the 'q' (plain text query) option.  the search_params is a hash with
  # everything else.
  recipes = Yummly.search nil, search_params
end

# To just run a simple search.
recipes = search("tacos")

# Print them to the screen
pp search("tacos")

# Save each recipe to a file
File.open('results.json', 'w') do |file|
  recipes.each do |recipe|
    file.write(recipe.response.to_json)
  end
end

# Print just the name and ingredient lines of each recipe
recipes.each do |recipe|
  print "#{recipe.name} =============\n"

  recipe.ingredients.each do |ingredient|
    print "\t#{ingredient}\n"
  end
end

nil
