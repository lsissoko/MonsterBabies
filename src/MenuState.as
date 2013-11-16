package  
{	
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		//[Embed(source = ".png")] protected var TitleImage:Class;
		protected var image:FlxSprite;
		protected var selection:int = 0;
		protected var status:FlxText;
		
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
			status = new FlxText(15, 35,FlxG.width-15, "FIND THE MONSTER BABIES AND SAVE THE REGULAR HUMAN BABIES FROM PERIL 9000!!!!");			
			status.color = 0x5f139baf4;
			add(status);
			// Select between Game and Instruction Menu
			if (selection == 0 && FlxG.keys.DOWN)
				selection = 1;
			if (selection == 1 && FlxG.keys.UP)
				selection = 0;
			
			if(selection==0){
				status = new FlxText(FlxG.width/2-40,FlxG.height/2+12,80);
				status.shadow = 0xff0000ff;
				status.text = "START GAME";
				add(status);
				status = new FlxText(FlxG.width/2-40,FlxG.height/2+36,80);
				status.shadow = 0xff000000;
				status.text = "INSTRUCTIONS";
				add(status);
			}
			else
			{
				status = new FlxText(FlxG.width/2-40,FlxG.height/2+12,80);
				status.shadow = 0xff000000;
				status.text = "START GAME";
				add(status);
				status = new FlxText(FlxG.width/2-40,FlxG.height/2+36,80);
				status.shadow = 0xff0000ff;
				status.text = "INSTRUCTIONS";
				add(status);
			}/**
			status = new FlxText(FlxG.width / 2 - 40, FlxG.height / 2 + 80, 80);			
			status.color = 0x5f959baf4;
			//status.shadow = 0xff000000;
			status.text = "PRESS ENTER";
			add(status);*/
			
			status = new FlxText(30, FlxG.height-20,FlxG.width-15, "an HPLD production");			
			status.color = 0x5f139baf4;
			add(status);
			
			// Start game if Enter button is pressed
			if (FlxG.keys.ENTER)
			{
				FlxG.flash.start(0xffffffff, 0.5);
				FlxG.fade.start(0xff000000, 1, onFade);
			}				
		}
		
		private function onFade():void
		{
			if(selection==0)
				FlxG.state = new PlayState();
			else if(selection==1)
				FlxG.state = new InstructionState();
		}
		
	}

}