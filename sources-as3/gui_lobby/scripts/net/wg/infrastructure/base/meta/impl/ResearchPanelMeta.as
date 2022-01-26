package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.hangar.data.ResearchPanelVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ResearchPanelMeta extends BaseDAAPIComponent
   {
       
      
      public var goToResearch:Function;
      
      public var goToPostProgression:Function;
      
      public var addVehToCompare:Function;
      
      private var _researchPanelVO:ResearchPanelVO;
      
      public function ResearchPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._researchPanelVO)
         {
            this._researchPanelVO.dispose();
            this._researchPanelVO = null;
         }
         super.onDispose();
      }
      
      public function goToResearchS() : void
      {
         App.utils.asserter.assertNotNull(this.goToResearch,"goToResearch" + Errors.CANT_NULL);
         this.goToResearch();
      }
      
      public function goToPostProgressionS() : void
      {
         App.utils.asserter.assertNotNull(this.goToPostProgression,"goToPostProgression" + Errors.CANT_NULL);
         this.goToPostProgression();
      }
      
      public function addVehToCompareS() : void
      {
         App.utils.asserter.assertNotNull(this.addVehToCompare,"addVehToCompare" + Errors.CANT_NULL);
         this.addVehToCompare();
      }
      
      public final function as_updateCurrentVehicle(param1:Object) : void
      {
         var _loc2_:ResearchPanelVO = this._researchPanelVO;
         this._researchPanelVO = new ResearchPanelVO(param1);
         this.updateCurrentVehicle(this._researchPanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function updateCurrentVehicle(param1:ResearchPanelVO) : void
      {
         var _loc2_:String = "as_updateCurrentVehicle" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
