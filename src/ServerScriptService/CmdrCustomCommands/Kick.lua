return {
    Name = "kick";
	Aliases = {"ki"};
	Description = "Kicks a player.";
	Group = "Admin";
	Args = {
		{
			Type = "player";
			Name = "player";
			Description = "The player to be kicked.";
        },
        {
            Type = "string";
            Name = "reason";
            Description = "The reason for the kick.";
        }
	};
}