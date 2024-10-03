package net.wg.white_tiger.gui.battle.views.wtBattleHints.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class HintInfoVO extends DAAPIDataClass
   {
       
      
      public var message:String = "";
      
      public var iconSource:String = "";
      
      public var backgroundColor:String = "";
      
      public var timer:int = 0;
      
      public var useCountdownTimer:Boolean = false;
      
      public function HintInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
