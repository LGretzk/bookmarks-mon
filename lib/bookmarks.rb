require 'pg'

class Bookmarks 

  attr_reader :url, :title, :id

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

      result = connection.exec("SELECT * FROM bookmarks;")
      result.map { |bookmark| 
        Bookmarks.new(bookmark['id'], bookmark['url'], bookmark['title'])
      } 
      # #<PG::Result:0x0000000132eadd18 status=PGRES_TUPLES_OK ntuples=1 nfields=3 cmd_tuples=1>
      # {"id"=>"375", "url"=>"http://www.makersacademy.com/", "title"=>"Makers"}
  
    end

  def self.add(url, title)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') 
      RETURNING id, url, title;")
    Bookmarks.new(result[0]['id'], result[0]['url'], result[0]['title'])
  end
end 