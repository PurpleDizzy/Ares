function EFFECT:Init(data)
	self.Pos 		= data:GetOrigin()		// Pos determines the global position of the effect			//

	self.DirVec 		= data:GetNormal()		// DirVec determines the direction of impact for the effect		//
	self.PenVec 		= data:GetStart()		// PenVec determines the direction of the round for penetrations	//
	self.Scale 		= data:GetScale()		// Scale determines how large the effect is				//
	self.Radius 		= data:GetRadius() or 1		// Radius determines what type of effect to create, default is Concrete	//

	self.Emitter 		= ParticleEmitter( self.Pos )	// Emitter must be there so you don't get an error			//
	
	print(self.Radius)
 
	if self.Radius == 2 or self.Radius == 3 or self.Radius == 7 or self.Radius == 8 or self.Radius == 66 then
		self:Metal()
	elseif self.Radius == 39 then
		self:Blood()
	elseif self.Radius == 17 or self.Radius == 18 or self.Radius == 21 then
		self:Wood()
	elseif self.Radius != 28 and self.Radius != 0 then
		self:Dust()
	end

end
 
 function EFFECT:Dust()
	sound.Play("Default.BulletImpact", self.Pos)
	self.Emitter = ParticleEmitter( self.Pos )
		
	for i=0, 15*self.Scale do
		local Smoke = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec * math.random( 20,500*self.Scale) + VectorRand():GetNormalized()*100*self.Scale )
		Smoke:SetDieTime( math.Rand( 1 , 2.5 )*self.Scale )
		Smoke:SetStartAlpha( math.Rand( 80, 100 ) )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 15*self.Scale )
		Smoke:SetEndSize( 35*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 300 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) * self.Scale, math.Rand(0, -100) ) ) 			
		Smoke:SetColor( 50,50,50 )
		end
	end

	for i=0, 10*self.Scale do
		local Smoke = self.Emitter:Add( "particle/particle_composite", self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec * math.random( 0,400*self.Scale) + VectorRand():GetNormalized()*5*self.Scale )
		Smoke:SetDieTime( math.Rand( 0.5 , 1.5 )*self.Scale )
		Smoke:SetStartAlpha( 150 )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 20*self.Scale )
		Smoke:SetEndSize( 35*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 400 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-50, 50) * self.Scale, math.Rand(-50, 50) * self.Scale, math.Rand(0, -100) ) ) 			
		Smoke:SetColor( 105,100,90 )
		end
	end
