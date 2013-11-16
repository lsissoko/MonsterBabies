package {
    import org.flixel.*;
    
    public class Enemy extends FlxSprite {
		[Embed(source = "gfx/baby.png")] private var BabySheet:Class;
		
		public var startVelX:Number = 0;
		public var startVelY:Number = 20*2;
		public var maxSpeed:Number = 40*2;
		public var trapped:Boolean = false;
		
		public var type:String; // What kind of character we're making
		
		public function Enemy(X:Number, Y:Number, type:String) {
			super(X, Y);
			
			this.type = type;
			loadGraphic(BabySheet, true, true, 32, 32);
			addAnimation("evil", [0]);
			addAnimation("good", [1]);
			if (this.type == "Baby")
				play("good");
			else if (this.type == "Ybab")
				play("evil");
			
			// Bounding Box
			width = 24;
			height = 30;
			offset.x = 8;
			
			acceleration.x = 0;
			acceleration.y = 0;
			velocity.y = startVelY;
		}
		
		override public function update():void {
			super.update();
			
			if (this.y > FlxG.height)
				reload();
			
			if (y < -80)
				velocity.y += 50;
			else{
				velocity.y += 5;
				if (velocity.y > maxSpeed) velocity.y = maxSpeed;
			}
		}
		
		/**
		 * Pull from below screen bottom to above screen top
		 */ 
		public function reload():void {
			velocity.x = startVelX;
			//velocity.y = startVelY * 1.2; // Make it faster
			//maxSpeed *= 1.2; // Increase speed cap
			x = Math.random() * (FlxG.width - 16);
			y = Math.random() * ( -50) - 50;
			
			var a:int = Math.random() * 2;
			if (a == 0){
				this.type = "Baby";
				play("good");
			}
			else if(a==1){
				this.type = "Ybab";	
				play("evil");
			}
		}
		
		public function isShot():Boolean {
			var answer:Boolean;
			if (this.type == "Ybab")
				answer =  true;
			else if (this.type == "Baby")
				answer =  false;
			return answer;
		}
	}
}