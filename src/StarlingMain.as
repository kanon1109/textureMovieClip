package  
{
import cn.geckos.display.TextureMovieClip;
import flash.display.MovieClip;
import starling.display.Sprite;
/**
 * ...starling主类
 * @author Kanon
 */
public class StarlingMain extends Sprite 
{
	[Embed(source = "../assets/assets.swf", symbol = "mc")]
	private var McClass:Class;
	public function StarlingMain() 
	{
		var mc:MovieClip = new McClass();
		var textureMovieClip:TextureMovieClip = new TextureMovieClip(mc, this, 30);
		textureMovieClip.play();
	}
	
}
}