package net.wg.gui.battle.components.pointsOfInterestNotificationPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PointsOfInterestNotificationVO extends DAAPIDataClass
   {
       
      
      public var id:int = -1;
      
      public var type:int = -1;
      
      public var status:uint = 1.0;
      
      public var isAlly:Boolean = false;
      
      public var progress:int = -1;
      
      public function PointsOfInterestNotificationVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
