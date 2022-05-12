require 'pg'

class Bookmarks 

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

      result = connection.exec("SELECT * FROM bookmarks;")
      result.map { |bookmark| 
        Bookmarks.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])
      } #bookmark = {"id"=>"1", "url"=>"http://makers.tech"}
  
    end

  def self.add(url, title)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') 
      RETURNING id, url, title;")
  end
end 