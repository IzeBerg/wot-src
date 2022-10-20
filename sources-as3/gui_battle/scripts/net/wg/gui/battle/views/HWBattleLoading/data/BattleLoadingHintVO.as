package net.wg.gui.battle.views.HWBattleLoading.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleLoadingHintVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var titlePart:String = "";
      
      public var description:String = "";
      
      public var background:String = "";
      
      public function BattleLoadingHintVO(param1:Object)
      {
         super(param1);
      }
   }
}
