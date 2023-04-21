package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IHangarHeaderMeta extends IEventDispatcher
   {
       
      
      function onQuestBtnClickS(param1:String, param2:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_createBattlePass() : void;
      
      function as_removeBattlePass() : void;
      
      function as_createRankedBattles() : void;
      
      function as_removeRankedBattles() : void;
      
      function as_createBattleRoyale() : void;
      
      function as_removeBattleRoyale() : void;
      
      function as_createBattleRoyaleTournament() : void;
      
      function as_removeBattleRoyaleTournament() : void;
      
      function as_createEpicWidget() : void;
      
      function as_removeEpicWidget() : void;
      
      function as_createFunRandomWidget() : void;
      
      function as_removeFunRandomWidget() : void;
      
      function as_setSecondaryEntryPointVisible(param1:Boolean) : void;
      
      function as_setResourceWellEntryPoint(param1:Boolean) : void;
      
      function as_setBattleMattersEntryPoint(param1:Boolean) : void;
      
      function as_setCollectiveGoalEntryPoint(param1:Boolean) : void;
      
      function as_setArmoryYardEntryPoint(param1:Boolean) : void;
      
      function as_createComp7() : void;
      
      function as_removeComp7() : void;
   }
}
