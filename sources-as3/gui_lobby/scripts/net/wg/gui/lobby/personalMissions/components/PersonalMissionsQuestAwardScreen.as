package net.wg.gui.lobby.personalMissions.components
{
   import fl.motion.easing.Quintic;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.RibbonAwards;
   import net.wg.gui.lobby.personalMissions.components.questAwardScreen.QuestConditions;
   import net.wg.gui.lobby.personalMissions.components.questAwardScreen.QuestStatus;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsQuestAwardScreenVO;
   import net.wg.infrastructure.base.meta.IPersonalMissionsQuestAwardScreenMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalMissionsQuestAwardScreenMeta;
   import net.wg.utils.ICommons;
   import net.wg.utils.ITextManager;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class PersonalMissionsQuestAwardScreen extends PersonalMissionsQuestAwardScreenMeta implements IPersonalMissionsQuestAwardScreenMeta
   {
      
      private static const CLOSE_BTN_BORDER_OFFSET:int = 41;
      
      private static const RIBBON_AWARDS_HEIGHT:uint = 151;
      
      private static const RIBBON_AWARDS_WIDTH:uint = 1600;
      
      private static const CLOSE_BTN_Y_OFFSET:int = 8;
      
      private static const HEIGHT_BIG:int = 1000;
      
      private static const RIBBON_AWARDS_Y_OFFSET_BIG:int = 133;
      
      private static const RIBBON_AWARDS_Y_OFFSET_SMALL:int = 128;
      
      private static const NEXT_QUEST_BTN_X_OFFSET:int = 7;
      
      private static const OPERATION_TF_Y_BIG_OFFSET:int = -563;
      
      private static const OPERATION_TF_Y_SMALL_OFFSET:int = -480;
      
      private static const QUEST_TF_Y_BIG_OFFSET:int = -521;
      
      private static const QUEST_TF_Y_SMALL_OFFSET:int = -442;
      
      private static const NEXT_QUEST_TITLE_Y_BIG_OFFSET:int = 35;
      
      private static const NEXT_QUEST_TITLE_Y_SMALL_OFFSET:int = -38;
      
      private static const BTN_Y_BIG_OFFSET:int = 76;
      
      private static const BTN_Y_SMALL_OFFSET:int = 66;
      
      private static const BTNS_GAP:int = 8;
      
      private static const MAIN_BTN_SMALL_WIDTH:int = 157;
      
      private static const MAIN_BTN_BIG_WIDTH:int = 195;
      
      private static const NEXT_QUEST_TF_Y_OFFSET:int = 1;
      
      private static const NEXT_QUEST_BTN_Y_OFFSET:int = 8;
      
      private static const QUEST_STATUS_Y_OFFSET:int = 4;
      
      private static const QUEST_CONDITIONS_Y_BIG_OFFSET:int = -85;
      
      private static const QUEST_CONDITIONS_Y_SMALL_OFFSET:int = -90;
      
      private static const TITLE_ANIM_DURATION:int = 1000;
      
      private static const TITLE_ANIM_Y_OFFSET:int = 70;
      
      private static const STATUS_ANIM_DURATION:int = 750;
      
      private static const STATUS_ANIM_Y_OFFSET:int = 30;
      
      private static const STATUS_ANIM_DELAY:int = 500;
      
      private static const CONDITIONS_ANIM_DELAY:int = 300;
      
      private static const RIBBON_AWARDS_ANIM_DELAY:int = 500;
      
      private static const FOOTER_ANIM_DURATION:int = 500;
      
      private static const FOOTER_ANIM_Y_OFFSET:int = 30;
      
      private static const FOOTER_ANIM_DELAY:int = 1200;
       
      
      public var ribbonAwards:RibbonAwards;
      
      public var operationTF:TextField;
      
      public var questTF:TextField;
      
      public var questStatus:QuestStatus;
      
      public var nextQuestTF:TextField;
      
      public var nextQuestTitle:TextField;
      
      public var nextQuestLink:ISoundButtonEx;
      
      public var mainBtn:ISoundButtonEx;
      
      public var extraBtn:ISoundButtonEx;
      
      public var questConditions:QuestConditions;
      
      private var _mainBtnLabel:String;
      
      private var _extraBtnLabel:String;
      
      private var _vo:PersonalMissionsQuestAwardScreenVO;
      
      private var _commons:ICommons;
      
      private var _textMgr:ITextManager;
      
      private var _isRibbonAwardsInit:Boolean = false;
      
      private var _isQuestConditionsInit:Boolean = false;
      
      private var _tweens:Vector.<Tween> = null;
      
      private var _wasAnimStarted:Boolean = false;
      
      private var _wasAnimCompleted:Boolean = false;
      
      public function PersonalMissionsQuestAwardScreen()
      {
         super();
         this._commons = App.utils.commons;
         this._textMgr = App.textMgr;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         closeBtn.label = PERSONAL_MISSIONS.AWARDSVIEW_CLOSEBTN_LABEL;
         closeBtn.y = closeBtn.height + CLOSE_BTN_Y_OFFSET | 0;
         closeBtn.addEventListener(Event.RESIZE,this.onCloseBtnResizeHandler);
         this.nextQuestLink.addEventListener(ButtonEvent.CLICK,this.onNextQuestLinkClickHandler);
         this.mainBtn.addEventListener(ButtonEvent.CLICK,this.onMainBtnClickHandler);
         this.extraBtn.addEventListener(ButtonEvent.CLICK,this.onExtraBtnClickHandler);
         this.ribbonAwards.addEventListener(Event.RESIZE,this.onRibbonAwardsResizeHandler);
         this.questConditions.addEventListener(Event.RESIZE,this.onQuestConditionsResizeHandler);
         this._tweens = new Vector.<Tween>(0);
         this.operationTF.alpha = 0;
         this.questTF.alpha = 0;
         this.questStatus.alpha = 0;
         this.nextQuestTF.alpha = 0;
         this.nextQuestTitle.alpha = 0;
         this.nextQuestLink.alpha = 0;
         this.mainBtn.alpha = 0;
         this.extraBtn.alpha = 0;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._vo != null && isInvalid(InvalidationType.DATA))
         {
            setBackground(this._vo.bgImage);
            this.operationTF.htmlText = this._vo.operationText;
            this.questStatus.setData(this._vo.status,this._vo.statusLabel);
            this.nextQuestTitle.htmlText = this._vo.nextQuestTitle;
            this.nextQuestTF.visible = this.nextQuestLink.visible = StringUtils.isNotEmpty(this._vo.nextQuestText);
            if(this.nextQuestTF.visible)
            {
               this.nextQuestTF.htmlText = this._vo.nextQuestText;
            }
            this.mainBtn.label = this._mainBtnLabel = this._vo.mainBtnLabel;
            this.extraBtn.label = this._extraBtnLabel = this._vo.extraBtnLabel;
            this.extraBtn.visible = StringUtils.isNotEmpty(this._extraBtnLabel);
            this.mainBtn.width = !!this.extraBtn.visible ? Number(MAIN_BTN_BIG_WIDTH) : Number(MAIN_BTN_SMALL_WIDTH);
         }
         if(this._vo != null && isInvalid(InvalidationType.SIZE))
         {
            this.cancelTasks();
            this.disposeTweens();
            this.ribbonAwards.x = (_width - RIBBON_AWARDS_WIDTH >> 1) + (RIBBON_AWARDS_WIDTH >> 1);
            this.operationTF.x = _width - this.operationTF.width >> 1;
            this.questStatus.x = _width - this.questStatus.bg.width >> 1;
            this._commons.updateTextFieldSize(this.nextQuestTitle,true,false);
            this.nextQuestTitle.x = _width - this.nextQuestTitle.width >> 1;
            if(this.nextQuestTF.visible)
            {
               this._commons.updateTextFieldSize(this.nextQuestTF,true,false);
               this.nextQuestTF.x = _width - this.nextQuestTF.width >> 1;
               this.nextQuestLink.x = this.nextQuestTF.x + this.nextQuestTF.width + NEXT_QUEST_BTN_X_OFFSET;
            }
            if(this.extraBtn.visible)
            {
               this.mainBtn.x = _width - (this.mainBtn.width + MAIN_BTN_BIG_WIDTH + BTNS_GAP) >> 1;
               this.extraBtn.x = this.mainBtn.x + this.mainBtn.width + BTNS_GAP | 0;
            }
            else
            {
               this.mainBtn.x = _width - this.mainBtn.width >> 1;
            }
            this.questTF.width = _width;
            this.ribbonAwards.y = _height - this.ribbonAwards.height >> 1;
            if(_height < HEIGHT_BIG)
            {
               this.ribbonAwards.y += RIBBON_AWARDS_Y_OFFSET_SMALL;
               this.operationTF.y = this.ribbonAwards.y + OPERATION_TF_Y_SMALL_OFFSET;
               this.questTF.y = this.ribbonAwards.y + QUEST_TF_Y_SMALL_OFFSET;
               this.nextQuestTitle.y = NEXT_QUEST_TITLE_Y_SMALL_OFFSET;
               this.mainBtn.y = BTN_Y_SMALL_OFFSET;
               this.questTF.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.HERO_TITLE,this._vo.questText);
            }
            else
            {
               this.ribbonAwards.y += RIBBON_AWARDS_Y_OFFSET_BIG;
               this.operationTF.y = this.ribbonAwards.y + OPERATION_TF_Y_BIG_OFFSET;
               this.questTF.y = this.ribbonAwards.y + QUEST_TF_Y_BIG_OFFSET;
               this.nextQuestTitle.y = NEXT_QUEST_TITLE_Y_BIG_OFFSET;
               this.mainBtn.y = BTN_Y_BIG_OFFSET;
               this.questTF.htmlText = this._textMgr.getTextStyleById(TEXT_MANAGER_STYLES.EPIC_TITLE,this._vo.questText);
            }
            this._commons.updateTextFieldSize(this.questTF,false,true);
            this.questStatus.y = this.questTF.y + this.questTF.height + QUEST_STATUS_Y_OFFSET | 0;
            this.nextQuestTitle.y += this.ribbonAwards.y + RIBBON_AWARDS_HEIGHT | 0;
            if(this.nextQuestTF.visible)
            {
               this.nextQuestTF.y = this.nextQuestTitle.y + this.nextQuestTitle.height + NEXT_QUEST_TF_Y_OFFSET | 0;
               this.nextQuestLink.y = this.nextQuestTF.y + NEXT_QUEST_BTN_Y_OFFSET;
            }
            this.mainBtn.y += this.nextQuestTitle.y + this.nextQuestTitle.height | 0;
            if(this.extraBtn.visible)
            {
               this.extraBtn.y = this.mainBtn.y;
            }
            this.layoutQuestConditions();
            if(this._wasAnimStarted && !this._wasAnimCompleted)
            {
               this._wasAnimCompleted = true;
               this.questConditions.show();
               this.ribbonAwards.show();
               this.operationTF.alpha = 1;
               this.questTF.alpha = 1;
               this.questStatus.alpha = 1;
               this.nextQuestTF.alpha = 1;
               this.nextQuestTitle.alpha = 1;
               this.nextQuestLink.alpha = 1;
               this.mainBtn.alpha = 1;
               this.extraBtn.alpha = 1;
            }
            if(!this._wasAnimStarted && this._isRibbonAwardsInit && this._isQuestConditionsInit)
            {
               this._wasAnimStarted = true;
               this.animateTitle();
            }
         }
      }
      
      override protected function layoutElements() : void
      {
         closeBtn.x = width - closeBtn.width - CLOSE_BTN_BORDER_OFFSET;
      }
      
      override protected function onDispose() : void
      {
         this.cancelTasks();
         this.disposeTweens();
         this._tweens = null;
         this.nextQuestLink.removeEventListener(ButtonEvent.CLICK,this.onNextQuestLinkClickHandler);
         this.nextQuestLink.dispose();
         this.nextQuestLink = null;
         this.mainBtn.removeEventListener(ButtonEvent.CLICK,this.onMainBtnClickHandler);
         this.mainBtn.dispose();
         this.mainBtn = null;
         this.extraBtn.removeEventListener(ButtonEvent.CLICK,this.onExtraBtnClickHandler);
         this.extraBtn.dispose();
         this.extraBtn = null;
         this.questStatus.dispose();
         this.questStatus = null;
         this.ribbonAwards.removeEventListener(Event.RESIZE,this.onRibbonAwardsResizeHandler);
         this.ribbonAwards.dispose();
         this.ribbonAwards = null;
         this.questConditions.removeEventListener(Event.RESIZE,this.onQuestConditionsResizeHandler);
         this.questConditions.dispose();
         this.questConditions = null;
         this.operationTF = null;
         this.questTF = null;
         this.nextQuestTF = null;
         this.nextQuestTitle = null;
         this._commons = null;
         this._textMgr = null;
         this._vo = null;
         closeBtn.removeEventListener(Event.RESIZE,this.onCloseBtnResizeHandler);
         super.onDispose();
      }
      
      override protected function setData(param1:PersonalMissionsQuestAwardScreenVO) : void
      {
         if(this._vo != param1 && param1 != null)
         {
            this._vo = param1;
            this._isRibbonAwardsInit = false;
            this.ribbonAwards.setData(this._vo.ribbonData);
            this._isQuestConditionsInit = false;
            this.questConditions.setData(this._vo.mainConditions,this._vo.addConditions,this._vo.mainHeaderProgressData,this._vo.addHeaderProgressData);
            invalidateData();
         }
      }
      
      override protected function onCloseBtn() : void
      {
         closeViewS();
      }
      
      override protected function onEscapeKeyDown() : void
      {
         closeViewS();
      }
      
      private function layoutQuestConditions() : void
      {
         this.questConditions.x = _width - this.questConditions.width >> 1;
         this.questConditions.y = _height < HEIGHT_BIG ? Number(QUEST_CONDITIONS_Y_SMALL_OFFSET) : Number(QUEST_CONDITIONS_Y_BIG_OFFSET);
         this.questConditions.y += this.ribbonAwards.y + this.questStatus.y + this.questStatus.height - this.questConditions.height >> 1;
      }
      
      private function animateTitle() : void
      {
         this.operationTF.y += TITLE_ANIM_Y_OFFSET;
         this.questTF.y += TITLE_ANIM_Y_OFFSET;
         var _loc1_:Object = {
            "paused":false,
            "ease":Quintic.easeOut
         };
         this._tweens.push(new Tween(TITLE_ANIM_DURATION,this.operationTF,{
            "alpha":1,
            "y":this.operationTF.y - TITLE_ANIM_Y_OFFSET
         },_loc1_),new Tween(TITLE_ANIM_DURATION,this.questTF,{
            "alpha":1,
            "y":this.questTF.y - TITLE_ANIM_Y_OFFSET
         },_loc1_));
         App.utils.scheduler.scheduleTask(this.animateStatus,STATUS_ANIM_DELAY);
      }
      
      private function animateStatus() : void
      {
         this.questStatus.y += STATUS_ANIM_Y_OFFSET;
         this._tweens.push(new Tween(STATUS_ANIM_DURATION,this.questStatus,{
            "alpha":1,
            "y":this.questStatus.y - STATUS_ANIM_Y_OFFSET
         },{
            "paused":false,
            "ease":Quintic.easeOut
         }));
         App.utils.scheduler.scheduleTask(this.animateConditions,CONDITIONS_ANIM_DELAY);
      }
      
      private function animateConditions() : void
      {
         this.questConditions.show();
         App.utils.scheduler.scheduleTask(this.animateRibbonAwards,RIBBON_AWARDS_ANIM_DELAY);
      }
      
      private function animateRibbonAwards() : void
      {
         this.ribbonAwards.show();
         App.utils.scheduler.scheduleTask(this.animateFooter,FOOTER_ANIM_DELAY);
      }
      
      private function animateFooter() : void
      {
         this.nextQuestTF.y += FOOTER_ANIM_Y_OFFSET;
         this.nextQuestTitle.y += FOOTER_ANIM_Y_OFFSET;
         this.nextQuestLink.y += FOOTER_ANIM_Y_OFFSET;
         this.mainBtn.y += FOOTER_ANIM_Y_OFFSET;
         this.extraBtn.y += FOOTER_ANIM_Y_OFFSET;
         var _loc1_:Object = {
            "paused":false,
            "ease":Quintic.easeOut
         };
         this._tweens.push(new Tween(FOOTER_ANIM_DURATION,this.nextQuestTF,{
            "alpha":1,
            "y":this.nextQuestTF.y - FOOTER_ANIM_Y_OFFSET
         },_loc1_),new Tween(FOOTER_ANIM_DURATION,this.nextQuestTitle,{
            "alpha":1,
            "y":this.nextQuestTitle.y - FOOTER_ANIM_Y_OFFSET
         },_loc1_),new Tween(FOOTER_ANIM_DURATION,this.nextQuestLink,{
            "alpha":1,
            "y":this.nextQuestLink.y - FOOTER_ANIM_Y_OFFSET
         },_loc1_),new Tween(FOOTER_ANIM_DURATION,this.mainBtn,{
            "alpha":1,
            "y":this.mainBtn.y - FOOTER_ANIM_Y_OFFSET
         },_loc1_));
         this._tweens.push(new Tween(FOOTER_ANIM_DURATION,this.extraBtn,{
            "alpha":1,
            "y":this.extraBtn.y - FOOTER_ANIM_Y_OFFSET
         },{
            "paused":false,
            "ease":Quintic.easeOut,
            "onComplete":this.onAnimComplete
         }));
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.splice(0,this._tweens.length);
      }
      
      private function cancelTasks() : void
      {
         App.utils.scheduler.cancelTask(this.animateStatus);
         App.utils.scheduler.cancelTask(this.animateConditions);
         App.utils.scheduler.cancelTask(this.animateRibbonAwards);
         App.utils.scheduler.cancelTask(this.animateFooter);
      }
      
      private function onAnimComplete() : void
      {
         this._wasAnimCompleted = true;
      }
      
      private function onNextQuestLinkClickHandler(param1:ButtonEvent) : void
      {
         onNextQuestLinkClickS();
      }
      
      private function onMainBtnClickHandler(param1:ButtonEvent) : void
      {
         switch(this._mainBtnLabel)
         {
            case PERSONAL_MISSIONS.QUESTAWARDSCREEN_OKBTN_LABEL:
               onOkBtnClickS();
               break;
            case PERSONAL_MISSIONS.QUESTAWARDSCREEN_CONTINUEBTN_LABEL:
               onContinueBtnClickS();
               break;
            case PERSONAL_MISSIONS.QUESTAWARDSCREEN_RECRUITBTN_LABEL:
               onRecruitBtnClickS();
         }
      }
      
      private function onExtraBtnClickHandler(param1:ButtonEvent) : void
      {
         switch(this._extraBtnLabel)
         {
            case PERSONAL_MISSIONS.QUESTAWARDSCREEN_NEXTQUESTBTN_LABEL:
               onNextQuestBtnClickS();
               break;
            case PERSONAL_MISSIONS.QUESTAWARDSCREEN_RECRUITBTN_LABEL:
               onRecruitBtnClickS();
         }
      }
      
      private function onCloseBtnResizeHandler(param1:Event) : void
      {
         this.layoutElements();
      }
      
      private function onQuestConditionsResizeHandler(param1:Event) : void
      {
         this._isQuestConditionsInit = true;
         invalidateSize();
      }
      
      private function onRibbonAwardsResizeHandler(param1:Event) : void
      {
         this._isRibbonAwardsInit = true;
         invalidateSize();
      }
   }
}
