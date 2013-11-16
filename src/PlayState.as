package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		private var gameObjects:FlxGroup,
					baddieList:FlxGroup;
		private var baddie:Enemy;
		private var player1:Reticle,
					player2:Reticle;
		private var baddieNum:int = 3;
		private var score1:int = 0,
					score2:int = 0,
					target:int = 100,
					checkpoint:int = 30;
		private var scoreShow:FlxText,
					scoreShow2:FlxText,
					winShow:FlxText;
		private var gameOver:Boolean = false;
		
		[Embed(source = "music/skydiving.mp3")] private var Song1:Class;
		[Embed(source = "gfx/back.png")] private var bgImg:Class;
		private var image:FlxSprite;
		
		override public function create():void
		{
			FlxG.mouse.show();
			
			//image = new FlxSprite(0, 0, bgImg);
			//this.add(image);
			
			baddieList = new FlxGroup();
			add(baddieList);
			spawnFactory(baddieNum);
			
			scoreShow = new FlxText(5, 220, 80, "Score 1: 0");
			scoreShow.shadow = 0xff0a6619;
			add(scoreShow);
			scoreShow2 = new FlxText(FlxG.width/2+12, 220, 80, "Score 2: 0");
			scoreShow2.shadow = 0xff0a6619;
			add(scoreShow2);
			
			player1 = new Reticle(FlxG.width/2-64, 180, 1);
			add(player1);
			player2 = new Reticle(FlxG.width/2+50, 180, 2);
			add(player2);
			
			gameObjects = new FlxGroup();
			gameObjects.add(baddieList);
			gameObjects.add(player1);
			gameObjects.add(player2);
			
			FlxG.playMusic(Song1, 1.0);
		}
		
		// Main Loop
		override public function update():void
		{
			if(FlxG.mouse.justPressed())
				FlxG.mouse.hide();
			
			super.update();
			
			FlxU.overlap(player1, baddieList, shoot);
			FlxU.overlap(player2, baddieList, shoot);
			
			win();
			
			//FlxG.showBounds = true;
			
			// Add more babies as scores increase.
			if (score1 > checkpoint || score2 > checkpoint && checkpoint <= 70){
				spawnFactory(1);
				checkpoint += 10;
			}
			
			// Let the players play another round
			if (gameOver == true && FlxG.keys.ENTER)
				FlxG.state = new PlayState();
		}
		
		/**
		 * Create enemies
		 * @param	amount  The number of enemies to create
		 */
		public function spawnFactory(amount:Number):void {
			var xVals:Array = [0],
				yVals:Array = [0];
			var newX:Number,
				newY:Number;
			var xSpace:int = FlxG.width / 3,
				ySpace:int = FlxG.height / 3;
			var checked:Boolean = true;
			
			/**
			 * Add enemies
			 */
			do {
				// Make sure the x,y values of the current Enemy we're drawing aren't too close to
				// any existing baddies.
				do {
					if(amount%3==0)
						newX = Math.random() * (FlxG.width/3 - 32);
					else if (amount % 2 == 0)
						newX = Math.random() * (FlxG.width*(2/3) - 32);
					else
						newX = Math.random() * (FlxG.width - 32);
					
					newY = 100*Math.random() * (-5);
					checked = true;
					
					for (var k:int = 0; k < xVals.length; k++) {
						var xCheck:Boolean = ((newX - xSpace) > (xVals[k] - xSpace)) && ((newX + xSpace) < (xVals[k] + 2*xSpace));
						var yCheck:Boolean = ((newY - ySpace) < (yVals[k] - ySpace)) && ((newY + ySpace) > (yVals[k] + 2*ySpace));
						if ((xCheck && yCheck) == true)
							checked = false;
					}
				} while (checked == false);
				
				xVals.push(newX);  // Add final x,y values to arrays so we can make sure the next Enemy we
				yVals.push(newY);  // create won't be too close to this one either.
				
				var type:String;
				var num:int = (Math.random() * 3 + 1);
				if(amount%num==0)
					type = "Baby";
				else
					type = "Ybab"
				baddie = new Enemy(newX, newY, type);
				baddieList.add(baddie);
				amount--;
			} while (amount > 0);
			
			/**
			 * Make sure we don't get the same type for all babies
			 */
			var type2:String = baddieList.members[0].type;
			var allSame:Boolean = true;
			
			for (var i:int = 1; i < baddieList.members.length; i++) {
				if (baddieList.members[i].type != type2)
					allSame = false;
			}
			
			if (allSame == true) {
				var m:int = Math.random() * (baddieList.members.length); // pick a random baby index to switch types for
				if(type2 == "Baby")
					baddieList.members[m].type = "Ybab";
				else
					baddieList.members[m].type = "Baby";
			}
		}
		
		public function checkAllOffScreen(list:FlxGroup):int {
			var count:int = 0;
			// Only work for Enemy objects (for now)
			if(list.members[0] is Enemy){
				for (var i:int = 0; i < list.members.length; i++) {
					var coord:Array = [list.members[i].x, list.members[i].y, list.members[i].width, list.members[i].height];
					if ((coord[0] + coord[2] < 0) || (coord[0] > FlxG.width) || (coord[1] > FlxG.height))
						count++;
				}
			}//trace(list.members[0] is Enemy);
			return count;
		}
		
		public function checkOneOffScreen(E:Enemy):Boolean {
			if (E.x + E.width < 0 || E.x > FlxG.width || E.y > FlxG.height || E.y < 0)
				return true;
			else
				return false;
		}
		
		public function shoot(P:Reticle, enemy:FlxSprite):void {
			var E:Enemy = enemy as Enemy;
			var x:Number = E.x,
				y:Number = E.y;
			var boomy:Boom;
			
			P.play("focus");
			
			if (FlxG.keys.V && P.id == 1) {
				boomy = new Boom(x, y);
				add(boomy);
				
				score1 += E.isShot() ? 2 : -10;
				scoreShow.text = "Score 1: " + score1;
				
				E.kill();
				spawnFactory(1);
			}
			else if (FlxG.keys.CONTROL && P.id == 2) {
				boomy = new Boom(x, y);
				add(boomy);
				
				score2 += E.isShot() ? 2 : -10;
				scoreShow2.text = "Score 2: " + score2;
				
				E.kill();
				spawnFactory(1);
			}
		}
		
		public function win():void {
			var player1win:Boolean = false, player2win:Boolean = false;
			var more:FlxText;
			
			if (score1 >= target && score2 < target)
				player1win = true;
			else if (score2 >= target && score1 < target)
				player2win = true;
			else if (score1 >= target && score2 >= target) {
				if (score1 > score2)
					player1win = true;
				else if (score2 < score1)
					player2win = true;
				else
					target += 10;
			}
			
			if ( (player1win == false) != (player2win == false) ) {
				gameObjects.kill();
				winShow = new FlxText( FlxG.width/2-35, FlxG.height/2-35, 80,
										(player1win ? "PLAYER 1 WINS" : "PLAYER 2 WINS") );
				winShow.shadow = 0xff0a6619;
				add(winShow);
				
				more = new FlxText(FlxG.width / 2 - 35, FlxG.height / 2 + 5, 80, "PRESS ENTER TO PLAY AGAIN");
				more.color = 0x5f139baf4;
				//more.shadow = 0xff0a6619;
				add(more);
				
				gameOver = true;
				FlxG.music.stop();
			}
		}
	}
}
