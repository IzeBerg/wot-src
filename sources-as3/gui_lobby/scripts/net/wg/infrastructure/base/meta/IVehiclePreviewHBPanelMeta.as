package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehiclePreviewHBPanelMeta extends IEventDispatcher
   {
       
      
      function onAcceptClickedS() : void;
      
      function onSecondaryClickedS() : void;
      
      function showTooltipS(param1:String, param2:String) : void;
      
      function as_setData(param1:Object) : void;
   }
}
