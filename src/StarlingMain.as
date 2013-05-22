package  
{
import cn.geckos.display.TextureMovieClip;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.MovieClip;
import flash.events.Event;
import flash.net.URLRequest;
import starling.display.Sprite;
/**
 * ...starling主类
 * @author Kanon
 */
public class StarlingMain extends Sprite 
{
	public function StarlingMain() 
	{
		var loader:Loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
		loader.load(new URLRequest("../assets/assets.swf"));
	}
	
	private function loaderComplete(event:Event):void 
	{
		trace("loaderComplete");
		var contentLoaderInfo:LoaderInfo = event.currentTarget as LoaderInfo;
		var MyClass:Class = contentLoaderInfo.applicationDomain.getDefinition("mc1") as Class;
		var mc:MovieClip = new MyClass();
		
		var textureMovieClip:TextureMovieClip = new TextureMovieClip(mc, this, 30);
		textureMovieClip.play();
	}
	
}
}