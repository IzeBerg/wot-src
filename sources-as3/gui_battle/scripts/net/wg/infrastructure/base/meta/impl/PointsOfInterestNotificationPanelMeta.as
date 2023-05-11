package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.components.pointsOfInterestNotificationPanel.data.PointsOfInterestNotificationVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PointsOfInterestNotificationPanelMeta extends BattleDisplayable
   {
       
      
      private var _pointsOfInterestNotificationVO:PointsOfInterestNotificationVO;
      
      public function PointsOfInterestNotificationPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._pointsOfInterestNotificationVO)
         {
            this._pointsOfInterestNotificationVO.dispose();
            this._pointsOfInterestNotificationVO = null;
         }
         super.onDispose();
      }
      
      public final function as_addPoiStatus(param1:Object) : void
      {
         var _loc2_:PointsOfInterestNotificationVO = this._pointsOfInterestNotificationVO;
         this._pointsOfInterestNotificationVO = new PointsOfInterestNotificationVO(param1);
         this.addPoiStatus(this._pointsOfInterestNotificationVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function addPoiStatus(param1:PointsOfInterestNotificationVO) : void
      {
         var _loc2_:String = "as_addPoiStatus" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
