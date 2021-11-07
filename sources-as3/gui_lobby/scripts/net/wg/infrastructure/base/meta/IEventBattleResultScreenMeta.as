package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBattleResultScreenMeta extends IEventDispatcher
   {
       
      
      function closeViewS() : void;
      
      function playSliderSoundS() : void;
      
      function playPointsSoundS() : void;
      
      function playQuestSoundS() : void;
      
      function playRewardSoundS() : void;
      
      function playProgressBarSoundS() : void;
      
      function addToSquadS(param1:Number) : void;
      
      function addToFriendS(param1:Number, param2:String) : void;
      
      function as_setVictoryData(param1:Object, param2:Boolean, param3:Array) : void;
      
      function as_playAnimation() : void;
      
      function as_addToSquadResult(param1:Boolean, param2:Number) : void;
      
      function as_addToFriendResult(param1:Number, param2:Boolean, param3:Boolean) : void;
   }
}
