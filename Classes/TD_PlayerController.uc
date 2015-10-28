class TD_PlayerController extends PlayerController;

var Rotator DesiredRotation;
var int TowersRemaining;
var int TowerCooldown;
var int MaxTowers;

var int LastEngageTime;

var input float aVertical;
var input float aHorizontal;

simulated event PostBeginPlay() {
	super.PostBeginPlay();
	`Log("PlayerController Up!");
}

simulated event TCooldown(float DeltaTime) {
	Super.Tick(DeltaTime);

	if(WorldInfo.TimeSeconds - LastEngageTime > TowerCooldown) {
		LastEngageTime = WorldInfo.TimeSeconds;
		if(TowersRemaining < MaxTowers) {
			TowersRemaining++;
		}
	}
}

exec function SpawnTower() {
	if(TowersRemaining > 0) {
	Spawn(Class'MyGame.Tower',,,Pawn.Location,,,);
		`Log("Tower Spawned");
		TowersRemaining--;
	}

	else {
		`Log("Wait for the cooldown to spawn another tower!  "@(TowerCoolDown-LastEngageTime));
	}
}

function UpdateRotation( float DeltaTime ) {
	local Rotator   DeltaRot, newRotation, ViewRotation;
	ViewRotation = Rotation;
	if (Pawn!=none) {
		Pawn.SetDesiredRotation(ViewRotation);
	}

	// Calculate Delta to be applied on ViewRotation
	DeltaRot.Yaw      = PlayerInput.aTurn;
	DeltaRot.Pitch    = PlayerInput.aLookUp;

	ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot);
	SetRotation(ViewRotation);
	NewRotation = ViewRotation;
	NewRotation.Roll = Rotation.Roll;
	if(Pawn != None ) {
		Pawn.FaceRotation(NewRotation, deltatime);
	}
}

function PlayerMove(float DeltaTime) {
	local Vector NewAccel;
	local bool bSaveJump;

	if (Pawn == None) {
		GotoState('Dead');
	} else {
		// Update acceleration
		NewAccel.X = PlayerInput.aForward;
		NewAccel.Y = PlayerInput.aStrafe;
		NewAccel.Z = 0;
		NewAccel = Pawn.AccelRate * Normal(NewAccel);
		UpdateRotation(DeltaTime);
		// Handle jumping
		if (bPressedJump && Pawn.CannotJumpNow()) {
			bSaveJump = true;
			bPressedJump = false;
		} else {
			bSaveJump = false;
		}
		// Update the movement, either replicate it or process it
		if (Role < ROLE_Authority) {
			ReplicateMove(DeltaTime, NewAccel, DCLICK_None, Self.Rotation);
		} else {
			ProcessMove(DeltaTime, NewAccel, DCLICK_None, Self.Rotation);
		}
		bPressedJump = bSaveJump;
	}
}



DefaultProperties {
	TowersRemaining=5
	TowerCooldown=15//Seconds
	MaxTowers=10
}