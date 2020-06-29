return {
    Name = "ban";
	Aliases = {"bn"};
	Description = "Perm-bans a player.";
	Group = "Admin";
	Args = {
		{
			Type = "player";
			Name = "player";
			Description = "The player to be banned.";
        },
        {
            Type = "string";
            Name = "reason";
            Description = "The reason for the ban.";
        }
	};
}