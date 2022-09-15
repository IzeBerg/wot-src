package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMinimapMeta extends IEventDispatcher
   {
       
      
      function onMinimapClickedS(param1:Number, param2:Number, param3:Number, param4:Number) : void;
      
      function applyNewSizeS(param1:Number) : void;
      
      function as_setSize(param1:int) : void;
      
      function as_setVisible(param1:Boolean) : void;
      
      function as_setAlpha(param1:Number) : void;
      
      function as_showVehiclesName(param1:Boolean) : void;
      
      function as_setBackground(param1:String) : void;
      
      function as_enableHintPanelWithData(param1:Boolean, param2:Boolean) : void;
      
      function as_disableHintPanel() : void;
      
      function as_updateHintPanelData(param1:Boolean, param2:Boolean) : void;
      
      function as_initPrebattleSize(param1:int) : void;
   }
}
