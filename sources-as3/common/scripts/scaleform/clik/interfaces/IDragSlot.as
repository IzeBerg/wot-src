package scaleform.clik.interfaces
{
   import flash.display.Sprite;
   import scaleform.clik.events.DragEvent;
   
   public interface IDragSlot extends IUIComponent
   {
       
      
      function get data() : Object;
      
      function set data(param1:Object) : void;
      
      function get content() : Sprite;
      
      function set content(param1:Sprite) : void;
      
      function handleDropEvent(param1:DragEvent) : Boolean;
      
      function handleDragStartEvent(param1:DragEvent) : void;
      
      function handleDragEndEvent(param1:DragEvent, param2:Boolean) : void;
   }
}
