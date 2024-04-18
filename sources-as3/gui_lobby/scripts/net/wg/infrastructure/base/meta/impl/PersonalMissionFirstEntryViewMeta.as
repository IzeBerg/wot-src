package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.personalMissions.data.InfoAdditionalDataVO;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionFirstEntryViewVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PersonalMissionFirstEntryViewMeta extends AbstractScreen
   {
       
      
      public var playVideo:Function;
      
      public var backBtnClicked:Function;
      
      public var onViewClose:Function;
      
      public var onCardClick:Function;
      
      public var onNextCardClick:Function;
      
      public var onPrevCardClick:Function;
      
      private var _personalMissionFirstEntryViewVO:PersonalMissionFirstEntryViewVO;
      
      private var _infoAdditionalDataVO:InfoAdditionalDataVO;
      
      public function PersonalMissionFirstEntryViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._personalMissionFirstEntryViewVO)
         {
            this._personalMissionFirstEntryViewVO.dispose();
            this._personalMissionFirstEntryViewVO = null;
         }
         if(this._infoAdditionalDataVO)
         {
            this._infoAdditionalDataVO.dispose();
            this._infoAdditionalDataVO = null;
         }
         super.onDispose();
      }
      
      public function playVideoS() : void
      {
         App.utils.asserter.assertNotNull(this.playVideo,"playVideo" + Errors.CANT_NULL);
         this.playVideo();
      }
      
      public function backBtnClickedS() : void
      {
         App.utils.asserter.assertNotNull(this.backBtnClicked,"backBtnClicked" + Errors.CANT_NULL);
         this.backBtnClicked();
      }
      
      public function onViewCloseS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onViewClose,"onViewClose" + Errors.CANT_NULL);
         this.onViewClose(param1);
      }
      
      public function onCardClickS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onCardClick,"onCardClick" + Errors.CANT_NULL);
         this.onCardClick(param1);
      }
      
      public function onNextCardClickS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onNextCardClick,"onNextCardClick" + Errors.CANT_NULL);
         this.onNextCardClick(param1);
      }
      
      public function onPrevCardClickS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onPrevCardClick,"onPrevCardClick" + Errors.CANT_NULL);
         this.onPrevCardClick(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:PersonalMissionFirstEntryViewVO = this._personalMissionFirstEntryViewVO;
         this._personalMissionFirstEntryViewVO = new PersonalMissionFirstEntryViewVO(param1);
         this.setInitData(this._personalMissionFirstEntryViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setDetailedCardData(param1:Object) : void
      {
         var _loc2_:InfoAdditionalDataVO = this._infoAdditionalDataVO;
         this._infoAdditionalDataVO = new InfoAdditionalDataVO(param1);
         this.setDetailedCardData(this._infoAdditionalDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:PersonalMissionFirstEntryViewVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setDetailedCardData(param1:InfoAdditionalDataVO) : void
      {
         var _loc2_:String = "as_setDetailedCardData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
