module AsyncEnglish
    class Commands 
        class << self
          def start; "All I can do is say hello. Try the /greet command."; end 
          def greet(first_name) "Hello, #{first_name}. 🤖"; end

          def word
            begin
              wordToSearch = 'home'
              url = 'https://wordsapiv1.p.mashape.com/words/' + wordToSearch + '/definitions'
              uri = URI(url)
              resp = Net::HTTP.get(uri)
              jsonResp = JSON.parse(resp)
            rescue
              definition = "Oops! failed to load: " + resp.to_s
            end
      
            definition
          end 

          def qod; "Quote of the day here..." end

          def help 
            [
              "Hello dear, we have some commands to help you interact with me 🤖",
              "/start => I'll say hello",
              "/greet => I'll say hello for you",
              "/word <word> => Find definitions of the given word in WordAPI",
              "/qod => Give a random quote of the day",
              "/help => Show this help"
            ].join("\n")
          end
          
          def get_message(message) 
              command = message.text
              case message.text
                when /start/i then start
                when /greet/i then greet(message.from.first_name)
                when /word/i then word
                when /qod/i then qod
                when /help/i then help
                else "I have no idea what #{message.text} means."
              end
          end 
        end
    end
end
