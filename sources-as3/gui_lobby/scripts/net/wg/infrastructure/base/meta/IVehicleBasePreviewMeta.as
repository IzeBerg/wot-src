package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleBasePreviewMeta extends IEventDispatcher
   {
       
      
      function closeViewS() : void;
      
      function onBackClickS() : void;
      
      function onOpenInfoTabS(param1:int) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setAdditionalInfo(param1:Object) : void;
      
      function as_show3DSceneTooltip(param1:String, param2:Array) : void;
      
      function as_hide3DSceneTooltip() : void;
      
      function as_setBottomPanel(param1:String) : void;
   }
}
