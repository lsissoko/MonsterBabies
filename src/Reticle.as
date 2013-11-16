package {
    import org.flixel.*;
    
    public class Reticle extends FlxSprite {
		[Embed(source = "gfx/ret2.png")] private var ImgSheet:Class;
		
		private var speed:int = 200;
		public var id:int;
		
		public function Reticle(X:Number, Y:Number, id:int) {
			super(X, Y);
			
			this.id = id;
			
            loadGraphic(ImgSheet, true, true, 16, 16);
            addAnimation("hover1", [0]);
            addAnimation("hover2", [2]);
			addAnimation("focus", [1]);
			
			acceleration.x = 0;
			acceleration.y = 0;
		}
		
		override public function update():void {
			super.update();
			
			// Player control over Reticle movement (Arrows or WASD)
			velocity.x = 0;
			velocity.y = 0;
			
			if(this.id==1){
				if (FlxG.keys.W || FlxG.keys.S)
					velocity.y = FlxG.keys.W ? -1 * speed : speed;
				if (FlxG.keys.A || FlxG.keys.D)
					velocity.x = FlxG.keys.A ? -1 * speed : speed;
				
				play("hover1");
			}
			else if(this.id==2){
				if (FlxG.keys.UP || FlxG.keys.DOWN)
					velocity.y = FlxG.keys.UP ? -1 * speed : speed;
				if (FlxG.keys.LEFT || FlxG.keys.RIGHT)
					velocity.x = FlxG.keys.LEFT ? -1 * speed : speed;
				
				play("hover2");
		    }
			
			// Keep Reticle in the game window.
			if (x > FlxG.width - this.width)
				x = FlxG.width - this.width;
			if (x < 0)
				x = 0;
			if (y > FlxG.height - this.height)
				y = FlxG.height - this.height;
			if (y < 60)
				y = 60; // Don't go up to the top (no "cherry-picking")			
		}		
	}
}