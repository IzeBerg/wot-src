package net.wg.gui.battle.mapsTraining.views.goals.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MapsTrainingGoalVO extends DAAPIDataClass
   {
       
      
      public var total:int = 0;
      
      public var vehClass:String = "";
      
      public function MapsTrainingGoalVO(param1:Object)
      {
         super(param1);
      }
   }
}
