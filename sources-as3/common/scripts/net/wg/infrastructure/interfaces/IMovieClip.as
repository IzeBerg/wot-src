package net.wg.infrastructure.interfaces
{
   import flash.display.Scene;
   
   public interface IMovieClip extends ISprite
   {
       
      
      function get currentFrame() : int;
      
      function get framesLoaded() : int;
      
      function get totalFrames() : int;
      
      function get trackAsMenu() : Boolean;
      
      function set trackAsMenu(param1:Boolean) : void;
      
      function play() : void;
      
      function stop() : void;
      
      function nextFrame() : void;
      
      function prevFrame() : void;
      
      function gotoAndPlay(param1:Object, param2:String = null) : void;
      
      function gotoAndStop(param1:Object, param2:String = null) : void;
      
      function get scenes() : Array;
      
      function get currentScene() : Scene;
      
      function get currentFrameLabel() : String;
      
      function get currentLabels() : Array;
      
      function prevScene() : void;
      
      function nextScene() : void;
      
      function get enabled() : Boolean;
      
      function set enabled(param1:Boolean) : void;
   }
}
