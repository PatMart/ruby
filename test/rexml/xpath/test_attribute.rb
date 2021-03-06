require 'test/unit'
require 'rexml/document'

class TestXPathAttribute < Test::Unit::TestCase
  def setup
    @xml = <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<root>
  <child name="one">child1</child>
  <child name="two">child2</child>
  <child name="three">child3</child>
</root>
    XML
    @document = REXML::Document.new(@xml)
  end

  def test_elements
    root = @document.elements["root"]
    second_child = root.elements["child[@name='two']"]
    assert_equal("child2", second_child.text)
  end

  def test_xpath_each
    children = REXML::XPath.each(@document, "/root/child[@name='two']")
    assert_equal(["child2"], children.collect(&:text))
  end
end
