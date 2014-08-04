class TD_GameInfo extends SimpleGame;

event PostBeginPlay(){
	super.PostBeginPlay();
	`Log("GameInfo Up!!!!!!!!!!!!!!!!!!!!!!!!");
}

DefaultProperties
{
	DefaultPawnClass=class'MyGame.TD_Player'
	PlayerControllerClass=class'MyGame.TD_PlayerController'
	HUDType=class'MyGame.TD_HUD'
	bUseClassicHUD=true
}