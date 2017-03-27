require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))


describe RTurk::AnswerParser do
  
  before(:all) do
    @answer =  <<-XML
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;QuestionFormAnswers xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2005-10-01/QuestionFormAnswers.xsd"&gt;
&lt;Answer&gt;
&lt;QuestionIdentifier&gt;tweet&lt;/QuestionIdentifier&gt;
&lt;SelectionIdentifier&gt;This is my tweet!&lt;/SelectionIdentifier&gt;
&lt;/Answer&gt;
&lt;Answer&gt;
&lt;QuestionIdentifier&gt;tweet&lt;/QuestionIdentifier&gt;
&lt;SelectionIdentifier&gt;12345678&lt;/SelectionIdentifier&gt;
&lt;/Answer&gt;
&lt;Answer&gt;
&lt;QuestionIdentifier&gt;Submit&lt;/QuestionIdentifier&gt;
&lt;SelectionIdentifer&gt;Submit&lt;/SelectionIdentifier&gt;
&lt;/Answer&gt;
&lt;/QuestionFormAnswers&gt;
XML
  end
  
  it "should parse a answer" do
    RTurk::AnswerParser.parse(@answer).to_hash.should == {"Submit"=>"Submit", "tweet"=>["This is my tweet!", "12345678"]}
  end

	it "should parse an answer into a param hash" do
		hash = RTurk::AnswerParser.parse(@answer).to_hash
		RTurk::Parser.new.normalize_nested_params(hash).should == {"Submit"=>"Submit", "tweet"=> ["This is my tweet!", "12345678"]}
	end

  
end
