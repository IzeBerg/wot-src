package net.wg.gui.lobby.fortifications.interfaces
{
   import flash.events.IEventDispatcher;
   import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleTimerVO;
   
   public interface IClanBattleTimer extends IEventDispatcher
   {
       
      
      function set visible(param1:Boolean) : void;
      
      function setData(param1:ClanBattleTimerVO) : void;
   }
}
