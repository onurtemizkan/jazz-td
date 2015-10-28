class TD_Player extends Pawn
	placeable;

var(Pawn) const float TurnRate;
var(Pawn) const float JumpHeight;

var(Pawn) const vector CameraOffset;
var(Pawn) const float StoppedFOV;
var(Pawn) const float FullSpeedFOV;
var(Pawn) float CamOffsetDistance;
var(Pawn) float IsoCamAngle;

var SkeletalMeshComponent PlayerMeshComp;

var float DesiredYaw;
var float CurrentYaw;
var float CurrentPitch;

var AnimNodeAimOffset AimNode;

simulated event PostBeginPlay() {
	Super.PostBeginPlay();
    //Set the desired and current Yaw values EQUAL
	DesiredYaw = Rotation.Yaw;
	CurrentYaw = Rotation.Yaw;
	`Log("Player UP!");
}

simulated function bool CalcCamera(float DeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV) {
	local Vector PawnDirX, PawnDirY, PawnDirZ;
	local Rotator DesiredRot;
	GetAxes(Self.Rotation,PawnDirX,PawnDirY,PawnDirZ);
	out_CamLoc = Self.Location - (PawnDirX) * CamOffsetDistance;
	out_CamLoc.Z = Self.Location.Z + 150;
	out_CamRot = Self.Rotation;
	out_CamRot.Pitch = -IsoCamAngle;
	DesiredRot = out_CamRot;
	return true;
}

DefaultProperties {
	Begin Object Class=SkeletalMeshComponent name=PlayerMeshTemp
		SkeletalMesh=SkeletalMesh'VH_Scorpion.Mesh.SK_VH_Scorpion_001'
	End Object
	PlayerMeshComp=PlayerMeshTemp;
	Components.Add(PlayerMeshTemp);
	CamOffsetDistance=350;
	IsoCamAngle = 2730;
}