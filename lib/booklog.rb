
module Booklog; end

class Booklog::Reminder
  UNREAD_SELECTOR = '#shelf .autopagerize_page_element .list ul li a'

  attr_accessor :username

  def initialize(opts = {})
    reset
    @username = opts[:username]
  end

  def reset
    @data = Hash.new
  end

  def unread_url
    raise "username が未設定です" if username.nil? or username.empty? or username == ""
    "http://booklog.jp/users/#{username}?display=list&category_id=0&status=1&rank=0&sort=date_desc"
  end

  def unread
    @data[:unread] ||= get_unread
  end

  protected

  def get_unread
    p unread_url
    # 読みたい本のリストを取得する
    html = open(unread_url).read
    doc  = Nokogiri::HTML.parse html
    elements = doc.css(UNREAD_SELECTOR).to_a
    parse_items(elements)
  end

  def parse_items(elements)
    elements.lazy.map do |element|
      asin = element["href"].split("/").last
      link = "http://booklog.jp"+element["href"]
      data = [asin, element.text.gsub(/ |　/, "").gsub("\n\n", "\n").split("\n").compact, link].flatten
      Hash[ [:asin, :title, :author, :issued_at, :link].zip(data) ]
    end
  end
end