/*
	for i=0, 10*self.Scale do
		local Debris = self.Emitter:Add( "effects/fleck_cement"..math.random(1,2), self.Pos )
		if (Debris) then
		Debris:SetVelocity ( self.DirVec * math.random(200,300*self.Scale) + VectorRand():GetNormalized() * 300*self.Scale )
		Debris:SetDieTime( math.random( 0.6, 1) )
		Debris:SetStartAlpha( 255 )
		Debris:SetEndAlpha( 0 )
		Debris:SetStartSize( math.random(2,5*self.Scale) )
		Debris:SetRoll( math.Rand(0, 360) )
		Debris:SetRollDelta( math.Rand(-5, 5) )			
		Debris:SetAirResistance( 50 ) 			 			
		Debris:SetColor( 105,100,90 )
		Debris:SetGravity( Vector( 0, 0, 0) ) 
		Debris:SetCollide( true )
		Debris:SetBounce( 1 )			
		end
	end
*/	

 end
 
 function EFFECT:Dirt()
	sound.Play( "Bullet.Dirt", self.Pos)

	self.Emitter = ParticleEmitter( self.Pos )
		
	for i=0, 15*self.Scale do
		local Smoke = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec * math.random( 20,500*self.Scale) + VectorRand():GetNormalized()*100*self.Scale )
		Smoke:SetDieTime( math.Rand( 1 , 2.5 )*self.Scale )
		Smoke:SetStartAlpha( math.Rand( 80, 100 ) )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 15*self.Scale )
		Smoke:SetEndSize( 35*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 300 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) * self.Scale, math.Rand(0, -100) ) ) 			
		Smoke:SetColor( 90,83,68 )
		end
	end

	for i=0, 10*self.Scale do
		local Smoke = self.Emitter:Add( "particle/particle_composite", self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec * math.random( 0,400*self.Scale) + VectorRand():GetNormalized()*5*self.Scale )
		Smoke:SetDieTime( math.Rand( 0.5 , 1.5 )*self.Scale )
		Smoke:SetStartAlpha( 200 )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 20*self.Scale )
		Smoke:SetEndSize( 30*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 400 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-50, 50) * self.Scale, math.Rand(-50, 50) * self.Scale, math.Rand(0, -100) ) ) 			
		Smoke:SetColor( 90,83,68 )
		end
	end

	for i=0, 15*self.Scale do
		local Debris = self.Emitter:Add( "effects/fleck_cement"..math.random(1,2), self.Pos )
		if (Debris) then
		Debris:SetVelocity ( self.DirVec * math.random(200,300*self.Scale) + VectorRand():GetNormalized() * 300*self.Scale )
		Debris:SetDieTime( math.random( 0.75, 1.25) )
		Debris:SetStartAlpha( 255 )
		Debris:SetEndAlpha( 0 )
		Debris:SetStartSize( math.random(3,7*self.Scale) )
		Debris:SetRoll( math.Rand(0, 360) )
		Debris:SetRollDelta( math.Rand(-5, 5) )			
		Debris:SetAirResistance( 50 ) 			 			
		Debris:SetColor( 90,83,68 )
		Debris:SetGravity( Vector( 0, 0, -600) ) 
		Debris:SetCollide( true )
		Debris:SetBounce( 1 )			
		end
	end
	
		for i=0,1 do 
			local Flash = self.Emitter:Add( "effects/muzzleflash"..math.random(1,4), self.Pos )
			if (Flash) then
			Flash:SetVelocity( self.DirVec*100 )
			Flash:SetAirResistance( 200 )
			Flash:SetDieTime( 0.1 )
			Flash:SetStartAlpha( 255 )
			Flash:SetEndAlpha( 0 )
			Flash:SetStartSize( math.Rand( 10, 20 )*self.Scale )
			Flash:SetEndSize( 0 )
			Flash:SetRoll( math.Rand(180,480) )
			Flash:SetRollDelta( math.Rand(-1,1) )
			Flash:SetColor(255,255,255)	
			end
		end
 end

 function EFFECT:Sand()
	sound.Play( "Bullet.Dirt", self.Pos)
	self.Emitter = ParticleEmitter( self.Pos )
		
	for i=0, 15*self.Scale do
		local Smoke = self.Emitter:Add( "particle/particle_composite", self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec * math.random( 20,500*self.Scale) + VectorRand():GetNormalized()*100*self.Scale )
		Smoke:SetDieTime( math.Rand( 1 , 2.5 )*self.Scale )
		Smoke:SetStartAlpha( math.Rand( 60, 80 ) )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 15*self.Scale )
		Smoke:SetEndSize( 30*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 300 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) * self.Scale, math.Rand(0, -100) ) ) 			
		Smoke:SetColor( 120,110,90 )
		end
	end

	for i=0, 20*self.Scale do
		local Smoke = self.Emitter:Add( "particle/particle_composite", self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec * math.random( 20,400*self.Scale) + VectorRand():GetNormalized()*20*self.Scale )
		Smoke:SetDieTime( math.Rand( 0.5 , 1.5 )*self.Scale )
		Smoke:SetStartAlpha( 150 )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 20*self.Scale )
		Smoke:SetEndSize( 30*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 400 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-50, 50) * self.Scale, math.Rand(-50, 50) * self.Scale, math.Rand(0, -100) ) ) 			
		Smoke:SetColor( 120,110,90 )
		end
	end

	
 end

 function EFFECT:Metal()
	sound.Play( "SolidMetal.BulletImpact", self.Pos)
	self.Emitter = ParticleEmitter( self.Pos )
		
	for i=0, 15*self.Scale do
		local Smoke = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec * math.random( 20,70*self.Scale) + VectorRand():GetNormalized()*150*self.Scale )
		Smoke:SetDieTime( math.Rand( 3 , 7 )*self.Scale )
		Smoke:SetStartAlpha( math.Rand( 30, 40 ) )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 30*self.Scale )
		Smoke:SetEndSize( 40*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 300 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) * self.Scale, math.Rand(0, -100) ) ) 			
		Smoke:SetColor( 100,100,100 )
		end
	end
	
		for i=0,3 do 
			local Flash = self.Emitter:Add( "effects/muzzleflash"..math.random(1,4), self.Pos )
			if (Flash) then
			Flash:SetVelocity( self.DirVec*100 )
			Flash:SetAirResistance( 200 )
			Flash:SetDieTime( 0.1 )
			Flash:SetStartAlpha( 255 )
			Flash:SetEndAlpha( 0 )
			Flash:SetStartSize( math.Rand( 20, 30 )*self.Scale^2 )
			Flash:SetEndSize( 0 )
			Flash:SetRoll( math.Rand(180,480) )
			Flash:SetRollDelta( math.Rand(-1,1) )
			Flash:SetColor(255,255,255)	
			end
		end

 	 
 		for i=0, 20*self.Scale do 
 			local particle = self.Emitter:Add( "effects/spark", self.Pos ) 
 			if (particle) then 
 			particle:SetVelocity( ((self.DirVec*0.75)+VectorRand()) * math.Rand(50, 300)*self.Scale ) 
 			particle:SetDieTime( math.Rand(0.3, 0.5) ) 				 
 			particle:SetStartAlpha( 255 )  				 
 			particle:SetStartSize( math.Rand(4, 6)*self.Scale ) 
 			particle:SetEndSize( 0 ) 				 
 			particle:SetRoll( math.Rand(0, 360) ) 
 			particle:SetRollDelta( math.Rand(-5, 5) ) 				 
 			particle:SetAirResistance( 20 ) 
 			particle:SetGravity( Vector( 0, 0, -600 ) ) 
 			end 
			
		end 

