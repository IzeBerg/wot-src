package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRibbonsPanelMeta extends IEventDispatcher
   {
       
      
      function onShowS(param1:Number) : void;
      
      function onChangeS() : void;
      
      function onHideS(param1:Number) : void;
      
      function as_setup(param1:Array, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Array) : void;
      
      function as_reset() : void;
      
      function as_addBattleEfficiencyEvent(param1:String, param2:Number, param3:String, param4:String, param5:String, param6:String, param7:int, param8:String) : void;
      
      function as_updateBattleEfficiencyEvent(param1:String, param2:Number, param3:String, param4:String, param5:String, param6:String, param7:int, param8:String) : void;
      
      function as_setSettings(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void;
   }
}
