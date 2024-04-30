package net.wg.gui.battle.battleRoyale.views.components.respawnMessages
{
   import flash.events.IEventDispatcher;
   import net.wg.gui.battle.battleRoyale.data.RespawnMessageVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IRespawnMessage extends IEventDispatcher, IDisposable
   {
       
      
      function setData(param1:RespawnMessageVO, param2:Boolean) : void;
      
      function show(param1:Boolean) : void;
      
      function hide() : void;
      
      function get currentTime() : Number;
      
      function get data() : RespawnMessageVO;
   }
}
