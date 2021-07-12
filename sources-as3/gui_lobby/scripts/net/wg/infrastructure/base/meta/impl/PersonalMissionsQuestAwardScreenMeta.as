package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsQuestAwardScreenVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PersonalMissionsQuestAwardScreenMeta extends AbstractScreen
   {
       
      
      public var closeView:Function;
      
      public var onNextQuestLinkClick:Function;
      
      public var onNextQuestBtnClick:Function;
      
      public var onRecruitBtnClick:Function;
      
      public var onContinueBtnClick:Function;
      
      public var onOkBtnClick:Function;
      
      private var _personalMissionsQuestAwardScreenVO:PersonalMissionsQuestAwardScreenVO;
      
      public function PersonalMissionsQuestAwardScreenMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._personalMissionsQuestAwardScreenVO)
         {
            this._personalMissionsQuestAwardScreenVO.dispose();
            this._personalMissionsQuestAwardScreenVO = null;
         }
         super.onDispose();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public function onNextQuestLinkClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onNextQuestLinkClick,"onNextQuestLinkClick" + Errors.CANT_NULL);
         this.onNextQuestLinkClick();
      }
      
      public function onNextQuestBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onNextQuestBtnClick,"onNextQuestBtnClick" + Errors.CANT_NULL);
         this.onNextQuestBtnClick();
      }
      
      public function onRecruitBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onRecruitBtnClick,"onRecruitBtnClick" + Errors.CANT_NULL);
         this.onRecruitBtnClick();
      }
      
      public function onContinueBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onContinueBtnClick,"onContinueBtnClick" + Errors.CANT_NULL);
         this.onContinueBtnClick();
      }
      
      public function onOkBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onOkBtnClick,"onOkBtnClick" + Errors.CANT_NULL);
         this.onOkBtnClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:PersonalMissionsQuestAwardScreenVO = this._personalMissionsQuestAwardScreenVO;
         this._personalMissionsQuestAwardScreenVO = new PersonalMissionsQuestAwardScreenVO(param1);
         this.setData(this._personalMissionsQuestAwardScreenVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:PersonalMissionsQuestAwardScreenVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
