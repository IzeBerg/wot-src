package net.wg.gui.battle.eventBattle.views.battleHints.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class HintInfoVO extends DAAPIDataClass
   {
       
      
      public var message:String = "";
      
      public var iconSource:String = "";
      
      public var backgroundColor:String = "";
      
      public var timer:int = 0;
      
      public var useCountdownTimer:Boolean = false;
      
      public var applyCountdownTimerImmediately:Boolean = false;
      
      public function HintInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
