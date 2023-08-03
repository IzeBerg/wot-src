package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsAbstractInfoViewVO;
   import net.wg.infrastructure.base.meta.IPersonalMissionsAbstractInfoViewMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalMissionsAbstractInfoViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class PersonalMissionsAbstractInfoView extends PersonalMissionsAbstractInfoViewMeta implements IPersonalMissionsAbstractInfoViewMeta
   {
      
      private static const INVALID_DATA_INIT:String = "invalidDataInit";
      
      private static const CONTENT_OFFSET:int = 105;
      
      private static const MIN_CONTENT_OFFSET:int = 85;
      
      private static const MIN_SCR_HEIGHT:int = 768;
      
      private static const BIG_BTN_GAP:int = 195;
       
      
      public var bigBtn:ISoundButtonEx = null;
      
      public var subTitleTF:TextField = null;
      
      public var titleTF:TextField = null;
      
      public var sparks:Sprite = null;
      
      private var _data:PersonalMissionsAbstractInfoViewVO;
      
      public function PersonalMissionsAbstractInfoView()
      {
         super();
         fadeEnable = true;
      }
      
      override protected function setInitData(param1:PersonalMissionsAbstractInfoViewVO) : void
      {
         this._data = param1;
         invalidate(INVALID_DATA_INIT);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(INVALID_DATA_INIT))
         {
            setBackground(this._data.bgSource);
            this.titleTF.htmlText = this._data.titleLabel;
            App.utils.commons.updateTextFieldSize(this.titleTF,true,true);
            this.subTitleTF.htmlText = this._data.subtitleLabel;
            App.utils.commons.updateTextFieldSize(this.subTitleTF,true,true);
            this.bigBtn.label = this._data.bigBtnLabel;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.sparks.x = width - this.sparks.width >> 1;
            this.sparks.y = height - this.sparks.height >> 0;
            this.titleTF.x = width - this.titleTF.width >> 1;
            this.subTitleTF.x = width - this.subTitleTF.width >> 1;
            this.bigBtn.x = width - this.bigBtn.width >> 1;
            this.bigBtn.y = (height >> 1) + BIG_BTN_GAP + this.getVerticalContentOffset();
         }
      }
      
      override protected function layoutBackground() : void
      {
         super.layoutBackground();
         bgHolder.y = height - bgHolder.height >> 1;
      }
      
      override protected function onDispose() : void
      {
         this.bigBtn.removeEventListener(ButtonEvent.CLICK,this.onProceedBtnClickHandler);
         this.bigBtn.dispose();
         this.bigBtn = null;
         this.titleTF = null;
         this.subTitleTF = null;
         this.sparks = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.sparks.mouseEnabled = this.sparks.mouseChildren = false;
         this.bigBtn.addEventListener(ButtonEvent.CLICK,this.onProceedBtnClickHandler);
         App.popoverMgr.hide();
      }
      
      override protected function getPersonalMissionsAbstractInfoViewVOForData(param1:Object) : PersonalMissionsAbstractInfoViewVO
      {
         return new PersonalMissionsAbstractInfoViewVO(param1);
      }
      
      protected function getVerticalContentOffset() : int
      {
         return height < MIN_SCR_HEIGHT ? int(MIN_CONTENT_OFFSET) : int(CONTENT_OFFSET);
      }
      
      private function onProceedBtnClickHandler(param1:ButtonEvent) : void
      {
         bigBtnClickedS();
      }
   }
}
