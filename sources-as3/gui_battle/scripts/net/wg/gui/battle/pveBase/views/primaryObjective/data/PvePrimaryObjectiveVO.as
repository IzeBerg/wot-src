package net.wg.gui.battle.pveBase.views.primaryObjective.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PvePrimaryObjectiveVO extends DAAPIDataClass
   {
       
      
      public var header:String = "";
      
      public var objective:String = "";
      
      public var title:String = "";
      
      public function PvePrimaryObjectiveVO(param1:Object)
      {
         super(param1);
      }
   }
}
