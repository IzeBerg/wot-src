package net.wg.infrastructure.interfaces
{
   import flash.display.DisplayObject;
   
   public interface ICustomObjectFinder
   {
       
      
      function getObjectByParams(param1:DisplayObject, param2:Object) : DisplayObject;
      
      function validateObjectPath(param1:Vector.<DisplayObject>) : Boolean;
   }
}
