require 'rails_helper'

describe Hunt  do
  describe 'validations' do
    let (:hunt) { create :hunt }

    it 'has valid factory' do
      expect(hunt).to be_valid
    end

    describe '.title' do
      it 'must be a string' do
        hunt.title = 1234567
        expect(hunt.title.class).to eq(String)
        hunt.title = []
        expect(hunt.title.class).to eq(String)
        hunt.title = {}
        expect(hunt.title.class).to eq(String)
        hunt.title = 'atitle'
        expect(hunt.title.class).to eq(String)
      end

      it "can't be nil" do
        hunt.title = nil
        expect(hunt).to_not be_valid
      end

      it "can't be blank" do
        hunt.title = ''
        expect(hunt).to_not be_valid
      end

      it 'length must be between 6 and 50 characters' do
        hunt.title = 'short'
        expect(hunt).to_not be_valid
        hunt.title = 'itsanextremlytoolongtitlethatisnotallowedtopasstest'
        expect(hunt).to_not be_valid
        hunt.title = 'valide'
        expect(hunt).to be_valid
        hunt.title = 'xitsanextremlylongtitlethatisallowedtopassthetestx'
        expect(hunt).to be_valid
      end
    end

    describe '.datetime' do
      it "can't be nil" do
        hunt.datetime = nil
        expect(hunt).to_not be_valid
      end

      it "can't be empty" do
        hunt.datetime = ''
        expect(hunt).to_not be_valid
      end

      it 'test time' do
        'DD/MM/YYYY, HH:mm'
      end
    end

    describe '.duration' do
      it "can't be nil" do
        hunt.duration = nil
        expect(hunt).to_not be_valid
      end

      it "can't be empty" do
        hunt.duration = ''
        expect(hunt).to_not be_valid
      end

      it 'must be an integer' do
        hunt.duration = []
        expect(hunt.duration.class).to_not eq(Array)
        hunt.duration = {}
        expect(hunt.duration.class).to_not eq(Hash)
        hunt.duration = 'duration'
        expect(hunt.duration.class).to_not eq(String)
        hunt.duration = 5
        expect(hunt.duration.class).to eq(Integer)
      end

      it 'number must be between 1 and 12' do
        hunt.duration = 0
        expect(hunt).to_not be_valid
        hunt.duration = 25
        expect(hunt).to_not be_valid
        (1..24).each do |i|
          hunt.duration = i
          expect(hunt).to be_valid
        end
      end
    end

    describe '.max_hunter' do
      it "can't be nil" do
        hunt.max_hunter = nil
        expect(hunt).to_not be_valid
      end

      it "can't be empty" do
        hunt.max_hunter = ''
        expect(hunt).to_not be_valid
      end

      it 'must be an integer' do
        hunt.max_hunter = []
        expect(hunt.max_hunter.class).to_not eq(Array)
        hunt.max_hunter = {}
        expect(hunt.max_hunter.class).to_not eq(Hash)
        hunt.max_hunter = 'max_hunter'
        expect(hunt.max_hunter.class).to_not eq(String)
        hunt.max_hunter = 5
        expect(hunt.max_hunter.class).to eq(Integer)
      end

      it 'number must be between 2 and 16' do
        hunt.max_hunter = 1
        expect(hunt).to_not be_valid
        hunt.max_hunter = 17
        expect(hunt).to_not be_valid
        (2..16).each do |i|
          hunt.max_hunter = i
          expect(hunt).to be_valid
        end
      end
    end

    describe '.platform' do
      it "can't be nil" do
        hunt.platform = nil
        expect(hunt).to_not be_valid
      end

      it "can't be empty" do
        hunt.platform = ''
        expect(hunt).to_not be_valid
      end

      it 'must be a string' do
        hunt.platform = 1234567
        expect(hunt.platform.class).to eq(String)
        hunt.platform = []
        expect(hunt.platform.class).to eq(String)
        hunt.platform = {}
        expect(hunt.platform.class).to eq(String)
        hunt.platform = 'ps4'
        expect(hunt.platform.class).to eq(String)
      end

      it 'can be xbox, ps4 or pc' do
        valid_platform = ['xbox', 'ps4', 'pc']
        valid_platform.each do |platform|
          hunt.platform = platform
          expect(hunt).to be_valid
        end
      end

      it "can't be random string" do
        invalid_platform = ['switch', 'ps3', 'ps5', 'randomname']
        invalid_platform.each do |platform|
          hunt.platform = platform
          expect(hunt).to_not be_valid
        end
      end
    end

    describe '.description' do
      it 'can be nil' do
        hunt.description = nil
        expect(hunt).to be_valid
      end

      it 'can be blank' do
        hunt.description = ''
        expect(hunt).to be_valid
      end

      it 'must be a string' do
        hunt.description = 123456789123456
        expect(hunt.description.class).to eq(String)
        hunt.description = []
        expect(hunt.description.class).to eq(String)
        hunt.description = {}
        expect(hunt.description.class).to eq(String)
        hunt.description = '123456789123456'
        expect(hunt.description.class).to eq(String)
      end

      it 'length must be more between 15 and 500 characters' do
        hunt.description = 'Lorem ipsum do'
        expect(hunt).to_not be_valid
        hunt.description = "x" * 501
        expect(hunt).to_not be_valid
        hunt.description = 'Lorem ipsum dol'
        expect(hunt).to be_valid
        hunt.description = "x" * 500
        expect(hunt).to be_valid
      end
    end

    describe '.sid' do
      it 'can be nil' do
        hunt.sid = nil
        expect(hunt).to be_valid
      end

      it "can't be blank" do
        hunt.sid = ''
        expect(hunt).to_not be_valid
      end

      it 'must be a string' do
        hunt.sid = 123456789123
        expect(hunt.sid.class).to eq(String)
        hunt.sid = []
        expect(hunt.sid.class).to eq(String)
        hunt.sid = {}
        expect(hunt.sid.class).to eq(String)
        hunt.sid = '123456789123'
        expect(hunt.sid.class).to eq(String)
      end

      it 'length must be 12 characters' do
        hunt.sid = 'elevenchara'
        expect(hunt).to_not be_valid
        hunt.sid = 'thirteenchara'
        expect(hunt).to_not be_valid
        hunt.sid = 'twelvecharac'
        expect(hunt).to be_valid
      end
    end

    describe '.voice_chat' do
      it 'can be nil' do
        hunt.voice_chat = nil
        expect(hunt).to be_valid
      end

      it 'can be blank' do
        hunt.voice_chat = ''
        expect(hunt).to be_valid
      end

      it 'must be a string' do
        hunt.voice_chat = 12345678912345
        expect(hunt.voice_chat.class).to eq(String)
        hunt.voice_chat = []
        expect(hunt.voice_chat.class).to eq(String)
        hunt.voice_chat = {}
        expect(hunt.voice_chat.class).to eq(String)
        hunt.voice_chat = '12345678912345'
        expect(hunt.voice_chat.class).to eq(String)
      end

      it 'length must be between 5 and 30 characters' do
        hunt.voice_chat = 'char'
        expect(hunt).to_not be_valid
        hunt.voice_chat = 'thirty one characters not valid'
        expect(hunt).to_not be_valid
        hunt.voice_chat = 'chara'
        expect(hunt).to be_valid
        hunt.voice_chat = 'thirty characters valid string'
        expect(hunt).to be_valid
      end
    end

    describe '.lang' do
      it 'can be nil' do
        hunt.lang = nil
        expect(hunt).to be_valid
      end

      it 'can be blank' do
        hunt.lang = ''
        expect(hunt).to be_valid
      end

      it 'return nil if voice_chat is blank or nil' do
        hunt.voice_chat = nil
        hunt.lang = 'fra'
        expect(hunt.lang).to be_nil
        hunt.voice_chat = ''
        hunt.lang = 'fra'
        expect(hunt.lang).to be_nil
      end

      it 'must be one of authorized language' do
        hunt.voice_chat = 'thisisvoicechat'
        valid_lang = ['fra', 'eng', 'spa', 'deu', 'ita', 'pol', 'rus', 'jpn', 'zho', 'kor', 'por', 'ara']
        valid_lang.each do |lang|
          hunt.lang = lang
          expect(hunt).to be_valid
        end
      end

      it "must be invalid if unauthorized lang param" do
        hunt.voice_chat = 'thisisvoicechat'
          hunt.lang = 'xxx'
          expect(hunt).to_not be_valid
          hunt.lang = 123
          expect(hunt).to_not be_valid
          hunt.lang = []
          expect(hunt).to_not be_valid
          hunt.lang = {}
          expect(hunt).to_not be_valid
      end
    end

    describe '.mic' do
      it 'must be true or false' do
        hunt.mic = true
        expect(hunt).to be_valid
        hunt.mic = false
        expect(hunt).to be_valid
      end

      it 'must be false by default' do
        expect(hunt.mic).to be_falsy
      end
    end

    describe '.hunters' do
      it "can't include the leader" do
        hunt.hunters << hunt.leader
        expect(hunt).to_not be_valid
      end
    end
  end
end
