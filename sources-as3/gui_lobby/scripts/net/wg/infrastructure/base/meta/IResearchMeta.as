package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IResearchMeta extends IEventDispatcher
   {
       
      
      function requestResearchDataS() : void;
      
      function request4UnlockS(param1:int, param2:Boolean) : void;
      
      function request4RentS(param1:int) : void;
      
      function goToNextVehicleS(param1:Number) : void;
      
      function exitFromResearchS() : void;
      
      function goToVehicleViewS(param1:Number) : void;
      
      function compareVehicleS(param1:Number) : void;
      
      function onModuleHoverS(param1:Number) : void;
      
      function goToPostProgressionS(param1:Number) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setRootData(param1:Object) : void;
      
      function as_setResearchItems(param1:String, param2:Object) : void;
      
      function as_setFreeXP(param1:Number) : void;
      
      function as_setInstalledItems(param1:Array) : void;
      
      function as_setWalletStatus(param1:Object) : void;
      
      function as_setXpInfoLinkage(param1:String) : void;
      
      function as_setPostProgressionData(param1:Object) : void;
      
      function as_showPostProgressionUnlockAnimation() : void;
   }
}
