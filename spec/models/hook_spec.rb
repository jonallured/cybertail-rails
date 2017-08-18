require 'rails_helper'

describe Hook do
  describe ".most_recent_for" do
    it "only returns hooks for that user" do
      user = FactoryGirl.create :user
      my_hook = FactoryGirl.create :hook
      FactoryGirl.create :subscription, user: user, project: my_hook.project
      other_hook = FactoryGirl.create :hook

      hooks = Hook.most_recent_for(user.id)

      expect(hooks).to include(my_hook)
      expect(hooks).to_not include(other_hook)
    end

    it "only returns up to the limit" do
      user = FactoryGirl.create :user

      10.times do
        hook = FactoryGirl.create :hook
        FactoryGirl.create :subscription, user: user, project: hook.project
      end

      limit = 1
      hooks = Hook.most_recent_for(user.id, limit)

      expect(hooks.count).to eq limit
    end

    it "sorts them with newest first" do
      user = FactoryGirl.create :user

      first_hook = FactoryGirl.create :hook
      FactoryGirl.create :subscription, user: user, project: first_hook.project

      second_hook = FactoryGirl.create :hook
      FactoryGirl.create :subscription, user: user, project: second_hook.project

      third_hook = FactoryGirl.create :hook
      FactoryGirl.create :subscription, user: user, project: third_hook.project

      hooks = Hook.most_recent_for(user.id)

      expect(hooks).to eq [third_hook, second_hook, first_hook]
    end

    it "does not return suppressed hooks" do
      user = FactoryGirl.create :user

      hook = FactoryGirl.create :hook, suppress: true
      FactoryGirl.create :subscription, user: user, project: hook.project

      hooks = Hook.most_recent_for(user.id)

      expect(hooks).to_not include(hook)
    end
  end
end
