package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleDamageLogPanelMeta extends IEventDispatcher
   {
       
      
      function as_setSettingsDamageLogComponent(param1:Boolean, param2:Boolean) : void;
      
      function as_summaryStats(param1:String, param2:String, param3:String, param4:String, param5:String, param6:Boolean) : void;
      
      function as_updateSummaryDamageValue(param1:String) : void;
      
      function as_updateSummaryBlockedValue(param1:String) : void;
      
      function as_updateSummaryAssistValue(param1:String) : void;
      
      function as_updateSummaryStunValue(param1:String) : void;
      
      function as_updateSummarySupplyDamageValue(param1:String) : void;
      
      function as_detailStatsTop(param1:Boolean, param2:Boolean, param3:Array) : void;
      
      function as_addDetailMessageTop(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void;
      
      function as_detailStatsBottom(param1:Boolean, param2:Boolean, param3:Array) : void;
      
      function as_addDetailMessageBottom(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void;
      
      function as_isDownCtrlButton(param1:Boolean) : void;
      
      function as_isDownAltButton(param1:Boolean) : void;
   }
}
