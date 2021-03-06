require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    Capybara.add_selector(:row) do
      xpath { |num| ".//tbody/tr[#{num}]" }
    end

    @user = users(:one)
  end

  test 'visiting the index' do
    visit users_url
    assert_selector 'h1', text: 'Users'
  end

  test 'creating a User' do
    visit users_url
    click_on 'New User'

    input = find('input#user_name')
    input.set(@user.name)

    click_on 'Create User'

    assert_text 'User was successfully created'
    click_on 'Back'
  end

  test 'updating a User' do
    visit users_url
    click_on 'Edit', match: :first

    click_on 'Update User'

    assert_text 'User was successfully updated'
    click_on 'Back'
  end

  test 'destroying a User' do
    visit users_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'User was successfully destroyed'
  end

  test 'add_selector' do
    visit users_url

    row = find(:row, 3)
    assert_not_nil(row)
  end

  test 'visiting the index2' do
    visit users_url
    click_on 'New User'

    field = find('input#user_name').ancestor('.field')
    assert_not_nil(field)
  end

  test 'visiting the index2 xpath' do
    visit users_url
    click_on 'New User'

    field = find('input[id="user_name"]').ancestor('.field', match: :first)
    assert_not_nil(field)
  end

  test 'sibiling' do
    visit users_url
    sib2 = find('.sib1').sibling('.sib2', match: :one)
    sib3 = find('.sib1').sibling('.sib3')
    assert_not_nil(sib2)
    assert_not_nil(sib3)

    sib2 = find('div[class="sib1"]').sibling('div[class="sib2"]', match: :one)
    sib3 = find('div[class="sib1"]').sibling('div[class="sib3"]', match: :one)
    assert_not_nil(sib2)
    assert_not_nil(sib3)
  end

  test 'creating a User 2' do
    visit users_url
    click_on 'New User'

    input = find('input#user_name')
    input.set(@user.name)

    submit_button = find('input[value="Create User"]')
    submit_button.click

    assert_text 'User was successfully created'
    click_on 'Back'
  end

  test 'find_button find_link' do
    visit users_url

    new_user_link = find_link(text: 'New User')
    new_user_link.click

    input = find('input#user_name')
    input.set(@user.name)

    button = find_button(value:'Create User')
    button.click

    assert_text 'User was successfully created'
    click_on 'Back'
  end

  test 'find_by_id' do
    visit users_url

    find_by_id('id_ans')
  end

  test 'find_field' do
    visit users_url
    click_on 'New User'

    find('.field')
    find_field(name: 'user[name]')
    find_field('Name')
  end

  test 'checked? check' do
    visit users_url

    assert_equal(false, find('input#page_freezeflag').checked?)

    cb =  find('input#page_freezeflag')
    cb.check

    assert_equal(true, find('input#page_freezeflag').checked?)

    cb.uncheck

    assert_equal(false, find('input#page_freezeflag').checked?)
  end

  test 'choose' do
    visit users_url

    rb = find('#radio_category_socrates')
    assert_equal(false, rb.checked?)
    rb.choose
    assert_equal(true, rb.checked?)
  end

  test 'select unselect' do
    visit users_url

    assert_equal('', find('#single_select').value)
    find('#single_select').select('select1')
    assert_equal('select1', find('#single_select').value)
    find('#single_select').select('select2')
    assert_equal('select2', find('#single_select').value)

    find('#multiple_select').select('select1')
    assert_equal(['select1'], find('#multiple_select').value)
    find('#multiple_select').select('select2')
    assert_equal(['select1','select2'], find('#multiple_select').value)

    find('#multiple_select').unselect('select1')
    assert_equal(['select2'], find('#multiple_select').value)
    find('#multiple_select').unselect('select2')
    assert_equal([], find('#multiple_select').value)
  end

  test 'attach_file' do
    visit users_url

    assert_equal('', find('#attachment').value)
    attach_file(:attachment, "#{Rails.root}/test/fixtures/files/attach.png")
    assert_equal(true, find('#attachment').value.include?('attach.png'))
  end

  test 'fill_in' do
    visit users_url

    text_area =  find('textarea#textarea_id')
    assert_equal('', text_area.value)

    text_area.fill_in(with:'hogehogehugahuga')
    assert_equal('hogehogehugahuga', text_area.value)

    page.fill_in('text_area_name', with:'hoge')
    assert_equal('hoge', text_area.value)

    page.fill_in('textarea_label_name', with:'huga')
    assert_equal('huga', text_area.value)

    page.fill_in(:text_area_name, with:'hoge')
    assert_equal('hoge', text_area.value)

    page.fill_in(:textarea_label_name, with:'huga')
    assert_equal('huga', text_area.value)

    text_area.set('select')
    assert_equal('select', text_area.value)
  end

  test 'multiple?' do
    visit users_url

    assert_equal(true, find('#multiple_select').multiple?)
  end

  test 'tag_name' do
    visit users_url

    assert_equal('select', find('#multiple_select').tag_name)
  end

  test 'Document page current_path' do
    visit users_url

    assert_equal('Kata', page.title)
    assert_equal(true, page == Capybara.current_session)

    assert_equal('/users', current_path)

    visit new_user_path

    assert_equal('/users/new', current_path)

    go_back

    assert_equal('/users', current_path)

    go_forward

    assert_equal('/users/new', current_path)
  end

  test 'within_table' do
    visit users_url

    within_table('table_test') do
      find('td#table_cell1')
    end
  end

  test 'save_(screenshot|page)' do
    visit users_url

    page.save_screenshot
    page.save_page
    page.save_screenshot('hoge.png')
    page.save_page('huga')
  end

  test 'edit selector' do
    assert_equal(true, Capybara::Selector.all.include?(:row))

    Capybara::Selector.update(:row) do
      css{'.hoge'}
    end

    visit users_url

    find = find('div.hoge')
    updated_selector =  find(:row)

    assert_equal(find, updated_selector)

    find_xpath = find(:xpath, '//div[@class="hoge"]')
    assert_equal(find_xpath, updated_selector)

    Capybara::Selector.remove('row')
    assert_equal(false, Capybara::Selector.all.include?(:row))
  end

  test 'windows' do
    assert_equal(1, page.windows.count)
    page.open_new_window
    assert_equal(2, page.windows.count)
    assert_equal(current_window, page.windows[0])
    switch_to_window(page.windows[1])
    assert_equal(current_window, page.windows[1])
  end

  test 'matchers'  do
    visit users_url
    assert_no_text('it_is_no_matcher_long_string_hohoho')
    assert_selector('div.hoge')
    assert_no_css('div#thre_is_no_id')
    assert_link('New User')
  end

  test 'accept_alert accept_confirm accept_prompt dismiss_confirm dismiss_prompt' do
    visit users_url

    dismiss_prompt('Are you sure?') do
      click_on('Destroy', match: :first)
    end
    assert_no_text 'User was successfully destroyed'

    dismiss_confirm('Are you sure?') do
      click_on('Destroy', match: :first)
    end
    assert_no_text 'User was successfully destroyed'



    accept_prompt('Are you sure?') do
      click_on('Destroy', match: :first)
    end
    assert_text 'User was successfully destroyed'

    accept_alert('Are you sure?') do
      click_on('Destroy', match: :first)
    end
    assert_text 'User was successfully destroyed'

    accept_confirm('Are you sure?') do
      click_on('Destroy', match: :first)
    end
    assert_text 'User was successfully destroyed'
  end

  test 'result' do
    visit users_url
    sibs = all('.sib1')
    assert_not_nil(sibs.failure_message)
    assert_not_nil(sibs.negative_failure_message)
    assert_equal(true, sibs.matches_count?)
    assert_equal(false, sibs.empty?)
    assert_equal(1, sibs.count)
  end

  test 'read native' do
    visit users_url
    row = find(:row, 3)
    assert_equal('tr', row.native.tag_name)
    assert_equal('Show Edit Destroy', row.native.text)
    assert_equal(Selenium::WebDriver::Element, row.native.class)
    assert_equal(Capybara::Node::Element, row.class)
    assert_equal('/HTML/BODY/TABLE[1]/TBODY/TR[3]', row.path)
  end

  test 'add_selector with css' do
    visit users_url

    Capybara.add_selector(:table_test_css) do
      css { |type| "#test_div_tag.#{type}" }
    end

    assert_not_nil(find(:table_test_css, 'hogehuga'))
  end

  test 'xpath with div id(failed)' do
    # assert_not_nil(find(:xpath, '//div[@id="test_div_tag"]'))
    # assert_xpath('div[id="test_div_tag"]')
    # assert_xpath('div[@id="test_div_tag"]')
  end
end
