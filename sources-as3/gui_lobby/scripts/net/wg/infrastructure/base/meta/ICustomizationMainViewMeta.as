package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICustomizationMainViewMeta extends IEventDispatcher
   {
       
      
      function showBuyWindowS() : void;
      
      function onCloseWindowS() : void;
      
      function fadeOutAnchorsS(param1:Boolean) : void;
      
      function changeSeasonS(param1:int, param2:Boolean) : void;
      
      function onLobbyClickS() : void;
      
      function onSelectAnchorS(param1:int, param2:int, param3:int) : void;
      
      function onHoverAnchorS(param1:int, param2:int, param3:int, param4:Boolean) : void;
      
      function onDragAnchorS(param1:int, param2:int, param3:int) : void;
      
      function onReleaseItemS() : void;
      
      function onAnchorsShownS(param1:Array) : void;
      
      function propertiesSheetSetS(param1:Object, param2:int, param3:int, param4:int, param5:int) : void;
      
      function onPressClearBtnS() : void;
      
      function onPressEscBtnS() : void;
      
      function onPressSelectNextItemS(param1:Boolean = false) : void;
      
      function playCustomSoundS(param1:String) : void;
      
      function onRemoveSelectedItemS() : void;
      
      function resetC11nItemsNoveltyS(param1:Array) : void;
      
      function onProgressionEntryPointClickS() : void;
      
      function as_hide(param1:Boolean) : void;
      
      function as_setHeaderData(param1:Object) : void;
      
      function as_setAnchorInit(param1:Object) : void;
      
      function as_updateAnchorData(param1:Object) : void;
      
      function as_onRegionHighlighted(param1:Object, param2:Boolean, param3:Boolean, param4:Boolean) : void;
      
      function as_updateSelectedRegions(param1:Object) : void;
      
      function as_setAnchorsData(param1:Object) : void;
      
      function as_setSeasonsBarData(param1:Array) : void;
      
      function as_enableDND(param1:Boolean) : void;
      
      function as_selectSeason(param1:int) : void;
      
      function as_releaseItem(param1:Boolean) : void;
      
      function as_showCarouselsArrowsNotification(param1:String) : void;
      
      function as_reselect(param1:Object) : void;
      
      function as_setNotificationCounters(param1:Array) : void;
      
      function as_setAnchorsState(param1:Object) : void;
      
      function as_attachToCursor(param1:Object) : void;
      
      function as_progressionEntryPointVisible(param1:Boolean) : void;
   }
}
