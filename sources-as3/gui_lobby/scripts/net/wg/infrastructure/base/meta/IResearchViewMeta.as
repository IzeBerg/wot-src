package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IResearchViewMeta extends IEventDispatcher
   {
       
      
      function request4BuyS(param1:Number) : void;
      
      function request4InfoS(param1:Number, param2:Number) : void;
      
      function request4RestoreS(param1:Number) : void;
      
      function showSystemMessageS(param1:String, param2:String) : void;
      
      function goToBlueprintViewS(param1:int) : void;
      
      function goToNationChangeViewS(param1:int) : void;
      
      function goToVehicleCollectionS(param1:String) : void;
      
      function goToEarlyAccessQuestsViewS() : void;
      
      function goToEarlyAccessBuyViewS(param1:int) : void;
      
      function as_setNodesStates(param1:Number, param2:Array, param3:Boolean) : void;
      
      function as_setNext2Unlock(param1:Array) : void;
      
      function as_setVehicleTypeXP(param1:Array) : void;
      
      function as_setInventoryItems(param1:Array) : void;
      
      function as_setNodeVehCompareData(param1:Array) : void;
   }
}
