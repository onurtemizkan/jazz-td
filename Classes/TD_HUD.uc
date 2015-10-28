class TD_HUD extends HUD;

function DrawGameHud(){
	Canvas.SetPos(Canvas.ClipX/2,Canvas.ClipY/2);
	Canvas.SetDrawColor(255,255,255,255);
	Canvas.Font = class'Engine'.static.GetMediumFont();
	Canvas.DrawText("HelloWorld");
}

DefaultProperties
{
}
