package net.wg.infrastructure.interfaces
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.media.SoundTransform;
   
   public interface ISprite extends IDisplayObjectContainer
   {
       
      
      function startDrag(param1:Boolean = false, param2:Rectangle = null) : void;
      
      function stopDrag() : void;
      
      function get graphics() : Graphics;
      
      function get buttonMode() : Boolean;
      
      function set buttonMode(param1:Boolean) : void;
      
      function get dropTarget() : DisplayObject;
      
      function get hitArea() : Sprite;
      
      function set hitArea(param1:Sprite) : void;
      
      function get useHandCursor() : Boolean;
      
      function set useHandCursor(param1:Boolean) : void;
      
      function get soundTransform() : SoundTransform;
      
      function set soundTransform(param1:SoundTransform) : void;
   }
}
