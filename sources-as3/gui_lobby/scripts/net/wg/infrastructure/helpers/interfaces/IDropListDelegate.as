package net.wg.infrastructure.helpers.interfaces
{
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IDroppable;
   
   public interface IDropListDelegate extends IDroppable, IDisposable
   {
       
      
      function setPairedDropLists(param1:Vector.<InteractiveObject>) : void;
   }
}
