package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.cyberSport.vo.CSIntroViewTextsVO;
   import net.wg.gui.rally.views.intro.BaseRallyIntroView;
   import net.wg.gui.rally.vo.IntroVehicleVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CyberSportIntroMeta extends BaseRallyIntroView
   {
       
      
      public var requestVehicleSelection:Function;
      
      public var startAutoMatching:Function;
      
      public var showSelectorPopup:Function;
      
      public var showStaticTeamStaff:Function;
      
      private var _introVehicleVO:IntroVehicleVO;
      
      private var _cSIntroViewTextsVO:CSIntroViewTextsVO;
      
      public function CyberSportIntroMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._introVehicleVO)
         {
            this._introVehicleVO.dispose();
            this._introVehicleVO = null;
         }
         if(this._cSIntroViewTextsVO)
         {
            this._cSIntroViewTextsVO.dispose();
            this._cSIntroViewTextsVO = null;
         }
         super.onDispose();
      }
      
      public function requestVehicleSelectionS() : void
      {
         App.utils.asserter.assertNotNull(this.requestVehicleSelection,"requestVehicleSelection" + Errors.CANT_NULL);
         this.requestVehicleSelection();
      }
      
      public function startAutoMatchingS() : void
      {
         App.utils.asserter.assertNotNull(this.startAutoMatching,"startAutoMatching" + Errors.CANT_NULL);
         this.startAutoMatching();
      }
      
      public function showSelectorPopupS() : void
      {
         App.utils.asserter.assertNotNull(this.showSelectorPopup,"showSelectorPopup" + Errors.CANT_NULL);
         this.showSelectorPopup();
      }
      
      public function showStaticTeamStaffS() : void
      {
         App.utils.asserter.assertNotNull(this.showStaticTeamStaff,"showStaticTeamStaff" + Errors.CANT_NULL);
         this.showStaticTeamStaff();
      }
      
      public final function as_setSelectedVehicle(param1:Object) : void
      {
         var _loc2_:IntroVehicleVO = this._introVehicleVO;
         this._introVehicleVO = new IntroVehicleVO(param1);
         this.setSelectedVehicle(this._introVehicleVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setTexts(param1:Object) : void
      {
         var _loc2_:CSIntroViewTextsVO = this._cSIntroViewTextsVO;
         this._cSIntroViewTextsVO = new CSIntroViewTextsVO(param1);
         this.setTexts(this._cSIntroViewTextsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setSelectedVehicle(param1:IntroVehicleVO) : void
      {
         var _loc2_:String = "as_setSelectedVehicle" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTexts(param1:CSIntroViewTextsVO) : void
      {
         var _loc2_:String = "as_setTexts" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
