package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesDivisionQualificationMeta extends IEventDispatcher
   {
       
      
      function as_setQualificationEfficiencyData(param1:Object) : void;
      
      function as_setQualificationStepsData(param1:Object) : void;
      
      function as_setQualificationData(param1:String, param2:String, param3:Boolean) : void;
      
      function as_setQualificationProgress(param1:String, param2:String, param3:Boolean, param4:String) : void;
   }
}
