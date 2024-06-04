package net.wg.gui.lobby.hangar.quests
{
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public interface IHeaderSecondaryWidget extends IHeaderEntryPoint, IEventDispatcher
   {
       
      
      function animPosition(param1:int, param2:Object) : void;
      
      function get position() : Point;
      
      function set position(param1:Point) : void;
   }
}
