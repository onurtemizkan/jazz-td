class TD_GameInfo extends SimpleGame;

event PostBeginPlay(){
	super.PostBeginPlay();
}

DefaultProperties
{
	DefaultPawnClass=class'MyGame.TD_Player'
	PlayerControllerClass=class'MyGame.TD_PlayerController'
	HUDType=class'MyGame.TD_HUD'
	bUseClassicHUD=true
}