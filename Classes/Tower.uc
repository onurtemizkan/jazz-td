class Tower extends Actor
	placeable;

var(Actor) const int Attack;
var(Actor) const float ShootingRadius;
var(Actor) float Exp;
var float LastEngageTime;
var SkeletalMeshComponent TowerMeshComp;

function Monster GetClosestMonster(Vector LocationFrom, optional float MaxTestDistance = 1000.0f) {
   local Monster TempPawn, ClosestPawn;
   ClosestPawn = none;
   foreach WorldInfo.AllPawns(class 'Monster', TempPawn, LocationFrom, MaxTestDistance) {
      if(ClosestPawn == none || VSize(TempPawn.Location - LocationFrom) < VSize(ClosestPawn.Location - LocationFrom)) { 
         ClosestPawn = TempPawn;
      }
   }
   return ClosestPawn;
}

simulated event Tick(float DeltaTime) {
	Super.Tick(DeltaTime);
	if (WorldInfo.TimeSeconds - LastEngageTime > 0.3f) {
		LastEngageTime = WorldInfo.TimeSeconds;
		fire();
    }
}

function ThrowDamage(int AttackRate, Monster CMonster) {
	CMonster.HitPoint -= AttackRate/Cmonster.Defense;
}

function bool CheckKilled(Monster CMonster) {
	if(CMonster.isDead()) {
		return true;
	} else {
		return false;
	}
}


event Fire() {

	local Monster Closest;
	local MissileProjectile missile;
	local Vector FiringDirection;
	
	//ClosestPawn
	Closest = GetClosestMonster(self.Location,self.ShootingRadius);
	
	//FiringDirection
	FiringDirection = Closest.Location - self.Location;
	FiringDirection.Z = 0;
	FiringDirection = normal(FiringDirection);
	SetRotation(Rotator(FiringDirection));
	missile = Spawn(class'MissileProjectile', self,,self.Location);
	missile.TargetActor = Closest;

	//Firing
	ThrowDamage(self.Attack, Closest);

	`Log("Monster Hp  : "@Closest.HitPoint);
	if(CheckKilled(Closest)) {
	    Exp += (Closest.Defense * Closest.Speed) / 100;
	}
}




DefaultProperties {
 	begin object class=SkeletalMeshComponent name=TowerMeshCompTemp
		SkeletalMesh=SkeletalMesh'VH_Manta.Mesh.SK_VH_Manta'
	end object
	TowerMeshComp = TowerMeshCompTemp;
	Components.Add(TowerMeshCompTemp);
	Attack = 20;
	ShootingRadius = 10000.0;
	Exp = 0.0;
}