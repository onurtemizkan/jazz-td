class Castle extends Tower;

var(Castle) int HitPoint;

function bool isDestroyed(){
	if(self.HitPoint <= 0){
		return true;
	}
}

function EndOfGame(){
	if(isDestroyed()){
		self.Destroy();
	}
}

DefaultProperties
{
	Attack = 500;
	Exp = 0;
	Hitpoint = 10000;
}
