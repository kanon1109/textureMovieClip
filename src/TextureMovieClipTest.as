package  
{
import flash.display.MovieClip;
import flash.display.Sprite;
import starling.core.Starling;
/**
 * ...纹理动画测试
 * @author Kanon
 */
public class TextureMovieClipTest extends Sprite 
{
	private var starling:Starling;
	[SWF(width = 650, height = 500, frameRate = 60)]
	public function TextureMovieClipTest() 
	{
		this.starling = new Starling(StarlingMain, stage);
		this.starling.start();
	}
	
}
}