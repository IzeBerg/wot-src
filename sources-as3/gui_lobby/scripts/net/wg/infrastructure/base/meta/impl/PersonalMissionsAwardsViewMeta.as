package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.personalMissions.data.PMAwardHeaderVO;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsAwardsViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PersonalMissionsAwardsViewMeta extends AbstractView
   {
       
      
      public var showVehiclePreview:Function;
      
      public var closeView:Function;
      
      public var showMissionByVehicleType:Function;
      
      public var buyMissionsByVehicleType:Function;
      
      private var _personalMissionsAwardsViewVO:PersonalMissionsAwardsViewVO;
      
      private var _pMAwardHeaderVO:PMAwardHeaderVO;
      
      public function PersonalMissionsAwardsViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._personalMissionsAwardsViewVO)
         {
            this._personalMissionsAwardsViewVO.dispose();
            this._personalMissionsAwardsViewVO = null;
         }
         if(this._pMAwardHeaderVO)
         {
            this._pMAwardHeaderVO.dispose();
            this._pMAwardHeaderVO = null;
         }
         super.onDispose();
      }
      
      public function showVehiclePreviewS() : void
      {
         App.utils.asserter.assertNotNull(this.showVehiclePreview,"showVehiclePreview" + Errors.CANT_NULL);
         this.showVehiclePreview();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public function showMissionByVehicleTypeS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.showMissionByVehicleType,"showMissionByVehicleType" + Errors.CANT_NULL);
         this.showMissionByVehicleType(param1);
      }
      
      public function buyMissionsByVehicleTypeS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.buyMissionsByVehicleType,"buyMissionsByVehicleType" + Errors.CANT_NULL);
         this.buyMissionsByVehicleType(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:PersonalMissionsAwardsViewVO = this._personalMissionsAwardsViewVO;
         this._personalMissionsAwardsViewVO = new PersonalMissionsAwardsViewVO(param1);
         this.setData(this._personalMissionsAwardsViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setHeaderData(param1:Object) : void
      {
         var _loc2_:PMAwardHeaderVO = this._pMAwardHeaderVO;
         this._pMAwardHeaderVO = new PMAwardHeaderVO(param1);
         this.setHeaderData(this._pMAwardHeaderVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:PersonalMissionsAwardsViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setHeaderData(param1:PMAwardHeaderVO) : void
      {
         var _loc2_:String = "as_setHeaderData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
