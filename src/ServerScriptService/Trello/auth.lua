-- Getting the KEY/TOKEN pair:

-- The KEY field is MANDATORY: You can get yours here: https://trello.com/app-key

-- The TOKEN field is MANDATORY when:
-- -- You're trying to access a private board;
-- -- You're trying to write to a board (private or not).
-- You can leave it as an empty string if you're only READING FROM A PUBLIC BOARD.

-- Get your token here: https://trello.com/1/authorize?expiration=never&scope=read,write&response_type=token&name=Your%20Trello%20Application&key=<YOUR KEY HERE>

local KEY = "7d2844501f40a5aa6c1b373946113cf4"
local TOKEN = "e2c4c4c98eb6212a92cdd840c74c7e4d6455c732c62db0ebac80fc844246f063"

return "?key="..KEY.."&token="..TOKEN
