require 'sinatra'
require 'sqlite3'
require 'json'

get '/businesses' do
  page = params["page"].to_i || 1
  limit = params["limit"].to_i || 50
  offset = (page - 1) * limit

  res = Array.new
  db.execute("SELECT * FROM businesses ORDER BY id ASC LIMIT #{limit} OFFSET #{offset}") do |row|
    h = Hash.new
    row.each_with_index { |r,i| h[cols[i].to_sym] = r }
    res.push h
  end
  [ 200, { 'Content-Type' => 'application/json' }, [ JSON.generate({ :businesses => res, :page => page, :limit => limit, :offset => offset }) ] ]
end

get '/businesses/:id' do
  res = Hash.new
  db.execute("SELECT * FROM businesses WHERE id = #{params[:id]}") do |row|
    row.each_with_index { |r,i| res[cols[i].to_sym] = r }
  end
  res = { :error => 'Invalid ID provided.' } if res.empty?
  [ 200, { 'Content-Type' => 'application/json' }, [ JSON.generate(res) ] ]
end

def db
  @db ||= SQLite3::Database.new 'engineering_project_businesses.db'
end

def cols
  @cols ||= db.execute("PRAGMA table_info('businesses')").map { |c| c[1] }
end
