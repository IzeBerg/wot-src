package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleCompareViewMeta extends IEventDispatcher
   {
       
      
      function onBackClickS() : void;
      
      function onGoToPreviewClickS(param1:Number) : void;
      
      function onGoToHangarClickS(param1:Number) : void;
      
      function onSelectModulesClickS(param1:Number, param2:Number) : void;
      
      function onParamDeltaRequestedS(param1:Number, param2:String) : void;
      
      function onCrewLevelChangedS(param1:Number, param2:Number) : void;
      
      function onRemoveVehicleS(param1:Number) : void;
      
      function onRevertVehicleS(param1:Number) : void;
      
      function onRemoveAllVehiclesS() : void;
      
      function as_setStaticData(param1:Object) : void;
      
      function as_setParamsDelta(param1:Object) : void;
      
      function as_setVehicleParamsData(param1:Array) : void;
      
      function as_getVehiclesDP() : Object;
      
      function as_setVehiclesCountText(param1:String) : void;
   }
}
