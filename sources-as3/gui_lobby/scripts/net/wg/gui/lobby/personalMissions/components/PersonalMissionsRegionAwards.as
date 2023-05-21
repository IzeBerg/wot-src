package net.wg.gui.lobby.personalMissions.components
{
   import flash.text.TextField;
   import net.wg.gui.lobby.components.AwardItemRendererEx;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsRegionAwardsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalMissionsRegionAwards extends UIComponentEx
   {
      
      private static const HUGE_AWARD_SIZE:int = 110;
       
      
      public var mainAwardTF:TextField = null;
      
      public var mainAward:AwardItemRendererEx = null;
      
      private var _model:PersonalMissionsRegionAwardsVO = null;
      
      public function PersonalMissionsRegionAwards()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mainAward.setSize(HUGE_AWARD_SIZE,HUGE_AWARD_SIZE);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this.mainAwardTF.text = this._model.mainAwardText;
            App.utils.commons.updateTextFieldSize(this.mainAwardTF,false,true);
         }
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.mainAwardTF = null;
         this.mainAward.dispose();
         this.mainAward = null;
         this._model = null;
         super.onDispose();
      }
      
      public function setData(param1:PersonalMissionsRegionAwardsVO) : void
      {
         if(param1 != null && this._model != param1)
         {
            this._model = param1;
            this.mainAward.setData(this._model.mainAward);
            invalidateData();
         }
      }
   }
}
