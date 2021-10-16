package net.wg.gui.battle.views.questProgress.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class QPTrackingDataItemVO extends DAAPIDataClass
   {
       
      
      public var operationName:String = "";
      
      public var missionName:String = "";
      
      public var fullMissionName:String = "";
      
      public var eyeBtnVisible:Boolean = false;
      
      public var selected:Boolean = false;
      
      public var vehicle:String = "";
      
      public var questID:int = -1;
      
      public var onPause:Boolean = false;
      
      public function QPTrackingDataItemVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
