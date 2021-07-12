package net.wg.gui.interfaces
{
   public interface IButtonIconLoader extends ISoundButtonEx
   {
       
      
      function get iconSource() : String;
      
      function set iconSource(param1:String) : void;
      
      function get iconOffsetTop() : Number;
      
      function set iconOffsetTop(param1:Number) : void;
      
      function get iconOffsetLeft() : Number;
      
      function set iconOffsetLeft(param1:Number) : void;
   }
}
