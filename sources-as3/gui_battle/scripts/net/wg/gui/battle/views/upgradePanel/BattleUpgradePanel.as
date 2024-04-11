package net.wg.gui.battle.views.upgradePanel
{
   import fl.motion.easing.Quartic;
   import fl.motion.easing.Sine;
   import fl.transitions.easing.Strong;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import net.wg.gui.battle.battleRoyale.views.configurator.ChoiceInfoPanel;
   import net.wg.gui.battle.views.upgradePanel.data.UpgradePanelVO;
   import net.wg.gui.components.battleRoyale.ModuleConfiguratorEvent;
   import net.wg.infrastructure.base.meta.IBattleUpgradePanelMeta;
   import net.wg.infrastructure.base.meta.impl.BattleUpgradePanelMeta;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.motion.Tween;
   
   public class BattleUpgradePanel extends BattleUpgradePanelMeta implements IBattleUpgradePanelMeta
   {
      
      private static const PHASE_RESET:int = 0;
      
      private static const PHASE_SHOW_ALERT:int = 1;
      
      private static const PHASE_HIDE_ALERT:int = 2;
      
      private static const PHASE_SHOW_PANEL:int = 3;
      
      private static const PHASE_HIDE_PANEL:int = 4;
      
      private static const PHASE_SHOW_MESSAGE:int = 5;
      
      private static const PHASE_HIDE_MESSAGE:int = 6;
      
      private static const PHASE_SELECT:int = 7;
      
      private static const STATE_ACTIVE:int = 0;
      
      private static const STATE_ALERT_FLAG:int = 1;
      
      private static const STATE_DISABLED_FLAG:int = 2;
      
      private static const STATE_SELECT_FLAG:int = 4;
      
      private static const MIN_BG_SIZE:int = 1;
      
      private static const BG_MIN_WIDTH:int = 600;
      
      private static const BG_SIDE_MARGIN:int = 32;
      
      private static const BG_BOTTOM_MARGIN:int = 25;
      
      private static const ALERT_SHOW_LBL:String = "show";
      
      private static const ALERT_HIDE_LBL:String = "hide";
      
      private static const BG_ANIM_DURATION:int = 650;
      
      private static const TITLE_ANIM_DURATION:int = 300;
      
      private static const DESCRIPTION_ANIM_DELAY:int = 400;
      
      private static const DESCRIPTION_ANIM_DURATION:int = 250;
      
      private static const SELECT_BG_ANIM_DURATION:int = 200;
      
      private static const HOVER_BG_ANIM_DURATION:int = 160;
      
      private static const NOTIFICATION_BG_START_ALPHA_TWEEN_DURATION:uint = 125;
      
      private static const NOTIFICATION_BG_END_ALPHA_TWEEN_DURATION:uint = 500;
      
      private static const NOTIFICATION_BG_START_TWEEN_ALPHA:Number = 0.9;
      
      private static const NOTIFICATION_BG_END_TWEEN_ALPHA:Number = 0.6;
       
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var choicePanel:ChoiceInfoPanel = null;
      
      public var bg:Sprite = null;
      
      public var leftHitMc:Sprite = null;
      
      public var rightHitMc:Sprite = null;
      
      public var selectBG:Sprite = null;
      
      public var leftHoverBG:Sprite = null;
      
      public var rightHoverBG:Sprite = null;
      
      public var alertTF:TextField = null;
      
      public var alertAnim:Sprite = null;
      
      public var notificationBorderAnimation:NotificationBorderAnimation = null;
      
      private var _tweens:Vector.<Tween> = null;
      
      private var _messageTweens:Vector.<Tween> = null;
      
      private var _notificationTweens:Vector.<Tween> = null;
      
      private var _bgWidth:int = 0;
      
      private var _bgHeight:int = 0;
      
      private var _data:UpgradePanelVO = null;
      
      private var _phase:int = 0;
      
      private var _stateMask:int = 2;
      
      private var _noActionAnimVisible:Boolean = false;
      
      private var _scheduledPhase:uint = 0;
      
      private var _selectIdx:int = 0;
      
      private var _alertTF:TextField = null;
      
      private var _alertText:String = "";
      
      private var DEST_FILTERS:Array;
      
      public function BattleUpgradePanel()
      {
         this.DEST_FILTERS = [new DropShadowFilter(0,0,0,0.5,12,12),new DropShadowFilter(0,0,0,1,4,4)];
         super();
      }
      
      override public function isCompVisible() : Boolean
      {
         return _isCompVisible;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._alertTF = this.alertTF;
         this._tweens = new Vector.<Tween>(0);
         this._messageTweens = new Vector.<Tween>(0);
         this._notificationTweens = new Vector.<Tween>(0);
         this.alertAnim.addChild(this.alertTF);
         this.descriptionTF.filters = this.DEST_FILTERS;
         this.titleTF.alpha = this.descriptionTF.alpha = this.bg.alpha = this.selectBG.alpha = this.leftHoverBG.alpha = this.rightHoverBG.alpha = 0;
         this._alertTF.text = BATTLE_ROYALE.UPGRADEPANEL_ALERT_0;
         this.choicePanel.visible = false;
         this.choicePanel.initSettings(false,this.leftHitMc,this.rightHitMc);
         this.choicePanel.setDelimiterVisible(false);
         App.utils.commons.updateChildrenMouseBehavior(this,false,false,new <DisplayObject>[this.choicePanel]);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.choicePanel.addEventListener(ChoiceInfoPanel.SELECT_ANIM_COMPLETE,this.onChoiceInfoPanelAnimCompleteHandler);
         this.choicePanel.addEventListener(ModuleConfiguratorEvent.MODULE_CLICK,this.onChoicePanelModuleClickHandler);
         this.choicePanel.addEventListener(ModuleConfiguratorEvent.MODULE_OVER,this.onChoicePanelModuleOverHandler);
         this.choicePanel.addEventListener(ModuleConfiguratorEvent.MODULE_OUT,this.onChoicePanelModuleOutHandler);
         this.choicePanel.addEventListener(Event.RESIZE,this.onChoicePanelResizeHandler);
      }
      
      override protected function setData(param1:UpgradePanelVO) : void
      {
         this._data = param1;
         if(param1.isInitData)
         {
            this.choicePanel.setInitData(param1);
            this.descriptionTF.text = this._data.description;
         }
         if(this.state == STATE_ACTIVE || this.state == STATE_ALERT_FLAG)
         {
            this.tryApplyData();
         }
      }
      
      override protected function onDispose() : void
      {
         this._data = null;
         this._alertTF = null;
         this.clearTweens(this._tweens);
         this._tweens = null;
         this.clearTweens(this._messageTweens);
         this._messageTweens = null;
         this.clearTweens(this._notificationTweens);
         this._notificationTweens = null;
         this.notificationBorderAnimation.dispose();
         this.notificationBorderAnimation = null;
         this.choicePanel.removeEventListener(ChoiceInfoPanel.SELECT_ANIM_COMPLETE,this.onChoiceInfoPanelAnimCompleteHandler);
         this.choicePanel.removeEventListener(ModuleConfiguratorEvent.MODULE_CLICK,this.onChoicePanelModuleClickHandler);
         this.choicePanel.removeEventListener(ModuleConfiguratorEvent.MODULE_OVER,this.onChoicePanelModuleOverHandler);
         this.choicePanel.removeEventListener(ModuleConfiguratorEvent.MODULE_OUT,this.onChoicePanelModuleOutHandler);
         this.choicePanel.removeEventListener(Event.RESIZE,this.onChoicePanelResizeHandler);
         this.choicePanel.dispose();
         this.choicePanel = null;
         this.alertAnim = null;
         this.alertTF = null;
         this.selectBG = null;
         this.leftHoverBG = null;
         this.rightHoverBG = null;
         this.leftHitMc = null;
         this.rightHitMc = null;
         this.descriptionTF = null;
         this.titleTF = null;
         this.bg = null;
         super.onDispose();
      }
      
      override protected function updateVisibility() : void
      {
         this.visible = this.state == STATE_ACTIVE || this.state == STATE_ALERT_FLAG || this.state == STATE_SELECT_FLAG;
      }
      
      public function as_hideNotificationAnim() : void
      {
         if(this._noActionAnimVisible)
         {
            this.notificationBorderAnimation.reset();
            this.clearNotificationAnim();
            this._noActionAnimVisible = false;
         }
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         if(param1)
         {
            this.state -= STATE_DISABLED_FLAG;
         }
         else
         {
            this.state += STATE_DISABLED_FLAG;
         }
      }
      
      public function as_showNotificationAnim() : void
      {
         if(this._noActionAnimVisible || this.state != STATE_ACTIVE)
         {
            return;
         }
         this._noActionAnimVisible = true;
         this.notificationBorderAnimation.fadeIn();
         var _loc1_:Tween = new Tween(NOTIFICATION_BG_START_ALPHA_TWEEN_DURATION,this.bg,{"alpha":NOTIFICATION_BG_START_TWEEN_ALPHA},{"ease":Sine.easeInOut});
         var _loc2_:Tween = new Tween(NOTIFICATION_BG_END_ALPHA_TWEEN_DURATION,this.bg,{"alpha":NOTIFICATION_BG_END_TWEEN_ALPHA},{"ease":Quartic.easeOut});
         _loc2_.delay = NOTIFICATION_BG_START_ALPHA_TWEEN_DURATION;
         _loc2_.onComplete = this.clearNotificationAnim;
         this._notificationTweens.push(_loc1_);
         this._notificationTweens.push(_loc2_);
      }
      
      public function as_showSelectAnim(param1:int) : void
      {
         if(this.state != STATE_ACTIVE)
         {
            return;
         }
         this._selectIdx = param1;
         this.state += STATE_SELECT_FLAG;
      }
      
      public function as_toggleAlertState(param1:Boolean, param2:String) : void
      {
         if(param2 != null && this._alertText != param2)
         {
            this._alertTF.text = param2;
            this._alertText = param2;
         }
         if(param1)
         {
            this.state += STATE_ALERT_FLAG;
         }
         else
         {
            this.state -= STATE_ALERT_FLAG;
         }
      }
      
      private function clearNotificationAnim() : void
      {
         this.clearTweens(this._notificationTweens);
      }
      
      private function tryApplyData() : void
      {
         if(this._data != null)
         {
            this.titleTF.text = this._data.title;
            this.choicePanel.setData(this._data);
            this._data = null;
         }
      }
      
      private function implyPhase(param1:int) : void
      {
         if(param1 == this._phase || param1 == this._scheduledPhase && this._scheduledPhase != PHASE_RESET)
         {
            return;
         }
         if(this._phase != PHASE_RESET && param1 != PHASE_RESET && this._scheduledPhase == PHASE_RESET)
         {
            this._scheduledPhase = param1;
            return;
         }
         if(this._scheduledPhase != PHASE_RESET)
         {
            param1 += this._scheduledPhase;
            this._scheduledPhase = param1 - this._scheduledPhase;
            param1 -= this._scheduledPhase;
         }
         this.applyPhase(param1);
      }
      
      private function applyPhase(param1:int) : void
      {
         this.as_hideNotificationAnim();
         if(param1 == this._phase)
         {
            return;
         }
         this._phase = param1;
         switch(this._phase)
         {
            case PHASE_SELECT:
               this.clearTweens(this._tweens);
               this.choicePanel.showSelectAnim(this._selectIdx);
               this._tweens.push(new Tween(SELECT_BG_ANIM_DURATION,this.selectBG,{"alpha":1}));
               this.selectBG.x = this._selectIdx == 0 ? Number(-this.selectBG.width) : Number(0);
               this.leftHoverBG.alpha = this.rightHoverBG.alpha = 0;
               break;
            case PHASE_SHOW_PANEL:
               this.tryApplyData();
               this.showPanelParts();
               break;
            case PHASE_HIDE_PANEL:
               this.hidePanelParts();
               break;
            case PHASE_SHOW_MESSAGE:
               this.visible = true;
               this.tryApplyData();
               this.showPanelMessage();
               break;
            case PHASE_HIDE_MESSAGE:
               this.hidePanelMessage();
               this.implyPhase(PHASE_RESET);
               break;
            case PHASE_SHOW_ALERT:
               this.clearTweens(this._tweens);
               this.tryApplyData();
               gotoAndPlay(ALERT_SHOW_LBL);
               this.implyPhase(PHASE_RESET);
               break;
            case PHASE_HIDE_ALERT:
               this.clearTweens(this._tweens);
               gotoAndPlay(ALERT_HIDE_LBL);
               this.implyPhase(PHASE_RESET);
               break;
            case PHASE_RESET:
               this.updateVisibility();
         }
      }
      
      private function showPanelMessage() : void
      {
         this.clearTweens(this._messageTweens);
         this._messageTweens.push(new Tween(TITLE_ANIM_DURATION,this.titleTF,{"alpha":1},{"onComplete":this.onMessageShown()}));
      }
      
      private function hidePanelMessage() : void
      {
         this.clearTweens(this._messageTweens);
         this._messageTweens.push(new Tween(TITLE_ANIM_DURATION,this.titleTF,{"alpha":0}));
      }
      
      private function showPanelParts() : void
      {
         this.clearTweens(this._tweens);
         this.selectBG.alpha = this.descriptionTF.alpha = this.leftHoverBG.alpha = this.rightHoverBG.alpha = 0;
         this.choicePanel.visible = true;
         this.choicePanel.togglePartsVisibleAnim(true);
         this.bg.width = MIN_BG_SIZE;
         this.bg.height = MIN_BG_SIZE;
         this.bg.alpha = 0;
         this._tweens.push(new Tween(BG_ANIM_DURATION,this.bg,{
            "width":this._bgWidth,
            "height":this._bgHeight,
            "alpha":0.6
         },{
            "ease":Strong.easeOut,
            "onComplete":this.onShowAnimCompleteHandler
         }));
         this._tweens.push(new Tween(DESCRIPTION_ANIM_DURATION,this.descriptionTF,{"alpha":1},{
            "ease":Strong.easeOut,
            "delay":DESCRIPTION_ANIM_DELAY
         }));
      }
      
      private function hidePanelParts() : void
      {
         this.clearTweens(this._tweens);
         this.selectBG.alpha = this.leftHoverBG.alpha = this.rightHoverBG.alpha = 0;
         this.choicePanel.togglePartsVisibleAnim(false);
         this._tweens.push(new Tween(BG_ANIM_DURATION,this.bg,{
            "width":MIN_BG_SIZE,
            "height":MIN_BG_SIZE,
            "alpha":0.6
         },{
            "ease":Strong.easeOut,
            "onComplete":this.onHideAnimCompleteHandler
         }));
         this._tweens.push(new Tween(DESCRIPTION_ANIM_DURATION,this.descriptionTF,{"alpha":0},{"ease":Strong.easeOut}));
      }
      
      private function onMessageShown() : void
      {
         this.clearTweens(this._messageTweens);
         this.implyPhase(PHASE_RESET);
      }
      
      private function onShowAnimCompleteHandler() : void
      {
         this.clearTweens(this._tweens);
         this.implyPhase(PHASE_RESET);
      }
      
      private function onHideAnimCompleteHandler() : void
      {
         this.choicePanel.visible = false;
         this.clearTweens(this._tweens);
         this.bg.alpha = 0;
         this.implyPhase(PHASE_RESET);
         this.state -= STATE_SELECT_FLAG;
      }
      
      private function clearTweens(param1:Vector.<Tween>) : void
      {
         var _loc2_:Tween = null;
         if(param1.length)
         {
            for each(_loc2_ in param1)
            {
               _loc2_.dispose();
               _loc2_.paused = true;
            }
            param1.splice(0,param1.length);
         }
      }
      
      private function updateLayout() : void
      {
         this.bg.scaleX = this.bg.scaleY = 1;
         var _loc1_:int = this.choicePanel.getModuleInfoMaxBorderSize() << 1;
         this._bgWidth = Math.max(_loc1_ + (BG_SIDE_MARGIN << 1),BG_MIN_WIDTH);
         this._bgHeight = this.choicePanel.getModuleInfoMaxHeight() + BG_BOTTOM_MARGIN;
         this.bg.width = this._bgWidth;
         this.bg.height = this._bgHeight;
         this.leftHitMc.width = this.rightHitMc.width = this.selectBG.width = this.leftHoverBG.width = this.rightHoverBG.width = this._bgWidth >> 1;
         this.leftHitMc.height = this.rightHitMc.height = this.selectBG.height = this.leftHoverBG.height = this.rightHoverBG.height = this._bgHeight;
         this.leftHitMc.x = -this.leftHitMc.width;
         this.notificationBorderAnimation.width = this._bgWidth;
         this.notificationBorderAnimation.height = this._bgHeight;
         this.notificationBorderAnimation.y = this.bg.y + (this._bgHeight >> 1);
         if(this.choicePanel.contains(this.bg))
         {
            this.notificationBorderAnimation.y += this.choicePanel.y;
         }
         this.descriptionTF.y = this.choicePanel.y + this.bg.height;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1 && _isCompVisible;
      }
      
      public function get isActive() : Boolean
      {
         return this.state == STATE_ACTIVE;
      }
      
      private function get state() : int
      {
         if(this._stateMask >= STATE_SELECT_FLAG)
         {
            return STATE_SELECT_FLAG;
         }
         if(this._stateMask >= STATE_DISABLED_FLAG)
         {
            return STATE_DISABLED_FLAG;
         }
         return this._stateMask;
      }
      
      private function set state(param1:int) : void
      {
         var _loc2_:int = param1 - this.state;
         if(_loc2_ == 0)
         {
            return;
         }
         var _loc3_:int = this.state;
         this._stateMask = _loc2_ >= 0 ? int(this._stateMask | _loc2_) : int(this._stateMask & _loc2_ - 1);
         if(this.state == _loc3_)
         {
            return;
         }
         if((_loc3_ == STATE_ACTIVE || _loc3_ == STATE_ALERT_FLAG || _loc3_ == STATE_SELECT_FLAG) && this.state == STATE_DISABLED_FLAG)
         {
            this.implyPhase(PHASE_HIDE_MESSAGE);
         }
         else if((this.state == STATE_ACTIVE || this.state == STATE_ALERT_FLAG) && _loc3_ == STATE_DISABLED_FLAG)
         {
            this.implyPhase(PHASE_SHOW_MESSAGE);
         }
         if(this.state == STATE_SELECT_FLAG)
         {
            this.implyPhase(PHASE_SELECT);
         }
         else if(_loc3_ == STATE_ACTIVE)
         {
            this.implyPhase(PHASE_HIDE_PANEL);
         }
         else if(_loc3_ == STATE_ALERT_FLAG)
         {
            this.implyPhase(PHASE_HIDE_ALERT);
         }
         if(this.state == STATE_ALERT_FLAG)
         {
            this.implyPhase(PHASE_SHOW_ALERT);
         }
         else if(this.state == STATE_ACTIVE)
         {
            this.implyPhase(PHASE_SHOW_PANEL);
         }
         dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
      }
      
      private function onChoiceInfoPanelAnimCompleteHandler(param1:Event) : void
      {
         this.clearTweens(this._tweens);
         this.applyPhase(PHASE_HIDE_PANEL);
      }
      
      private function onChoicePanelResizeHandler(param1:Event) : void
      {
         this.updateLayout();
      }
      
      private function onChoicePanelModuleOverHandler(param1:ModuleConfiguratorEvent) : void
      {
         var _loc2_:DisplayObject = null;
         if(this.state == STATE_ACTIVE && this.choicePanel.visible)
         {
            _loc2_ = param1.moduleIdx == 0 ? this.leftHoverBG : this.rightHoverBG;
            this._tweens.push(new Tween(HOVER_BG_ANIM_DURATION,_loc2_,{"alpha":1}));
         }
      }
      
      private function onChoicePanelModuleOutHandler(param1:ModuleConfiguratorEvent) : void
      {
         var _loc2_:DisplayObject = null;
         if(this.state == STATE_ACTIVE && this.choicePanel.visible)
         {
            _loc2_ = param1.moduleIdx == 0 ? this.leftHoverBG : this.rightHoverBG;
            this._tweens.push(new Tween(HOVER_BG_ANIM_DURATION,_loc2_,{"alpha":0}));
         }
      }
      
      private function onChoicePanelModuleClickHandler(param1:ModuleConfiguratorEvent) : void
      {
         if(this.state == STATE_ACTIVE)
         {
            onSelectItemS(param1.moduleIntCD);
         }
      }
   }
}
