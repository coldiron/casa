require "rails_helper"

RSpec.describe "admin views case contacts index page", type: :system do
  let(:organization) { create(:casa_org) }
  let(:casa_case) { create(:casa_case, casa_org: organization) }
  let!(:case_contact) { create(:case_contact, duration_minutes: 105, casa_case: casa_case) }

  it "successfully renders the table header and table body as the same width" do
    admin = create(:casa_admin, casa_org: organization)
    sign_in admin

    visit case_contacts_path

    table_header = all(".case-contacts-table").first
    table_body = all(".case-contacts-table").last

    width = ->(element) { specified_style_attributes(element)["width"] }

    expect(width.call(table_header)).to eq(width.call(table_body))

    # Resize page and check again
    page.driver.browser.manage.window.resize_to(2000, 2000)
    expect(width.call(table_header)).to eq(width.call(table_body))
  end
end
