require 'spec_helper'

describe "errors/new" do
  before(:each) do
    assign(:error, stub_model(Error,
      :title => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new error form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => errors_path, :method => "post" do
      assert_select "input#error_title", :name => "error[title]"
      assert_select "textarea#error_description", :name => "error[description]"
    end
  end
end
