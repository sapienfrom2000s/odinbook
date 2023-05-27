require 'rails_helper'

RSpec.describe User, type: :model do
  context "unable to create a user instance" do
    it "when username is passed with the format of email" do
      expect{ User.create(username:'bcom@com',email:'blabl@bla.com', password:'somethingsimple') }.to_not change{ User.count }
    end

    it "when blank username is passed" do
      expect{ User.create(username:'',email:'something@b.com',password:'1ams8rong') }.to_not change{ User.count }
    end

    it "when invalid format of email is passed" do
      expect{ User.create(username:'qla',email:'something',password:'1ams8rong') }.to_not change{ User.count }
      expect{ User.create(username:'sla',email:'something@@b.com',password:'1ams8rong') }.to_not change{ User.count }
      expect{ User.create(username:'kla',email:'@bolo.com',password:'1ams8rong') }.to_not change{ User.count }
    end

    it "when password is of length less than 6" do
      expect{ User.create(username:'qla',email:'something',password:'six') }.to_not change{ User.count }      
    end
  end

  context "able to create user instance" do
    it "when username and email is normal with password of atleast length 6" do
      expect{ User.create(username:'bla', email:'nothing@nothing', password:'1ams8trong')}.to change{ User.count }
    end
  end
end
