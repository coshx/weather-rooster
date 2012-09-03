require 'spec_helper'

describe "errors/edit" do
  before(:each) do
    @error = assign(:error, stub_model(Error,
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit error form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => errors_path(@error), :method => "post" do
      assert_select "input#error_title", :name => "error[title]"
      assert_select "textarea#error_description", :name => "error[description]"
    end
  end
end
