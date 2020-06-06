-- TOTAL NOTES: 701
-- TOTAL HOLDS: 68
-- AVERAGE NPS: 11.6833333333333
-- MAX NPS: 19.5
-- SONG LENGTH: 58.398
 
local rtv = {}
rtv.totalNotes = 701
rtv.totalHolds = 68
rtv.averageNps = 11.6833333333333
rtv.maxNps = 19.5
rtv.songLength = 58.398
rtv.AudioAssetId = "rbxassetid://625594987"
rtv.AudioFilename = "Re:QUEST!"
rtv.AudioDescription = ""
rtv.AudioCoverImageAssetId = ""
rtv.AudioArtist = ""
rtv.AudioDifficulty = 1
rtv.AudioTimeOffset = 30
rtv.AudioVolume = 0.7
rtv.AudioNotePrebufferTime = 780
rtv.AudioMod = 0
rtv.AudioHitSFXGroup = 0
local maxPoints = 0
local grades = require(game.ReplicatedStorage.AudioData.Grades)
rtv.AudioRanks = grades.GetAudioRanks(maxPoints)
rtv.HitObjects = {}
do
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 549; Type = 1; Track = 4; } --#0
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 549; Type = 2; Duration = 1000; Track = 2; } --#1
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 549; Type = 1; Track = 1; } --#2
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 549; Type = 2; Duration = 500; Track = 3; } --#3
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 1049; Type = 2; Duration = 500; Track = 4; } --#4
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 1549; Type = 2; Duration = 1000; Track = 1; } --#5
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 1549; Type = 2; Duration = 750; Track = 3; } --#6
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 2299; Type = 1; Track = 4; } --#7
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 2549; Type = 2; Duration = 750; Track = 2; } --#8
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 2549; Type = 1; Track = 3; } --#9
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 2549; Type = 2; Duration = 1916; Track = 4; } --#10
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 3299; Type = 1; Track = 1; } --#11
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 3549; Type = 2; Duration = 916; Track = 1; } --#12
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 3549; Type = 1; Track = 3; } --#13
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 3549; Type = 1; Track = 2; } --#14
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 4549; Type = 1; Track = 4; } --#15
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 4549; Type = 2; Duration = 500; Track = 1; } --#16
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 4549; Type = 2; Duration = 1000; Track = 3; } --#17
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 4549; Type = 1; Track = 2; } --#18
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 5049; Type = 2; Duration = 500; Track = 2; } --#19
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 5549; Type = 2; Duration = 916; Track = 1; } --#20
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 5549; Type = 2; Duration = 750; Track = 4; } --#21
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 6299; Type = 1; Track = 3; } --#22
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 6424; Type = 1; Track = 4; } --#23
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 6549; Type = 2; Duration = 1000; Track = 2; } --#24
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 6549; Type = 1; Track = 1; } --#25
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 6549; Type = 2; Duration = 750; Track = 3; } --#26
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 6549; Type = 1; Track = 4; } --#27
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 7299; Type = 1; Track = 4; } --#28
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 7549; Type = 2; Duration = 916; Track = 3; } --#29
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 7549; Type = 2; Duration = 916; Track = 4; } --#30
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 8549; Type = 2; Duration = 750; Track = 2; } --#31
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 8549; Type = 1; Track = 1; } --#32
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 8549; Type = 1; Track = 4; } --#33
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 8549; Type = 2; Duration = 1000; Track = 3; } --#34
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 9049; Type = 1; Track = 4; } --#35
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 9299; Type = 1; Track = 1; } --#36
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 9424; Type = 1; Track = 2; } --#37
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 9549; Type = 2; Duration = 250; Track = 4; } --#38
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 9549; Type = 2; Duration = 250; Track = 2; } --#39
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 9549; Type = 2; Duration = 250; Track = 1; } --#40
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 10049; Type = 2; Duration = 250; Track = 3; } --#41
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 10049; Type = 2; Duration = 250; Track = 2; } --#42
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 10049; Type = 2; Duration = 250; Track = 4; } --#43
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 10549; Type = 2; Duration = 250; Track = 2; } --#44
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 10549; Type = 2; Duration = 250; Track = 1; } --#45
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 10549; Type = 2; Duration = 250; Track = 3; } --#46
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 11049; Type = 1; Track = 2; } --#47
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 11049; Type = 1; Track = 3; } --#48
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 11049; Type = 2; Duration = 500; Track = 4; } --#49
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 11299; Type = 1; Track = 2; } --#50
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 11549; Type = 1; Track = 1; } --#51
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 11549; Type = 1; Track = 2; } --#52
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 11549; Type = 2; Duration = 500; Track = 3; } --#53
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 11799; Type = 1; Track = 1; } --#54
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 12049; Type = 1; Track = 4; } --#55
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 12049; Type = 1; Track = 1; } --#56
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 12049; Type = 2; Duration = 500; Track = 2; } --#57
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 12299; Type = 1; Track = 3; } --#58
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 12424; Type = 1; Track = 3; } --#59
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 12549; Type = 2; Duration = 1916; Track = 3; } --#60
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 12549; Type = 2; Duration = 1916; Track = 4; } --#61
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 12549; Type = 2; Duration = 1916; Track = 1; } --#62
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 14549; Type = 2; Duration = 1875; Track = 1; } --#63
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 14549; Type = 2; Duration = 1875; Track = 3; } --#64
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 14549; Type = 2; Duration = 1875; Track = 2; } --#65
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 16527; Type = 1; Track = 1; } --#66
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 16588; Type = 1; Track = 2; } --#67
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 16649; Type = 1; Track = 3; } --#68
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 16711; Type = 1; Track = 4; } --#69
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 16772; Type = 1; Track = 1; } --#70
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 16833; Type = 1; Track = 2; } --#71
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 16895; Type = 1; Track = 3; } --#72
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 16956; Type = 1; Track = 2; } --#73
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17017; Type = 1; Track = 4; } --#74
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17079; Type = 1; Track = 3; } --#75
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17140; Type = 1; Track = 2; } --#76
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17201; Type = 1; Track = 1; } --#77
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17263; Type = 1; Track = 4; } --#78
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17324; Type = 1; Track = 3; } --#79
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17385; Type = 1; Track = 2; } --#80
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17447; Type = 1; Track = 3; } --#81
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17508; Type = 1; Track = 1; } --#82
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17569; Type = 1; Track = 2; } --#83
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17631; Type = 1; Track = 3; } --#84
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17692; Type = 1; Track = 4; } --#85
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17753; Type = 1; Track = 1; } --#86
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17815; Type = 1; Track = 2; } --#87
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17876; Type = 1; Track = 3; } --#88
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17938; Type = 1; Track = 4; } --#89
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17999; Type = 1; Track = 2; } --#90
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 17999; Type = 1; Track = 1; } --#91
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18091; Type = 1; Track = 3; } --#92
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18091; Type = 1; Track = 4; } --#93
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18183; Type = 1; Track = 2; } --#94
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18183; Type = 1; Track = 1; } --#95
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18275; Type = 1; Track = 2; } --#96
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18275; Type = 1; Track = 3; } --#97
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18367; Type = 1; Track = 4; } --#98
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18459; Type = 1; Track = 1; } --#99
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18459; Type = 1; Track = 2; } --#100
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18551; Type = 1; Track = 3; } --#101
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18551; Type = 1; Track = 4; } --#102
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18643; Type = 1; Track = 2; } --#103
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18643; Type = 1; Track = 3; } --#104
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18735; Type = 1; Track = 4; } --#105
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18827; Type = 1; Track = 1; } --#106
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18827; Type = 1; Track = 2; } --#107
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18919; Type = 1; Track = 4; } --#108
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 18919; Type = 1; Track = 3; } --#109
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19011; Type = 1; Track = 1; } --#110
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19011; Type = 1; Track = 2; } --#111
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19103; Type = 1; Track = 4; } --#112
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19195; Type = 1; Track = 3; } --#113
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19195; Type = 1; Track = 2; } --#114
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19287; Type = 1; Track = 1; } --#115
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19287; Type = 1; Track = 2; } --#116
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19379; Type = 1; Track = 4; } --#117
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19471; Type = 1; Track = 3; } --#118
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19471; Type = 1; Track = 1; } --#119
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19471; Type = 1; Track = 2; } --#120
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19655; Type = 1; Track = 1; } --#121
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19655; Type = 1; Track = 3; } --#122
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19655; Type = 1; Track = 4; } --#123
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19839; Type = 1; Track = 1; } --#124
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19839; Type = 1; Track = 2; } --#125
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19931; Type = 1; Track = 2; } --#126
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 19931; Type = 1; Track = 3; } --#127
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20023; Type = 1; Track = 4; } --#128
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20115; Type = 1; Track = 2; } --#129
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20115; Type = 1; Track = 3; } --#130
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20115; Type = 1; Track = 1; } --#131
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20300; Type = 1; Track = 4; } --#132
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20300; Type = 1; Track = 3; } --#133
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20392; Type = 1; Track = 2; } --#134
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20392; Type = 1; Track = 1; } --#135
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20484; Type = 1; Track = 2; } --#136
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20484; Type = 1; Track = 3; } --#137
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20576; Type = 1; Track = 1; } --#138
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20576; Type = 1; Track = 4; } --#139
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20760; Type = 1; Track = 4; } --#140
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20760; Type = 1; Track = 3; } --#141
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20852; Type = 1; Track = 2; } --#142
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20852; Type = 1; Track = 1; } --#143
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20944; Type = 2; Duration = 184; Track = 3; } --#144
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 20944; Type = 1; Track = 2; } --#145
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21128; Type = 2; Duration = 184; Track = 4; } --#146
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21128; Type = 1; Track = 1; } --#147
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21312; Type = 1; Track = 3; } --#148
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21312; Type = 2; Duration = 184; Track = 2; } --#149
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21404; Type = 1; Track = 4; } --#150
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21496; Type = 2; Duration = 184; Track = 1; } --#151
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21496; Type = 1; Track = 3; } --#152
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21657; Type = 1; Track = 2; } --#153
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21680; Type = 1; Track = 4; } --#154
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21680; Type = 2; Duration = 184; Track = 3; } --#155
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21864; Type = 1; Track = 1; } --#156
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21864; Type = 2; Duration = 184; Track = 2; } --#157
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 21956; Type = 1; Track = 3; } --#158
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22048; Type = 1; Track = 1; } --#159
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22048; Type = 2; Duration = 184; Track = 4; } --#160
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22140; Type = 1; Track = 2; } --#161
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22232; Type = 2; Duration = 184; Track = 3; } --#162
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22232; Type = 1; Track = 1; } --#163
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22416; Type = 2; Duration = 184; Track = 2; } --#164
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22416; Type = 1; Track = 4; } --#165
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22508; Type = 1; Track = 3; } --#166
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22600; Type = 1; Track = 4; } --#167
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22600; Type = 2; Duration = 184; Track = 1; } --#168
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22784; Type = 1; Track = 2; } --#169
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22784; Type = 1; Track = 3; } --#170
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22876; Type = 1; Track = 4; } --#171
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22968; Type = 1; Track = 3; } --#172
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 22968; Type = 1; Track = 2; } --#173
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23152; Type = 1; Track = 2; } --#174
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23152; Type = 1; Track = 1; } --#175
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23244; Type = 1; Track = 2; } --#176
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23244; Type = 1; Track = 1; } --#177
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23336; Type = 1; Track = 1; } --#178
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23336; Type = 1; Track = 2; } --#179
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23520; Type = 1; Track = 3; } --#180
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23520; Type = 1; Track = 4; } --#181
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23612; Type = 1; Track = 3; } --#182
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23612; Type = 1; Track = 4; } --#183
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23704; Type = 1; Track = 4; } --#184
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23704; Type = 1; Track = 3; } --#185
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23888; Type = 1; Track = 2; } --#186
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23888; Type = 1; Track = 1; } --#187
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23888; Type = 1; Track = 3; } --#188
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 23980; Type = 1; Track = 2; } --#189
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 24165; Type = 1; Track = 4; } --#190
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 24257; Type = 1; Track = 3; } --#191
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 24257; Type = 1; Track = 2; } --#192
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 24441; Type = 1; Track = 2; } --#193
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 24441; Type = 1; Track = 1; } --#194
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 24625; Type = 1; Track = 3; } --#195
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 24655; Type = 1; Track = 4; } --#196
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 24809; Type = 1; Track = 2; } --#197
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 24901; Type = 1; Track = 3; } --#198
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 24993; Type = 1; Track = 4; } --#199
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 24993; Type = 1; Track = 2; } --#200
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 25085; Type = 1; Track = 2; } --#201
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 25177; Type = 1; Track = 1; } --#202
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 25177; Type = 1; Track = 3; } --#203
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 25361; Type = 1; Track = 4; } --#204
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 25453; Type = 1; Track = 2; } --#205
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 25545; Type = 1; Track = 2; } --#206
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 25637; Type = 1; Track = 3; } --#207
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 25729; Type = 1; Track = 1; } --#208
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 25729; Type = 1; Track = 2; } --#209
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 25913; Type = 1; Track = 3; } --#210
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 26097; Type = 1; Track = 2; } --#211
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 26097; Type = 1; Track = 4; } --#212
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 26281; Type = 1; Track = 3; } --#213
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 26373; Type = 1; Track = 3; } --#214
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 26465; Type = 1; Track = 2; } --#215
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 26465; Type = 1; Track = 1; } --#216
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 26557; Type = 1; Track = 1; } --#217
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 26649; Type = 1; Track = 4; } --#218
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 26649; Type = 1; Track = 3; } --#219
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 26833; Type = 1; Track = 4; } --#220
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 26833; Type = 1; Track = 1; } --#221
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 26925; Type = 1; Track = 2; } --#222
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27017; Type = 1; Track = 3; } --#223
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27017; Type = 1; Track = 1; } --#224
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27109; Type = 1; Track = 4; } --#225
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27201; Type = 2; Duration = 368; Track = 2; } --#226
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27201; Type = 1; Track = 3; } --#227
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27569; Type = 1; Track = 4; } --#228
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27569; Type = 1; Track = 1; } --#229
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27661; Type = 1; Track = 3; } --#230
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27753; Type = 1; Track = 4; } --#231
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27753; Type = 1; Track = 2; } --#232
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27846; Type = 1; Track = 1; } --#233
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27938; Type = 2; Duration = 368; Track = 3; } --#234
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 27938; Type = 1; Track = 2; } --#235
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 28306; Type = 1; Track = 2; } --#236
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 28306; Type = 1; Track = 4; } --#237
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 28490; Type = 1; Track = 3; } --#238
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 28490; Type = 1; Track = 1; } --#239
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 28674; Type = 1; Track = 1; } --#240
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 28674; Type = 1; Track = 4; } --#241
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 28858; Type = 1; Track = 2; } --#242
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 28858; Type = 1; Track = 4; } --#243
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 29226; Type = 1; Track = 4; } --#244
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 29226; Type = 1; Track = 1; } --#245
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 29226; Type = 1; Track = 3; } --#246
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 29410; Type = 1; Track = 1; } --#247
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 29410; Type = 1; Track = 2; } --#248
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 29410; Type = 1; Track = 3; } --#249
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 29778; Type = 1; Track = 3; } --#250
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 29778; Type = 1; Track = 1; } --#251
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 29778; Type = 1; Track = 4; } --#252
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 29962; Type = 1; Track = 2; } --#253
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 29962; Type = 1; Track = 3; } --#254
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30054; Type = 1; Track = 1; } --#255
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30146; Type = 1; Track = 3; } --#256
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30146; Type = 1; Track = 4; } --#257
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30146; Type = 1; Track = 2; } --#258
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30330; Type = 1; Track = 4; } --#259
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30330; Type = 1; Track = 1; } --#260
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30422; Type = 1; Track = 2; } --#261
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30514; Type = 1; Track = 1; } --#262
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30514; Type = 1; Track = 4; } --#263
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30514; Type = 1; Track = 3; } --#264
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30698; Type = 1; Track = 4; } --#265
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30698; Type = 1; Track = 2; } --#266
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30790; Type = 1; Track = 3; } --#267
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30882; Type = 1; Track = 2; } --#268
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30882; Type = 1; Track = 1; } --#269
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 30882; Type = 1; Track = 4; } --#270
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31066; Type = 1; Track = 3; } --#271
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31066; Type = 1; Track = 2; } --#272
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31250; Type = 1; Track = 4; } --#273
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31250; Type = 1; Track = 2; } --#274
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31250; Type = 1; Track = 1; } --#275
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31434; Type = 1; Track = 2; } --#276
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31434; Type = 1; Track = 3; } --#277
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31526; Type = 1; Track = 4; } --#278
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31619; Type = 1; Track = 1; } --#279
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31619; Type = 1; Track = 3; } --#280
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31619; Type = 1; Track = 2; } --#281
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31803; Type = 1; Track = 1; } --#282
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31803; Type = 1; Track = 4; } --#283
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31895; Type = 1; Track = 3; } --#284
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31987; Type = 1; Track = 1; } --#285
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31987; Type = 1; Track = 4; } --#286
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 31987; Type = 1; Track = 2; } --#287
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32079; Type = 1; Track = 3; } --#288
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32171; Type = 1; Track = 1; } --#289
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32171; Type = 1; Track = 4; } --#290
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32263; Type = 1; Track = 2; } --#291
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32355; Type = 1; Track = 3; } --#292
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32355; Type = 1; Track = 2; } --#293
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32447; Type = 1; Track = 1; } --#294
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32539; Type = 1; Track = 4; } --#295
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32631; Type = 1; Track = 3; } --#296
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32723; Type = 1; Track = 2; } --#297
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32723; Type = 1; Track = 1; } --#298
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32907; Type = 2; Duration = 184; Track = 4; } --#299
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32907; Type = 1; Track = 1; } --#300
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 32999; Type = 1; Track = 2; } --#301
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 33091; Type = 2; Duration = 368; Track = 1; } --#302
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 33091; Type = 1; Track = 3; } --#303
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 33275; Type = 1; Track = 3; } --#304
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 33367; Type = 1; Track = 4; } --#305
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 33459; Type = 1; Track = 2; } --#306
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 33643; Type = 2; Duration = 184; Track = 4; } --#307
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 33643; Type = 1; Track = 3; } --#308
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 33735; Type = 1; Track = 1; } --#309
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 33827; Type = 2; Duration = 276; Track = 2; } --#310
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 33827; Type = 2; Duration = 276; Track = 3; } --#311
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34195; Type = 1; Track = 2; } --#312
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34195; Type = 1; Track = 1; } --#313
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34195; Type = 1; Track = 3; } --#314
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34318; Type = 1; Track = 2; } --#315
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34318; Type = 1; Track = 1; } --#316
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34441; Type = 1; Track = 3; } --#317
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34441; Type = 1; Track = 4; } --#318
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34563; Type = 1; Track = 2; } --#319
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34563; Type = 1; Track = 3; } --#320
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34563; Type = 1; Track = 4; } --#321
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34686; Type = 1; Track = 2; } --#322
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34686; Type = 1; Track = 1; } --#323
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34809; Type = 1; Track = 4; } --#324
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34809; Type = 1; Track = 3; } --#325
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34931; Type = 1; Track = 4; } --#326
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34931; Type = 1; Track = 1; } --#327
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 34931; Type = 1; Track = 2; } --#328
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35023; Type = 1; Track = 3; } --#329
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35115; Type = 1; Track = 2; } --#330
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35207; Type = 1; Track = 1; } --#331
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35300; Type = 1; Track = 4; } --#332
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35300; Type = 1; Track = 3; } --#333
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35392; Type = 1; Track = 2; } --#334
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35484; Type = 1; Track = 3; } --#335
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35576; Type = 1; Track = 4; } --#336
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35668; Type = 1; Track = 1; } --#337
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35668; Type = 1; Track = 3; } --#338
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35790; Type = 1; Track = 2; } --#339
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35913; Type = 1; Track = 2; } --#340
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 35913; Type = 1; Track = 3; } --#341
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 36036; Type = 1; Track = 3; } --#342
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 36036; Type = 1; Track = 4; } --#343
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 36158; Type = 1; Track = 1; } --#344
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 36158; Type = 1; Track = 2; } --#345
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 36281; Type = 1; Track = 1; } --#346
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 36281; Type = 1; Track = 2; } --#347
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 36404; Type = 1; Track = 3; } --#348
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 36404; Type = 2; Duration = 368; Track = 4; } --#349
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 36649; Type = 1; Track = 1; } --#350
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 36649; Type = 1; Track = 2; } --#351
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 36772; Type = 1; Track = 1; } --#352
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 36772; Type = 2; Duration = 245; Track = 3; } --#353
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37017; Type = 1; Track = 1; } --#354
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37017; Type = 1; Track = 2; } --#355
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37140; Type = 1; Track = 2; } --#356
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37140; Type = 1; Track = 4; } --#357
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37140; Type = 1; Track = 3; } --#358
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37263; Type = 1; Track = 3; } --#359
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37263; Type = 1; Track = 4; } --#360
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37385; Type = 1; Track = 2; } --#361
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37385; Type = 1; Track = 3; } --#362
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37508; Type = 1; Track = 4; } --#363
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37508; Type = 1; Track = 2; } --#364
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37508; Type = 1; Track = 1; } --#365
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37631; Type = 1; Track = 3; } --#366
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37631; Type = 1; Track = 4; } --#367
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37753; Type = 1; Track = 1; } --#368
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37753; Type = 1; Track = 2; } --#369
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37876; Type = 2; Duration = 368; Track = 4; } --#370
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37876; Type = 2; Duration = 368; Track = 1; } --#371
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 37876; Type = 2; Duration = 368; Track = 3; } --#372
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38428; Type = 1; Track = 1; } --#373
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38428; Type = 1; Track = 2; } --#374
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38520; Type = 1; Track = 2; } --#375
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38520; Type = 1; Track = 3; } --#376
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38612; Type = 1; Track = 1; } --#377
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38612; Type = 1; Track = 4; } --#378
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38674; Type = 1; Track = 3; } --#379
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38735; Type = 1; Track = 2; } --#380
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38796; Type = 1; Track = 1; } --#381
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38796; Type = 1; Track = 4; } --#382
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38858; Type = 1; Track = 3; } --#383
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38919; Type = 1; Track = 2; } --#384
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38919; Type = 1; Track = 1; } --#385
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38980; Type = 1; Track = 4; } --#386
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 38980; Type = 1; Track = 3; } --#387
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39042; Type = 1; Track = 2; } --#388
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39103; Type = 1; Track = 1; } --#389
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39165; Type = 1; Track = 4; } --#390
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39165; Type = 1; Track = 3; } --#391
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39257; Type = 1; Track = 4; } --#392
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39257; Type = 1; Track = 3; } --#393
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39349; Type = 1; Track = 1; } --#394
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39349; Type = 1; Track = 2; } --#395
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39410; Type = 1; Track = 4; } --#396
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39471; Type = 1; Track = 3; } --#397
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39533; Type = 1; Track = 1; } --#398
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39533; Type = 1; Track = 2; } --#399
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39594; Type = 1; Track = 4; } --#400
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39655; Type = 1; Track = 3; } --#401
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39717; Type = 1; Track = 1; } --#402
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39717; Type = 1; Track = 2; } --#403
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39717; Type = 1; Track = 4; } --#404
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39901; Type = 1; Track = 4; } --#405
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39901; Type = 1; Track = 3; } --#406
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39993; Type = 1; Track = 1; } --#407
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 39993; Type = 1; Track = 2; } --#408
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40085; Type = 1; Track = 1; } --#409
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40085; Type = 1; Track = 2; } --#410
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40177; Type = 1; Track = 4; } --#411
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40177; Type = 1; Track = 3; } --#412
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40269; Type = 1; Track = 1; } --#413
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40330; Type = 1; Track = 2; } --#414
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40392; Type = 1; Track = 3; } --#415
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40453; Type = 1; Track = 1; } --#416
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40453; Type = 1; Track = 2; } --#417
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40514; Type = 1; Track = 4; } --#418
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40576; Type = 1; Track = 3; } --#419
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40637; Type = 1; Track = 2; } --#420
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40698; Type = 1; Track = 1; } --#421
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40760; Type = 1; Track = 2; } --#422
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40821; Type = 1; Track = 4; } --#423
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40821; Type = 1; Track = 3; } --#424
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40913; Type = 1; Track = 2; } --#425
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 40913; Type = 1; Track = 1; } --#426
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41005; Type = 1; Track = 1; } --#427
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41005; Type = 1; Track = 2; } --#428
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41066; Type = 1; Track = 4; } --#429
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41128; Type = 1; Track = 3; } --#430
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41189; Type = 1; Track = 2; } --#431
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41189; Type = 1; Track = 1; } --#432
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41281; Type = 1; Track = 4; } --#433
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41281; Type = 1; Track = 3; } --#434
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41373; Type = 1; Track = 2; } --#435
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41373; Type = 1; Track = 1; } --#436
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41465; Type = 1; Track = 3; } --#437
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41465; Type = 1; Track = 2; } --#438
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41557; Type = 2; Duration = 1289; Track = 1; } --#439
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 41557; Type = 2; Duration = 1289; Track = 4; } --#440
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 42293; Type = 1; Track = 3; } --#441
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 42293; Type = 1; Track = 2; } --#442
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 42661; Type = 1; Track = 2; } --#443
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 42846; Type = 1; Track = 3; } --#444
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 43030; Type = 1; Track = 1; } --#445
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 43030; Type = 1; Track = 2; } --#446
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 43214; Type = 1; Track = 1; } --#447
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 43306; Type = 1; Track = 4; } --#448
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 43306; Type = 1; Track = 3; } --#449
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 43398; Type = 1; Track = 3; } --#450
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 43582; Type = 1; Track = 1; } --#451
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 43582; Type = 1; Track = 4; } --#452
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 43766; Type = 1; Track = 1; } --#453
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 43766; Type = 1; Track = 3; } --#454
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44134; Type = 2; Duration = 368; Track = 4; } --#455
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44502; Type = 1; Track = 2; } --#456
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44502; Type = 1; Track = 1; } --#457
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44563; Type = 1; Track = 3; } --#458
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44625; Type = 1; Track = 2; } --#459
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44686; Type = 1; Track = 4; } --#460
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44686; Type = 1; Track = 1; } --#461
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44747; Type = 1; Track = 3; } --#462
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44809; Type = 1; Track = 2; } --#463
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44870; Type = 1; Track = 1; } --#464
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44870; Type = 1; Track = 3; } --#465
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44931; Type = 1; Track = 4; } --#466
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 44993; Type = 1; Track = 2; } --#467
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45054; Type = 1; Track = 4; } --#468
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45054; Type = 1; Track = 3; } --#469
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45115; Type = 1; Track = 1; } --#470
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45177; Type = 1; Track = 2; } --#471
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45238; Type = 1; Track = 3; } --#472
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45238; Type = 1; Track = 4; } --#473
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45300; Type = 1; Track = 1; } --#474
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45361; Type = 1; Track = 2; } --#475
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45422; Type = 1; Track = 3; } --#476
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45422; Type = 1; Track = 4; } --#477
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45484; Type = 1; Track = 1; } --#478
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45545; Type = 1; Track = 2; } --#479
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45606; Type = 1; Track = 3; } --#480
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45606; Type = 1; Track = 4; } --#481
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45698; Type = 1; Track = 2; } --#482
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45698; Type = 1; Track = 1; } --#483
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45790; Type = 1; Track = 4; } --#484
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45852; Type = 1; Track = 3; } --#485
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45913; Type = 1; Track = 2; } --#486
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45974; Type = 1; Track = 4; } --#487
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 45974; Type = 1; Track = 1; } --#488
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46036; Type = 1; Track = 3; } --#489
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46097; Type = 1; Track = 2; } --#490
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46158; Type = 1; Track = 4; } --#491
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46158; Type = 1; Track = 1; } --#492
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46220; Type = 1; Track = 3; } --#493
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46281; Type = 1; Track = 2; } --#494
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46342; Type = 1; Track = 4; } --#495
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46342; Type = 1; Track = 3; } --#496
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46404; Type = 1; Track = 1; } --#497
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46465; Type = 1; Track = 2; } --#498
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46526; Type = 1; Track = 4; } --#499
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46526; Type = 1; Track = 3; } --#500
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46588; Type = 1; Track = 1; } --#501
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46649; Type = 1; Track = 2; } --#502
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46711; Type = 1; Track = 3; } --#503
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46711; Type = 1; Track = 4; } --#504
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46772; Type = 1; Track = 1; } --#505
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46833; Type = 1; Track = 2; } --#506
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46895; Type = 1; Track = 1; } --#507
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46895; Type = 1; Track = 3; } --#508
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 46895; Type = 1; Track = 4; } --#509
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47079; Type = 1; Track = 4; } --#510
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47079; Type = 1; Track = 1; } --#511
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47263; Type = 1; Track = 3; } --#512
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47263; Type = 1; Track = 2; } --#513
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47355; Type = 1; Track = 2; } --#514
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47355; Type = 1; Track = 1; } --#515
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47447; Type = 1; Track = 3; } --#516
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47447; Type = 1; Track = 4; } --#517
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47539; Type = 1; Track = 3; } --#518
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47539; Type = 1; Track = 4; } --#519
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47631; Type = 1; Track = 2; } --#520
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47692; Type = 1; Track = 3; } --#521
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47753; Type = 1; Track = 4; } --#522
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47815; Type = 1; Track = 2; } --#523
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47815; Type = 1; Track = 1; } --#524
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47907; Type = 1; Track = 1; } --#525
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47907; Type = 1; Track = 2; } --#526
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 47999; Type = 1; Track = 3; } --#527
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48060; Type = 1; Track = 2; } --#528
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48122; Type = 1; Track = 1; } --#529
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48183; Type = 1; Track = 3; } --#530
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48183; Type = 1; Track = 4; } --#531
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48275; Type = 1; Track = 4; } --#532
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48275; Type = 1; Track = 3; } --#533
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48306; Type = 1; Track = 1; } --#534
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48367; Type = 1; Track = 2; } --#535
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48428; Type = 1; Track = 3; } --#536
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48459; Type = 1; Track = 2; } --#537
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48459; Type = 1; Track = 1; } --#538
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48551; Type = 1; Track = 4; } --#539
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48612; Type = 1; Track = 3; } --#540
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48643; Type = 1; Track = 2; } --#541
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48643; Type = 1; Track = 1; } --#542
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48735; Type = 1; Track = 3; } --#543
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48735; Type = 1; Track = 4; } --#544
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48919; Type = 1; Track = 1; } --#545
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48919; Type = 1; Track = 2; } --#546
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 48919; Type = 1; Track = 4; } --#547
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49103; Type = 1; Track = 3; } --#548
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49103; Type = 1; Track = 2; } --#549
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49103; Type = 1; Track = 1; } --#550
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49287; Type = 1; Track = 2; } --#551
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49287; Type = 1; Track = 3; } --#552
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49287; Type = 1; Track = 4; } --#553
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49471; Type = 1; Track = 3; } --#554
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49471; Type = 1; Track = 1; } --#555
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49471; Type = 1; Track = 4; } --#556
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49655; Type = 1; Track = 4; } --#557
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49655; Type = 1; Track = 1; } --#558
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49655; Type = 1; Track = 2; } --#559
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49747; Type = 1; Track = 2; } --#560
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49747; Type = 1; Track = 1; } --#561
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49931; Type = 1; Track = 2; } --#562
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49931; Type = 1; Track = 3; } --#563
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 49931; Type = 1; Track = 4; } --#564
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50023; Type = 1; Track = 1; } --#565
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50207; Type = 2; Duration = 185; Track = 2; } --#566
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50207; Type = 2; Duration = 185; Track = 4; } --#567
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50207; Type = 2; Duration = 185; Track = 1; } --#568
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50576; Type = 1; Track = 3; } --#569
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50576; Type = 1; Track = 4; } --#570
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50668; Type = 1; Track = 2; } --#571
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50668; Type = 1; Track = 1; } --#572
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50760; Type = 1; Track = 4; } --#573
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50760; Type = 1; Track = 3; } --#574
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50852; Type = 1; Track = 3; } --#575
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50852; Type = 1; Track = 2; } --#576
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50944; Type = 1; Track = 1; } --#577
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 50944; Type = 1; Track = 2; } --#578
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51036; Type = 1; Track = 4; } --#579
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51036; Type = 1; Track = 3; } --#580
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51128; Type = 1; Track = 2; } --#581
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51128; Type = 1; Track = 1; } --#582
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51189; Type = 1; Track = 4; } --#583
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51250; Type = 1; Track = 3; } --#584
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51312; Type = 1; Track = 2; } --#585
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51312; Type = 1; Track = 4; } --#586
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51373; Type = 1; Track = 1; } --#587
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51434; Type = 1; Track = 2; } --#588
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51496; Type = 1; Track = 3; } --#589
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51496; Type = 1; Track = 4; } --#590
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51588; Type = 1; Track = 2; } --#591
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51588; Type = 1; Track = 1; } --#592
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51680; Type = 1; Track = 3; } --#593
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51680; Type = 1; Track = 2; } --#594
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51772; Type = 1; Track = 4; } --#595
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 51772; Type = 1; Track = 3; } --#596
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52048; Type = 1; Track = 1; } --#597
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52048; Type = 1; Track = 2; } --#598
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52232; Type = 1; Track = 4; } --#599
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52232; Type = 1; Track = 3; } --#600
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52324; Type = 1; Track = 3; } --#601
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52324; Type = 1; Track = 1; } --#602
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52508; Type = 1; Track = 3; } --#603
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52508; Type = 1; Track = 2; } --#604
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52600; Type = 1; Track = 1; } --#605
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52600; Type = 1; Track = 4; } --#606
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52661; Type = 1; Track = 2; } --#607
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52723; Type = 1; Track = 3; } --#608
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52784; Type = 1; Track = 4; } --#609
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52784; Type = 1; Track = 1; } --#610
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52846; Type = 1; Track = 2; } --#611
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52907; Type = 1; Track = 3; } --#612
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52968; Type = 1; Track = 4; } --#613
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 52968; Type = 1; Track = 1; } --#614
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53030; Type = 1; Track = 2; } --#615
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53091; Type = 1; Track = 3; } --#616
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53152; Type = 1; Track = 1; } --#617
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53152; Type = 1; Track = 4; } --#618
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53214; Type = 1; Track = 2; } --#619
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53275; Type = 1; Track = 3; } --#620
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53336; Type = 1; Track = 2; } --#621
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53336; Type = 1; Track = 1; } --#622
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53336; Type = 1; Track = 4; } --#623
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53520; Type = 1; Track = 3; } --#624
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53520; Type = 1; Track = 4; } --#625
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53612; Type = 1; Track = 2; } --#626
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53612; Type = 1; Track = 1; } --#627
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53704; Type = 1; Track = 4; } --#628
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53704; Type = 1; Track = 3; } --#629
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53704; Type = 1; Track = 2; } --#630
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53796; Type = 1; Track = 3; } --#631
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53796; Type = 1; Track = 4; } --#632
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53888; Type = 1; Track = 1; } --#633
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 53888; Type = 1; Track = 2; } --#634
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54073; Type = 1; Track = 3; } --#635
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54073; Type = 1; Track = 4; } --#636
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54073; Type = 1; Track = 1; } --#637
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54165; Type = 1; Track = 3; } --#638
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54165; Type = 1; Track = 2; } --#639
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54349; Type = 1; Track = 1; } --#640
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54349; Type = 1; Track = 2; } --#641
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54349; Type = 1; Track = 4; } --#642
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54533; Type = 1; Track = 2; } --#643
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54625; Type = 1; Track = 1; } --#644
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54625; Type = 1; Track = 4; } --#645
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54625; Type = 1; Track = 3; } --#646
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54809; Type = 1; Track = 2; } --#647
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54809; Type = 1; Track = 3; } --#648
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54809; Type = 1; Track = 4; } --#649
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54993; Type = 1; Track = 3; } --#650
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 54993; Type = 1; Track = 1; } --#651
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55177; Type = 1; Track = 2; } --#652
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55177; Type = 1; Track = 4; } --#653
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55177; Type = 1; Track = 1; } --#654
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55269; Type = 1; Track = 3; } --#655
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55269; Type = 1; Track = 4; } --#656
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55361; Type = 1; Track = 2; } --#657
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55361; Type = 1; Track = 3; } --#658
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55545; Type = 1; Track = 2; } --#659
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55545; Type = 1; Track = 4; } --#660
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55545; Type = 1; Track = 1; } --#661
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55637; Type = 1; Track = 4; } --#662
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55637; Type = 1; Track = 3; } --#663
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55821; Type = 1; Track = 2; } --#664
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55821; Type = 1; Track = 1; } --#665
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 55821; Type = 1; Track = 3; } --#666
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 56097; Type = 1; Track = 4; } --#667
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 56097; Type = 1; Track = 3; } --#668
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 56097; Type = 1; Track = 1; } --#669
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 56465; Type = 1; Track = 2; } --#670
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 56465; Type = 1; Track = 1; } --#671
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 56465; Type = 1; Track = 3; } --#672
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 56649; Type = 1; Track = 4; } --#673
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 56649; Type = 1; Track = 3; } --#674
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 56649; Type = 1; Track = 1; } --#675
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57017; Type = 1; Track = 3; } --#676
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57017; Type = 1; Track = 2; } --#677
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57017; Type = 1; Track = 1; } --#678
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57109; Type = 1; Track = 1; } --#679
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57109; Type = 1; Track = 2; } --#680
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57201; Type = 1; Track = 3; } --#681
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57201; Type = 1; Track = 1; } --#682
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57201; Type = 1; Track = 4; } --#683
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57293; Type = 1; Track = 3; } --#684
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57293; Type = 1; Track = 4; } --#685
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57569; Type = 1; Track = 2; } --#686
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57569; Type = 1; Track = 3; } --#687
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57569; Type = 1; Track = 4; } --#688
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57938; Type = 1; Track = 3; } --#689
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57938; Type = 1; Track = 2; } --#690
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 57938; Type = 1; Track = 1; } --#691
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 58030; Type = 1; Track = 2; } --#692
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 58122; Type = 1; Track = 3; } --#693
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 58122; Type = 1; Track = 4; } --#694
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 58122; Type = 1; Track = 1; } --#695
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 58214; Type = 1; Track = 2; } --#696
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 58214; Type = 1; Track = 3; } --#697
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 58398; Type = 2; Duration = 552; Track = 1; } --#698
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 58398; Type = 2; Duration = 552; Track = 2; } --#699
	rtv.HitObjects[#rtv.HitObjects + 1] = { Time = 58398; Type = 2; Duration = 552; Track = 4; } --#700
end
rtv.TimingPoints = {
	[1] = { Time = 549; BeatLength = 500; };
	[2] = { Time = 549; BeatLength = 500; };
	[3] = { Time = 14551; BeatLength = 500; };
	[4] = { Time = 16527; BeatLength = 368.098159509202; };
	[5] = { Time = 16527; BeatLength = 368.098159509202; };
	[6] = { Time = 44502; BeatLength = 368.098159509202; };
	[7] = { Time = 50115; BeatLength = 368.098159509202; };
	[8] = { Time = 50207; BeatLength = 368.098159509202; };
	[9] = { Time = 53336; BeatLength = 368.098159509202; };
};
rtv.NpsGraph = {

3.5, --2000ms
4, --4000ms
3.5, --6000ms
4.5, --8000ms
5, --10000ms
7, --12000ms
4, --14000ms
1.5, --16000ms
13, --18000ms
18, --20000ms
15.5, --22000ms
15.5, --24000ms
10.5, --26000ms
12.5, --28000ms
9.5, --30000ms
16.5, --32000ms
12, --34000ms
15, --36000ms
15.5, --38000ms
18, --40000ms
16, --42000ms
7, --44000ms
17, --46000ms
19.5, --48000ms
18.5, --50000ms
16, --52000ms
19, --54000ms
16, --56000ms
12.5, --58000ms
4.5, --60000ms
};
return rtv