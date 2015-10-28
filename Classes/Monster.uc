class Monster extends Pawn
	placeable;

	var(Pawn) int HitPoint;
	var(Pawn) const int Defense;
	var(Pawn) int Speed;
	var float LastEngageTime;
	var SkeletalMeshComponent MonsterMeshComp;
	
event Walk() { 
	//Trace waypoint
}

event Die() {
	if(isDead()) {
		SetTimer(0.5); // after 0.5 secs 
		Self.Destroy();
	}
}

function bool isDead() {
	if(HitPoint <= 0) {
		return true;
	} else {
		return false;
	}
}

simulated event Tick(float DeltaTime) {
	Super.Tick(DeltaTime);
	if (WorldInfo.TimeSeconds - LastEngageTime > 2.0f) {
			LastEngageTime = WorldInfo.TimeSeconds;
			Die();
		}
	}

DefaultProperties { 
	Begin Object Class=SkeletalMeshComponent Name=MonsterMeshTemp
		SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
	End Object
	MonsterMeshComp=MonsterMeshTemp;
	Components.Add(MonsterMeshTemp);

	bCanBeDamaged=true;
	bCanWalk=true;
	Defense=10;
	HitPoint=200;
	Speed=20;
}