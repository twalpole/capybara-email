class Capybara::Email::Node < Capybara::Driver::Node
  def all_text
    native.text
  end
  alias :text :all_text
  alias :visible_text :all_text
  
  def [](name)
    string_node[name]
  end

  def value
    string_node.value
  end

  def click
    driver.follow(self[:href].to_s)
  end

  def tag_name
    native.node_name
  end

  def visible?
    string_node.visible?
  end

  def find_xpath(locator)
    native.xpath(locator).map { |node| self.class.new(driver, node) }
  end
  alias :find :find_xpath
  
  def find_css(locator)
    native.css(locator).map {|node| self.class.new(driver,node) }
  end
  

  private

  def string_node
    @string_node ||= Capybara::Node::Simple.new(native)
  end
end
