package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPersonalMissionsPageMeta extends IEventDispatcher
   {
       
      
      function onBarClickS(param1:int, param2:int) : void;
      
      function onSkipTaskClickS() : void;
      
      function onBackBtnClickS() : void;
      
      function closeViewS() : void;
      
      function onTutorialAcceptBtnClickedS() : void;
      
      function showAwardsS() : void;
      
      function as_setContentVisible(param1:Boolean) : void;
      
      function as_initView(param1:int, param2:int) : void;
      
      function as_reInitView(param1:int, param2:int) : void;
      
      function as_setHeaderData(param1:Object) : void;
      
      function as_updateSideBarData(param1:Object) : void;
      
      function as_setStatusData(param1:Object) : void;
      
      function as_setSelectedBranchIndex(param1:int) : void;
      
      function as_showFirstAwardSheetObtainedPopup(param1:Boolean, param2:Object) : void;
      
      function as_showFourAwardSheetsObtainedPopup(param1:Boolean, param2:Object) : void;
      
      function as_hideAwardSheetObtainedPopup() : void;
      
      function as_showAwardsPopoverForTutor() : void;
   }
}
