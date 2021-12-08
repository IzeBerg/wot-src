package net.wg.gui.lobby.hangar.eventEntryPoint
{
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IEventEntryPoint extends IDAAPIModule, IUIComponentEx
   {
       
      
      function get size() : int;
      
      function set size(param1:int) : void;
      
      function get margin() : Rectangle;
   }
}
