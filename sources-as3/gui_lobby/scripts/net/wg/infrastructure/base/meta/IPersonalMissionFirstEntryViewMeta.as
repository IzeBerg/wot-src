package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPersonalMissionFirstEntryViewMeta extends IEventDispatcher
   {
       
      
      function playVideoS() : void;
      
      function backBtnClickedS() : void;
      
      function onViewCloseS(param1:Boolean) : void;
      
      function onCardClickS(param1:int) : void;
      
      function onNextCardClickS(param1:int) : void;
      
      function onPrevCardClickS(param1:int) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_setDetailedCardData(param1:Object) : void;
   }
}
