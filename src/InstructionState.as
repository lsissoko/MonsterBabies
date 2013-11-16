package  
{	
	import org.flixel.*;
	
	public class InstructionState extends FlxState
	{
		//[Embed(source = ".png")] protected var TitleImage:Class;
		protected var image:FlxSprite;
		protected var selection:int = 0;
		protected var status:FlxText, status3:FlxText;
		
		override public function create():void
		{
			// Show mouse
			FlxG.mouse.show();
			
			// Add background image
			//image = new FlxSprite(0, 0, TitleImage);
			//this.add(image);			
		}
		
		override public function update():void
		{
			// Select between Game and Instruction Menu
			if (selection == 0 && FlxG.keys.DOWN)
				selection = 1;
			if (selection == 1 && FlxG.keys.UP)
				selection = 0;
			
			status = new FlxText(5,25,FlxG.width-5);
			status.shadow = 0xff0000ff;
			status.text = "BABIES ARE FALLING FROM THE SKY. SOME ARE GOOD BABIES, BUT THE OTHERS ARE MONSTER BABIES.\n";
			status.text += "\nSHOOTING A MONSTER GIVES YOU 2 POINTS, BUT SHOOTING A GOOD BABY TAKES 10 AWAY. YOUR GOAL IS TO REACH 100."
			status.text += "\n\nPLAYER 1 SHOOTS WITH V KEY AND MOVES WITH WASD KEYS."
			status.text += "\n\nPLAYER 2 SHOOTS WITH CTRL KEY AND MOVES WITH ARROW KEYS."
			add(status);
			
			status3 = new FlxText(FlxG.width / 2 - 50, FlxG.height - 30, 200);
			status3.color = 0x5f959baf4;
			//status3.shadow = 0x5f959baf4;
			status3.text = "RETURN TO MENU";
			add(status3);
			
			// Back to start menu
			if (FlxG.keys.ENTER)
			{
				FlxG.flash.start(0xffffffff, 0.2);
				FlxG.fade.start(0xff000000, 1, onFade);
			}				
		}
		
		private function onFade():void{
			if(selection==0)
				FlxG.state = new MenuState();
		}
		
	}

}