class MissileProjectile extends Projectile;

var StaticMeshComponent MissileMesh;
var Actor TargetActor;

simulated event Tick(float DeltaTime)
{
	super.Tick(DeltaTime);

	if (TargetActor != none)
	{
		Velocity = normal(TargetActor.Location - self.Location) * 100.0f;
	}
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	super.ProcessTouch(Other, HitLocation, HitNormal);

	`log("MISSILE HIT"@Other);
}

DefaultProperties
{

	//WeaponProjectiles(1)=class'Sandbox.SandboxPaintballProjectile'
	begin object class=StaticMeshComponent name=MissileMeshTemp
		StaticMesh=StaticMesh'Pickups.Flag.Mesh.S_Flagbase_Lightcone'
	end object
	MissileMesh=MissileMeshTemp;
	Components.Add(MissileMeshTemp);

	bRotationFollowsVelocity=true
}
