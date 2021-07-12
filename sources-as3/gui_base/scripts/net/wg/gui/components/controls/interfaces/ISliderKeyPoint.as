package net.wg.gui.components.controls.interfaces
{
   import net.wg.infrastructure.interfaces.IDisplayObjectContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ISliderKeyPoint extends IDisposable, IDisplayObjectContainer
   {
       
      
      function get tooltip() : String;
      
      function set tooltip(param1:String) : void;
      
      function get index() : int;
      
      function set index(param1:int) : void;
      
      function get label() : String;
      
      function set label(param1:String) : void;
      
      function get clickable() : Boolean;
      
      function set clickable(param1:Boolean) : void;
   }
}
