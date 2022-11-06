package net.wg.infrastructure.interfaces.entity
{
   import flash.display.InteractiveObject;
   
   public interface IDroppable extends IDragDropHitArea
   {
       
      
      function onBeforeDrop(param1:InteractiveObject, param2:InteractiveObject) : Boolean;
      
      function onStartDrop(param1:InteractiveObject, param2:InteractiveObject, param3:Number, param4:Number) : Boolean;
      
      function onEndDrop(param1:InteractiveObject, param2:InteractiveObject, param3:InteractiveObject, param4:InteractiveObject) : void;
      
      function onAfterDrop(param1:InteractiveObject, param2:InteractiveObject) : void;
      
      function getDropGroup() : Vector.<InteractiveObject>;
   }
}
