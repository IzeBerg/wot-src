package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITechTreeMeta extends IEventDispatcher
   {
       
      
      function requestNationTreeDataS() : void;
      
      function getNationTreeDataS(param1:String) : Object;
      
      function getPremiumPanelLabelsS() : Object;
      
      function request4UnlockS(param1:int) : void;
      
      function goToNextVehicleS(param1:Number) : void;
      
      function onCloseTechTreeS() : void;
      
      function request4VehCompareS(param1:Number) : void;
      
      function onBlueprintModeSwitchS(param1:Boolean) : void;
      
      function onGoToPremiumShopS(param1:String, param2:int) : void;
      
      function onGoToEarlyAccessS() : void;
      
      function onPlayHintAnimationS(param1:Boolean) : void;
      
      function as_setAvailableNations(param1:Array) : void;
      
      function as_setSelectedNation(param1:String) : void;
      
      function as_refreshNationTreeData(param1:String) : void;
      
      function as_setUnlockProps(param1:Array) : void;
      
      function as_hideNationsBar(param1:Boolean) : void;
      
      function as_showMiniClientInfo(param1:String, param2:String) : void;
      
      function as_setBlueprintsSwitchButtonState(param1:Boolean, param2:Boolean, param3:String, param4:Boolean) : void;
      
      function as_setBlueprintMode(param1:Boolean) : void;
      
      function as_setBlueprintBalance(param1:Object) : void;
      
      function as_closePremiumPanel() : void;
      
      function as_setVehicleCollectorState(param1:Boolean) : void;
   }
}
