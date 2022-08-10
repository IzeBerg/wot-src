package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPersonalMissionsOperationAwardsScreenMeta extends IEventDispatcher
   {
       
      
      function onCloseWindowS() : void;
      
      function onPlaySoundS(param1:String) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_setAwardData(param1:Object) : void;
      
      function as_setCloseBtnEnabled(param1:Boolean) : void;
      
      function as_playAwardsAnimation() : void;
   }
}
