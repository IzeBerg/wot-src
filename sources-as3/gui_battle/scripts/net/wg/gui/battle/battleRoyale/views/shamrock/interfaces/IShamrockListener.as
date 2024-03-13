package net.wg.gui.battle.battleRoyale.views.shamrock.interfaces
{
   import flash.events.IEventDispatcher;
   
   public interface IShamrockListener extends IEventDispatcher
   {
       
      
      function setShamrocks(param1:int) : void;
      
      function addShamrocks(param1:int, param2:int, param3:Boolean) : void;
      
      function collected(param1:int, param2:int, param3:Boolean) : void;
   }
}
