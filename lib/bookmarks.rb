require 'pg'
require_relative 'database_connection'
require 'uri'

class Bookmarks 

  attr_reader :url, :title, :id

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def self.all
      result = DatabaseConnection.query("SELECT * FROM bookmarks;") 
      # result = #<PG::Result:0x0000000132eadd18 status=PGRES_TUPLES_OK ntuples=1 nfields=3 cmd_tuples=1>
      result.map { |bookmark| 
        # bookmark = {"id"=>"375", "url"=>"http://www.makersacademy.com/", "title"=>"Makers"}
        Bookmarks.new(bookmark['id'], bookmark['url'], bookmark['title'])
      } 
  end

  def self.add(url, title)
    return false unless is_url?(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING id, title, url;", [url, title])
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

  def self.update(url, title, id)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec_params(
      "UPDATE bookmarks SET url=$1, title=$2 WHERE id=$3 RETURNING id, url, title",
      [url, title, id]
    )
    Bookmarks.new(result[0]['id'], result[0]['url'], result[0]['title'])
  end

  def self.find(id)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec_params("SELECT * FROM bookmarks WHERE id=$1;", [id])
    Bookmarks.new(result[0]['id'], result[0]['url'], result[0]['title'])
  end

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end 
