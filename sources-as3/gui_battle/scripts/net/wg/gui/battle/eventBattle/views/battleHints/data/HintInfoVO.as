package net.wg.gui.battle.eventBattle.views.battleHints.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class HintInfoVO extends DAAPIDataClass
   {
       
      
      public var message:String = "";
      
      public var iconSource:String = "";
      
      public function HintInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
