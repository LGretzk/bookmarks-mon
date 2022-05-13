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
      # result = #<PG::Result:0x0000000132eadd18 status=PGRES_TUPLES_OK ntuples=1 nfields=3 cmd_tuples=1>
      result.map { |bookmark| 
        # bookmark = {"id"=>"375", "url"=>"http://www.makersacademy.com/", "title"=>"Makers"}
        Bookmarks.new(bookmark['id'], bookmark['url'], bookmark['title'])
      } 
  end

  def self.add(url, title)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    # Before exec_params
    # result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title;")
    # After
    result = connection.exec_params("INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING id, title, url;", [url, title])

    Bookmarks.new(result[0]['id'], result[0]['url'], result[0]['title'])
  end

  def self.delete(id)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    connection.exec_params("DELETE FROM bookmarks WHERE id=$1", [id])
  end

end 
