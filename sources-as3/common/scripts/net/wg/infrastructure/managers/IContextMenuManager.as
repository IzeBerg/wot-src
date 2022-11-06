package net.wg.infrastructure.managers
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.base.meta.IContextMenuManagerMeta;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IContextMenuManager extends IContextMenuManagerMeta, IDisposable
   {
       
      
      function show(param1:String, param2:DisplayObject = null, param3:Object = null) : void;
      
      function hide() : void;
      
      function isShown() : Boolean;
   }
}