end


 function EFFECT:Smoke()
	sound.Play( "Bullet.Tile", self.Pos)
	self.Emitter = ParticleEmitter( self.Pos )
		
	for i=0, 5*self.Scale do
		local Smoke = self.Emitter:Add( "particle/smokestack", self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec * math.random( 20,70*self.Scale) + VectorRand():GetNormalized()*150*self.Scale )
		Smoke:SetDieTime( math.Rand( 3 , 7 )*self.Scale )
		Smoke:SetStartAlpha( math.Rand( 50, 70 ) )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 20*self.Scale )
		Smoke:SetEndSize( 50*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 200 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) ) ) 			
		Smoke:SetColor( 100,100,100 )
		end
	end

	for i=0, 10*self.Scale do
		local Smoke = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec * math.random( 20,70*self.Scale) + VectorRand():GetNormalized()*150*self.Scale )
		Smoke:SetDieTime( math.Rand( 1 , 4 )*self.Scale )
		Smoke:SetStartAlpha( math.Rand( 50, 60 ) )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 20*self.Scale )
		Smoke:SetEndSize( 50*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 200 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) ) ) 			
		Smoke:SetColor( 100,100,100 )
		end
	end

	for i=0, 15*self.Scale do
		local Debris = self.Emitter:Add( "effects/fleck_tile"..math.random(1,2), self.Pos )
		if (Debris) then
		Debris:SetVelocity ( self.DirVec * math.random(50,100*self.Scale) + VectorRand():GetNormalized() * 300*self.Scale )
		Debris:SetDieTime( math.random( 0.75, 1) )
		Debris:SetStartAlpha( 255 )
		Debris:SetEndAlpha( 0 )
		Debris:SetStartSize( math.random(1,3*self.Scale) )
		Debris:SetRoll( math.Rand(0, 360) )
		Debris:SetRollDelta( math.Rand(-5, 5) )			
		Debris:SetAirResistance( 50 ) 			 			
		Debris:SetColor( 90,85,75 )
		Debris:SetGravity( Vector( 0, 0, -600) ) 
		Debris:SetCollide( true )
		Debris:SetBounce( 1 )			
		end
	end

	for i=0,1 do 
		local Flash = self.Emitter:Add( "effects/muzzleflash"..math.random(1,4), self.Pos )
		if (Flash) then
		Flash:SetVelocity( self.DirVec*100 )
		Flash:SetAirResistance( 200 )
		Flash:SetDieTime( 0.1 )
		Flash:SetStartAlpha( 255 )
		Flash:SetEndAlpha( 0 )
		Flash:SetStartSize( math.Rand( 10, 20 )*self.Scale^2 )
		Flash:SetEndSize( 0 )
		Flash:SetRoll( math.Rand(180,480) )
		Flash:SetRollDelta( math.Rand(-1,1) )
		Flash:SetColor(255,255,255)	
		end
	end
 end

 function EFFECT:Wood()
	sound.Play( "Wood.BulletImpact", self.Pos)
	self.Emitter = ParticleEmitter( self.Pos )
		
	for i=0, 7*self.Scale do
		local Smoke = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec * math.random( 20,70*self.Scale) + VectorRand():GetNormalized()*150*self.Scale )
		Smoke:SetDieTime( math.Rand( 3 , 7 )*self.Scale )
		Smoke:SetStartAlpha( math.Rand( 30, 40 ) )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 25*self.Scale )
		Smoke:SetEndSize( 50*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 200 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) ) ) 			
		Smoke:SetColor( 100,100,100 )
		end
	end

	for i=0, 13*self.Scale do
		local Smoke = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec * math.random( 20,70*self.Scale) + VectorRand():GetNormalized()*130*self.Scale )
		Smoke:SetDieTime( math.Rand( 3 , 7 )*self.Scale )
		Smoke:SetStartAlpha( math.Rand( 40, 50 ) )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 20*self.Scale )
		Smoke:SetEndSize( 50*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 200 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) ) ) 			
		Smoke:SetColor( 90,85,75 )
		end
	end

	for i=0, 15*self.Scale do
		local Debris = self.Emitter:Add( "effects/fleck_wood"..math.random(1,2), self.Pos+self.DirVec )
		if (Debris) then
		Debris:SetVelocity ( self.DirVec * math.random(50,300*self.Scale) + VectorRand():GetNormalized() * 300*self.Scale )
		Debris:SetDieTime( math.random( 0.75, 1) )
		Debris:SetStartAlpha( 255 )
		Debris:SetEndAlpha( 0 )
		Debris:SetStartSize( math.random(3,6*self.Scale) )
		Debris:SetRoll( math.Rand(0, 360) )
		Debris:SetRollDelta( math.Rand(-5, 5) )			
		Debris:SetAirResistance( 50 ) 			 			
		Debris:SetColor( 90,85,75 )
		Debris:SetGravity( Vector( 0, 0, -600) ) 
		Debris:SetCollide( true )
		Debris:SetBounce( 0.5 )			
		end
	end

 end

 function EFFECT:Glass()
	sound.Play( "Bullet.Glass", self.Pos)
	for i=0, 7*self.Scale do
		local Smoke = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec * math.random( 20,70*self.Scale) + VectorRand():GetNormalized()*150*self.Scale )
		Smoke:SetDieTime( math.Rand( 3 , 7 )*self.Scale )
		Smoke:SetStartAlpha( math.Rand( 40, 60 ) )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 20*self.Scale )
		Smoke:SetEndSize( 50*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 200 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) * self.Scale, math.Rand(-70, 70) ) ) 			
		Smoke:SetColor( 100,100,100 )
		end
	end
	
	for i=0, 15*self.Scale do
		local Debris = self.Emitter:Add( "effects/fleck_glass"..math.random(1,3), self.Pos )
		if (Debris) then
		Debris:SetVelocity ( self.PenVec * math.random(0,300)*self.Scale + VectorRand():GetNormalized() * 100*self.Scale )
		Debris:SetDieTime( math.random( 1, 1.5) )
		Debris:SetStartAlpha( 255 )
		Debris:SetEndAlpha( 0 )
		Debris:SetStartSize( math.random(2,4*self.Scale) )
		Debris:SetRoll( math.Rand(0, 360) )
		Debris:SetRollDelta( math.Rand(-15, 15) )			
		Debris:SetAirResistance( 50 ) 			 			
		Debris:SetColor( 200,200,200 )
		Debris:SetGravity( Vector( 0, 0, -600) ) 		
		end
	end

	for i=0, 20*self.Scale do
		local Debris = self.Emitter:Add( "effects/fleck_glass"..math.random(1,3), self.Pos )
		if (Debris) then
		Debris:SetVelocity ( self.PenVec*-1 * math.random(0,500)*self.Scale + VectorRand():GetNormalized() * 100*self.Scale )
		Debris:SetDieTime( math.random( 0.5, 1) )
		Debris:SetStartAlpha( 255 )
		Debris:SetEndAlpha( 0 )
		Debris:SetStartSize( math.random(2,4*self.Scale) )
		Debris:SetRoll( math.Rand(0, 360) )
		Debris:SetRollDelta( math.Rand(-15, 15) )			
		Debris:SetAirResistance( 50 ) 			 			
		Debris:SetColor( 200,200,200 )
		Debris:SetGravity( Vector( 0, 0, -600) ) 	
		end
	end
 end

 function EFFECT:Blood()
	sound.Play( "Bullet.Flesh", self.Pos)
	for i=0, (10)*self.Scale do

		// Some blood spray out front and the back
		local Spray = self.Emitter:Add( "particle/particle_composite", self.Pos )
		if (Spray) then
		Spray:SetVelocity( (self.PenVec*i*self.Scale*40) + (VectorRand():GetNormalized()*30*self.Scale) )
		Spray:SetDieTime( math.Rand( 0.3 , 0.9 ) )
		Spray:SetStartAlpha( 100 )
		Spray:SetEndAlpha( 0 )
		Spray:SetStartSize( 15*self.Scale )
		Spray:SetEndSize( 35*self.Scale )
		Spray:SetRoll( math.Rand(150, 360) )
		Spray:SetRollDelta( math.Rand(-3, 3) )			
		Spray:SetAirResistance( 400 ) 			 		
		Spray:SetColor( 70,35,35 )
		end
	end

		// Some mist for effect
	for i=0, (15)*self.Scale do
		local Mist = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (Mist) then
		Mist:SetVelocity( (self.PenVec*i*self.Scale*35) + (VectorRand():GetNormalized()*30*self.Scale) )
		Mist:SetDieTime( math.Rand( 0.3 , 1.5 ) )
		Mist:SetStartAlpha( 80 )
		Mist:SetEndAlpha( 0 )
		Mist:SetStartSize( 10*self.Scale )
		Mist:SetEndSize( 30*self.Scale )
		Mist:SetRoll( math.Rand(150, 360) )
		Mist:SetRollDelta( math.Rand(-2, 2) )			
		Mist:SetAirResistance( 300 ) 			 
		Mist:SetGravity( Vector( math.Rand(-50, 50) * self.Scale, math.Rand(-50, 50) * self.Scale, math.Rand(-100, -400) ) ) 			
		Mist:SetColor( 70,35,35 )
		end
	end

		// Some chunks of spleen or whatever
	for i=0, (25)*self.Scale do
		local Chunks = self.Emitter:Add( "effects/fleck_cement"..math.random(1,2), self.Pos )
		if (Chunks) then
		Chunks:SetVelocity ( (self.PenVec*self.Scale*math.Rand(-100, 300)) + (VectorRand():GetNormalized()*50*self.Scale) )
		Chunks:SetDieTime( math.random( 0.3, 0.8) )
		Chunks:SetStartAlpha( 255 )
		Chunks:SetEndAlpha( 0 )
		Chunks:SetStartSize( 3*self.Scale )
		Chunks:SetEndSize( 3*self.Scale )
		Chunks:SetRoll( math.Rand(0, 360) )
		Chunks:SetRollDelta( math.Rand(-5, 5) )			
		Chunks:SetAirResistance( 30 ) 			 			
		Chunks:SetColor( 70,35,35 )
		Chunks:SetGravity( Vector( 0, 0, -600) ) 
		Chunks:SetCollide( true )
		Chunks:SetBounce( 0.01 )			
		end
	end

		// Some dust kickup like in the movies
	for i=0, 8*self.Scale do
		local Smoke = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.DirVec*math.random( 10,30*self.Scale) + VectorRand():GetNormalized()*120*self.Scale )
		Smoke:SetDieTime( math.Rand( 0.5 , 3 )*self.Scale )
		Smoke:SetStartAlpha( math.Rand( 40, 50 ) )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 20*self.Scale )
		Smoke:SetEndSize( 30*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-1, 1) )			
		Smoke:SetAirResistance( 200 ) 			 
		Smoke:SetColor( 100,100,100 )
		end
	end

 end

 function EFFECT:YellowBlood()
	sound.Play( "Bullet.Flesh", self.Pos)
	for i=0, 10*self.Scale do
		local Smoke = self.Emitter:Add( "particle/particle_composite", self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( self.PenVec * math.random(50,300)*self.Scale + VectorRand():GetNormalized() * 50*self.Scale )
		Smoke:SetDieTime( math.Rand( 0.3 , 0.7 ) )
		Smoke:SetStartAlpha( 80 )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 10*self.Scale )
		Smoke:SetEndSize( 30*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 400 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-50, 50) * self.Scale, math.Rand(-50, 50) * self.Scale, math.Rand(-100, -400) ) ) 			
		Smoke:SetColor( 120,120,0 )
		end
	end

	for i=0, 10*self.Scale do
		local Smoke = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (Smoke) then
		Smoke:SetVelocity( VectorRand():GetNormalized()*math.random(0,50)*self.Scale )
		Smoke:SetDieTime( math.Rand( 0.3 , 1.5 ) )
		Smoke:SetStartAlpha( 120 )
		Smoke:SetEndAlpha( 0 )
		Smoke:SetStartSize( 10*self.Scale )
		Smoke:SetEndSize( 30*self.Scale )
		Smoke:SetRoll( math.Rand(150, 360) )
		Smoke:SetRollDelta( math.Rand(-2, 2) )			
		Smoke:SetAirResistance( 400 ) 			 
		Smoke:SetGravity( Vector( math.Rand(-50, 50) * self.Scale, math.Rand(-50, 50) * self.Scale, math.Rand(-100, -400) ) ) 			
		Smoke:SetColor( 120,120,0 )
		end
	end

	for i=0, 10*self.Scale do
	
		local Debris = self.Emitter:Add( "effects/fleck_cement"..math.random(1,2), self.Pos+(self.DirVec*5) )
		if (Debris) then
		Debris:SetVelocity ( self.PenVec * math.random(50,300)*self.Scale + VectorRand():GetNormalized() * 50*self.Scale )
		Debris:SetDieTime( math.random( 0.3, 0.6) )
		Debris:SetStartAlpha( 255 )
		Debris:SetEndAlpha( 0 )
		Debris:SetStartSize( 4*self.Scale )
		Debris:SetEndSize( 4*self.Scale )
		Debris:SetRoll( math.Rand(0, 360) )
		Debris:SetRollDelta( math.Rand(-5, 5) )			
		Debris:SetAirResistance( 30 ) 			 			
		Debris:SetColor( 120,120,0 )
		Debris:SetGravity( Vector( 0, 0, -600) ) 
		Debris:SetCollide( true )
		Debris:SetBounce( 0.01 )			
		end
	end
 end
 

function EFFECT:Think( )
return false
end


function EFFECT:Render()

end