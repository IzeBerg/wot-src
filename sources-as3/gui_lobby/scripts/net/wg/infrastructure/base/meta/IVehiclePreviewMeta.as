package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehiclePreviewMeta extends IEventDispatcher
   {
       
      
      function closeViewS() : void;
      
      function onBackClickS() : void;
      
      function onOpenInfoTabS(param1:int) : void;
      
      function onCompareClickS() : void;
      
      function onGoToPostProgressionClickS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setTabsData(param1:Array) : void;
      
      function as_show3DSceneTooltip(param1:String, param2:Array) : void;
      
      function as_hide3DSceneTooltip() : void;
      
      function as_setBottomPanel(param1:String) : void;
      
      function as_setBulletVisibility(param1:int, param2:Boolean) : void;
   }
}
