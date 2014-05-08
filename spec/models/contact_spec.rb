require 'spec_helper'

describe Contact do
  it "#1.is valid with a firstname, lastname and email" do
    #contact = Contact.new(
    #  firstname: 'Aaron',
    #  lastname: 'Sumner',
    #  email: 'tester@example.com')
    #expect(contact).to be_valid
    expect(build(:contact)).to be_valid
  end
  it "#2.is invalid without a firstname" do
    #expect(Contact.new(firstname: nil)).to have(1).errors_on(:firstname)
    contact = build(:contact, firstname:nil)
    expect(contact).to have(1).errors_on(:firstname)
  end
  it "#3.is invalid without a lastname" do
    #expect(Contact.new(lastname: nil)).to have(1).errors_on(:lastname)
    contact = build(:contact, lastname:nil)
    expect(contact).to have(1).errors_on(:lastname)
  end
  it "#4.is invalid without an email address" do
    #expect(Contact.new(email: nil)).to have(1).errors_on(:email)
    contact = build(:contact, email:nil)
    expect(contact).to have(1).errors_on(:email)
  end
  it "#5.is invalid with a duplicate email address" do
    #Contact.create(
    #  firstname: 'Joe', lastname: 'Tester',
    #    email: 'tester@example.com')
    #  contact = Contact.new(
    #    firstname: 'Jane', lastname: 'Tester',
    #    email: 'tester@example.com')
    create(:contact, email: 'tester@example.com')
    contact = build(:contact, email: 'tester@example.com')
    expect(contact).to have(1).errors_on(:email)
  end
  it "#6.returns a contact's full name as a string" do
    #contact = Contact.new(firstname: 'John', lastname: 'Doe',
    #                     email:'johndoe@example.com')
    contact = build(:contact, firstname: 'John', lastname: 'Doe')
    expect(contact.name).to eq 'John Doe'
  end

  it "#7.return a sorted array of results that match" do
    #smith = Contact.create(firstname: 'John', lastname: 'Smith',
    #  email: 'jsmith@example.com')
    smith = create(:contact, firstname: 'John', lastname: 'Simth')
    #jones = Contact.create(firstname: 'Tim', lastname: 'Jones',
    #  email: 'tjones@example.com')
    jones = create(:contact, firstname: 'Tim', lastname: 'Jones')
    #johnson = Contact.create(firstname: 'John', lastname: 'Johnson',
    #  email: 'jjohnson@example.com')
    #這裡的測試，在Contact加上一個contact要有三個phone後，舊的寫法測試就失敗了
    #但是失敗的顯示看不出來是因為這個原因，這裡要怎麼處理?
    johnson = create(:contact, firstname: 'John', lastname: 'Johnson')
    expect(Contact.by_letter("J")).to eq [johnson, jones]
    expect(Contact.by_letter("J")).to_not include smith
  end

  it "#8.has a valid factory" do
    expect(build(:contact)).to be_valid
  end

  it "#9.has three phone numbers" do
    expect(create(:contact).phones.count).to eq 3
  end

  describe "filter last name by letter" do
    before :each do
      @smith = create(:contact, firstname: 'John', lastname: 'Smith', email: 'jsmith@example.com')
      @jones = create(:contact, firstname: 'Tim', lastname: 'Jones', email: 'tjones@example.com')
      @johnson = create(:contact, firstname: 'John', lastname: 'Johnson', email: 'jjohnson@example.com')
    end
    context "matching letters" do
      it "return a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    context "non-matching letters" do
      it "only returns contacts with the provided starting letter" do
        expect(Contact.by_letter("J")).to_not include @smith
      end
    end
  end
end
