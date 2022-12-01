package net.wg.gui.notification.interfaces
{
   import flash.display.DisplayObject;
   import net.wg.gui.components.containers.Group;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IServiceMessage extends IUIComponentEx
   {
       
      
      function getTextFields() : Array;
      
      function get data() : Object;
      
      function set data(param1:Object) : void;
      
      function cleanUp() : void;
      
      function get messageTopOffset() : Number;
      
      function set messageTopOffset(param1:Number) : void;
      
      function get messageBottomOffset() : Number;
      
      function set messageBottomOffset(param1:Number) : void;
      
      function get buttonsGroup() : Group;
      
      function get buttonsAnchor() : DisplayObject;
      
      function get buttonsTopPadding() : int;
      
      function get buttonsBottomPadding() : int;
      
      function get contentTopOffset() : int;
      
      function set contentTopOffset(param1:int) : void;
      
      function get contentBottomOffset() : int;
      
      function set contentBottomOffset(param1:int) : void;
      
      function get contentOffset() : int;
   }
}
