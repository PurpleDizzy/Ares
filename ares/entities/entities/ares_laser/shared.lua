AddCSLuaFile('shared.lua')

ENT.Type 			= "anim"  
ENT.Base 			= "base_anim"     
 
ENT.Spawnable			= false
ENT.AdminSpawnable		= false

function ENT:Initialize()
	self.Entity:SetModel("models/weapons/w_physics.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid(SOLID_VPHYSICS)
	//self.Entity:SetPhysicsAttacker(self.Owner)
	
	local phys = self.Entity:GetPhysicsObject()
	
	//if not phys:IsValid() then return end
	
	phys:EnableDrag(true)
	phys:SetInertia(Vector(0.1,5,5))
	phys:SetMass(1)
	phys:Wake()
	phys:SetVelocity(self.Entity:GetForward()*1000)
end







