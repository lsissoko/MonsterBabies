package {
	
	import org.flixel.*;
	[SWF(width="320", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class MonsterBabiesMain extends FlxGame
	{
		public function MonsterBabiesMain():void
		{
			super(320/2,480/2,MenuState);
		}
	}
}