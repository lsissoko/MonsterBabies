package {
    import org.flixel.*;
    
    public class Boom extends FlxSprite {
		[Embed(source = "gfx/explody.png")] private var ImgSheet:Class;		
		[Embed(source = "sfx/fire1.mp3")] private var sound1:Class;
		public var life:int = 15;
		
		public function Boom(X:Number, Y:Number) {
			super(X, Y);
			
            loadGraphic(ImgSheet, true, true, 32, 32);
            addAnimation("stand", [0]);
			play("stand");
			
			FlxG.play(sound1, 0.2, false);
		}
		
		override public function update():void {
			super.update();
			
			life--;
			if (life <= 0) kill();
		}
	}
}