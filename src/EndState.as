package  
{	
	import org.flixel.*;
	
	public class EndState extends FlxState
	{
		
		override public function create():void
		{
			// Show mouse
			FlxG.mouse.show();
		}
		
		override public function update():void
		{
			
			// Play Again
			if (FlxG.keys.ENTER)
			{
				FlxG.flash.start(0xffffffff, 0.2);
				FlxG.fade.start(0xff000000, 1, onFade);
			}
		}
		
		private function onFade():void{
			FlxG.state = new PlayState();
		}
		
	}
}