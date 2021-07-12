package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPersonalMissionsQuestAwardScreenMeta extends IEventDispatcher
   {
       
      
      function closeViewS() : void;
      
      function onNextQuestLinkClickS() : void;
      
      function onNextQuestBtnClickS() : void;
      
      function onRecruitBtnClickS() : void;
      
      function onContinueBtnClickS() : void;
      
      function onOkBtnClickS() : void;
      
      function as_setData(param1:Object) : void;
   }
}
