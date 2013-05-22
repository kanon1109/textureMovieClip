package
{
import flash.display.Sprite;
import starling.core.Starling;

public class TextureMovieClipTest extends Sprite
{
	[SWF(width = 650, height = 500, frameRate = 60)]
	private var starling:Starling;
	public function TextureMovieClipTest() 
	{
		this.starling = new Starling(StarlingMain, stage);
		this.starling.start();
	}
}
}