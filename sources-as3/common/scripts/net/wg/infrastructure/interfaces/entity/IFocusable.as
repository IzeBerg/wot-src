package net.wg.infrastructure.interfaces.entity
{
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.interfaces.ISprite;
   
   public interface IFocusable extends IIdentifiable, ISprite
   {
       
      
      function get focusable() : Boolean;
      
      function set focusable(param1:Boolean) : void;
      
      function get hasFocus() : Boolean;
      
      function get enabled() : Boolean;
      
      function set enabled(param1:Boolean) : void;
      
      function get focusTarget() : IFocusable;
      
      function set focusTarget(param1:IFocusable) : void;
      
      function get getDefFocusItem() : InteractiveObject;
   }
}
