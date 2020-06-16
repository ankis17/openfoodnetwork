require 'spec_helper'

describe "Zones" do
  include AuthenticationWorkflow

  before do
    quick_login_as_admin
    Spree::Zone.delete_all
  end

  scenario "list existing zones" do
    visit spree.admin_dashboard_path
    click_link "Configuration"

    create(:zone, name: "eastern", description: "zone is eastern")
    create(:zone, name: "western", description: "cool san fran")
    click_link "Zones"

    within_row(1) { expect(page).to have_content("eastern") }
    within_row(2) { expect(page).to have_content("western") }

    click_link "zones_order_by_description_title"

    within_row(1) { expect(page).to have_content("western") }
    within_row(2) { expect(page).to have_content("eastern") }
  end

  scenario "create a new zone" do
    visit spree.admin_zones_path
    click_link "admin_new_zone_link"
    expect(page).to have_content("New Zone")

    fill_in "zone_name", with: "japan"
    fill_in "zone_description", with: "japanese time zone"
    click_button "Create"

    expect(page).to have_content("successfully created!")
  end
end
