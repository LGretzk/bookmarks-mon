require 'pg'

class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  # def self.connection
  #   @connection
  # end
  # Can be removed because the test for query relies on the persistent connection
  # created by setup.

  def self.query(sql, params = [])
    @connection.exec_params(sql, params)
  end
end