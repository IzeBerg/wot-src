package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleRoyalePostmortemPanelMeta extends IEventDispatcher
   {
       
      
      function as_showDeadReason() : void;
      
      function as_setPlayerInfo(param1:String) : void;
      
      function as_setPostmortemPanelVisible(param1:Boolean) : void;
   }
}
