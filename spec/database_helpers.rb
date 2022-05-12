require 'pg'

def persisted_data(id)
  connection = PG.connect(dbname: 'bookmark_manager_test')
  result = connection.query("SELECT * FROM bookmarks WHERE id=#{id};")
  result.first
end

  # When calling Bookmark.add the return result is:
  # result = #<PG::Result:0x0000000132eadd18 status=PGRES_TUPLES_OK ntuples=1 nfields=3 cmd_tuples=1>
  # to access the actual result you need to do result.first.
  # This will return the bookmark hash:
  # {"id"=>"375", "url"=>"http://www.makersacademy.com/", "title"=>"Makers"}