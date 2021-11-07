package net.wg.gui.battle.views.ribbonsPanel
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
   import net.wg.gui.battle.views.ribbonsPanel.data.RibbonAnimationStates;
   import net.wg.gui.components.ribbon.RibbonIcons;
   import net.wg.gui.components.ribbon.RibbonTexts;
   import net.wg.gui.components.ribbon.data.RibbonSettings;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.IScheduler;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class RibbonCtrl implements IDisposable
   {
      
      public static const SHOW_ANIM:String = "show";
      
      public static const UPDATE_ANIM:String = "update";
      
      public static const SHOW_MST_ANIM:String = "showMST";
      
      public static const HIDE_LEFT_ANIM:String = "hideLeft";
      
      public static const HIDE_BOTTOM_ANIM:String = "hideBottom";
      
      public static const DEFAULT_STATE:String = "default";
      
      private static const SHIFT_ANIM:String = "shiftPosition";
      
      public static const ITEM_HEIGHT:int = 30;
      
      private static const LIFE_TIME:int = 3000;
      
      private static const ANIM_DELAY_BY_ITEM:int = 80;
      
      private static const FRAME_SHIFT:int = 2;
      
      public static const CALLBACK_TYPE_SHOW_FINISHED:String = "showFinished";
      
      public static const CALLBACK_TYPE_HIDE_FINISHED:String = "hideFinished";
      
      public static const CALLBACK_LIFETIME_COOLDOWN:String = "hideInProgress";
       
      
      public var iconsAnim:AnimationSet = null;
      
      public var textsAnim:AnimationSet = null;
      
      public var bonusAnim:AnimationSet = null;
      
      public var ribbonType:String;
      
      public var ribbonId:Number = 0;
      
      private var _animationState:String = "invisible";
      
      private var _icons:RibbonIcons = null;
      
      private var _texts:RibbonTexts = null;
      
      private var _idx:int = 0;
      
      private var _animationCompleteCallback:Function;
      
      private var _isExtendedAnim:Boolean = false;
      
      private var _showLbl:String = "";
      
      private var _colorMgr:IColorSchemeManager = null;
      
      private var _bonus:EfficiencyBonusAnimation = null;
      
      private var _isBonus:Boolean = false;
      
      private var _showLastFrameIdx:int = 0;
      
      private var _showMSTLastFrameIdx:int = 0;
      
      private var _hideLeftLastFrameIdx:int = 0;
      
      private var _hideBottomLastFrameIdx:int = 0;
      
      private var _shiftLastFrameIdx:int = 0;
      
      private var _scheduler:IScheduler = null;
      
      private var _isMustBeHided:Boolean = false;
      
      private var _glowAnim:MovieClip = null;
      
      public function RibbonCtrl(param1:RibbonSettings, param2:Function)
      {
         super();
         this._scheduler = App.utils.scheduler;
         this._colorMgr = App.colorSchemeMgr;
         this.ribbonType = param1.getRibbonType();
         var _loc3_:IClassFactory = App.utils.classFactory;
         var _loc4_:Class = _loc3_.getClass(Linkages.RIBBONS_ANIMATION_SET);
         this.iconsAnim = new _loc4_();
         this.textsAnim = new _loc4_();
         this.checkAnimSetFrameIdxs(this.iconsAnim);
         this._icons = _loc3_.getComponent(Linkages.RIBBON_ICONS,RibbonIcons);
         this._texts = _loc3_.getComponent(Linkages.RIBBON_TEXT,RibbonTexts);
         this.textsAnim.init(this._texts);
         this.iconsAnim.init(this._icons);
         this._texts.init(param1);
         var _loc5_:TextField = this._texts.ribbonNameTF;
         this._icons.init(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,_loc5_.x + _loc5_.textWidth);
         this.iconsAnim.addFrameScript(this._hideLeftLastFrameIdx,this.onHideAnimCompleteFrameHandler);
         this.iconsAnim.addFrameScript(this._hideBottomLastFrameIdx,this.onHideAnimCompleteFrameHandler);
         this.iconsAnim.addFrameScript(this._shiftLastFrameIdx,this.onShiftPositionAnimCompleteFrameHandler);
         this.iconsAnim.addFrameScript(this._showLastFrameIdx,this.onShowAnimCompleteFrameHandler);
         this.iconsAnim.addFrameScript(this._showMSTLastFrameIdx,this.onShowAnimCompleteFrameHandler);
         this.iconsAnim.visible = false;
         this.iconsAnim.stop();
         this.textsAnim.visible = false;
         this.textsAnim.stop();
         this._animationCompleteCallback = param2;
         this._glowAnim = this.iconsAnim.glowAnim;
         this._colorMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorMgrSchemasUpdateHandler);
         var _loc6_:Class = _loc3_.getClass(Linkages.RIBBONS_ANIMATION_SET);
         this.bonusAnim = new _loc6_();
         this.bonusAnim.stop();
         this.bonusAnim.visible = false;
         this._bonus = _loc3_.getComponent(Linkages.RIBBONS_BONUS_ANIMATION,EfficiencyBonusAnimation);
         this.bonusAnim.init(this._bonus);
      }
      
      public final function dispose() : void
      {
         this.iconsAnim.addFrameScript(this._hideLeftLastFrameIdx,null);
         this.iconsAnim.addFrameScript(this._hideBottomLastFrameIdx,null);
         this.iconsAnim.addFrameScript(this._shiftLastFrameIdx,null);
         this.iconsAnim.addFrameScript(this._showLastFrameIdx,null);
         this.iconsAnim.addFrameScript(this._showMSTLastFrameIdx,null);
         this._colorMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorMgrSchemasUpdateHandler);
         this.cancelTasks();
         this._scheduler = null;
         this.iconsAnim.dispose();
         this.iconsAnim = null;
         this.textsAnim.dispose();
         this.textsAnim = null;
         this._icons.dispose();
         this._icons = null;
         this._texts.dispose();
         this._texts = null;
         this._colorMgr = null;
         this._glowAnim = null;
         this._animationCompleteCallback = null;
         this.bonusAnim.dispose();
         this.bonusAnim = null;
         this._bonus.dispose();
         this._bonus = null;
      }
      
      public function hideByOrder(param1:int) : void
      {
         var _loc2_:int = param1 * ANIM_DELAY_BY_ITEM;
         if(_loc2_ > 0)
         {
            this._scheduler.scheduleTask(this.onHideItemInLeft,_loc2_);
         }
         else
         {
            this.onHideItemInLeft();
         }
      }
      
      public function hideImmediately() : void
      {
         this.cancelTasks();
         this.stopAnimations();
      }
      
      public function hideInBottom() : Boolean
      {
         if(this._animationState != RibbonAnimationStates.HIDE_IN_PROGRESS)
         {
            this._animationState = RibbonAnimationStates.HIDE_IN_PROGRESS;
            this._scheduler.cancelTask(this.shiftItems);
            this._scheduler.cancelTask(this.onLifetimeCooldown);
            this.playAnimItems(HIDE_BOTTOM_ANIM,false);
            this._scheduler.scheduleTask(this.hideControl,600);
            return true;
         }
         return false;
      }
      
      private function isBuff() : Boolean
      {
         var _loc1_:int = BATTLE_EFFICIENCY_TYPES.BUFFS_SET.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(BATTLE_EFFICIENCY_TYPES.BUFFS_SET[_loc2_] == this.ribbonType)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function isEventAction() : Boolean
      {
         return BATTLE_EFFICIENCY_TYPES.EVENT_SET.indexOf(this.ribbonType) != -1;
      }
      
      public function setSettings(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         if(this.isBuff() || this.isEventAction())
         {
            this._texts.setSettings(param1,true,true);
            this._icons.setSettings(true,true);
         }
         else
         {
            this._texts.setSettings(param1,param2,param3);
            this._icons.setSettings(param2,param3);
         }
         this._bonus.setSettings(param1);
         this._isExtendedAnim = param1;
         if(param1)
         {
            this._showLbl = SHOW_ANIM;
         }
         else
         {
            this._showLbl = SHOW_MST_ANIM;
         }
      }
      
      public function shiftAnim(param1:int) : void
      {
         this._animationState = RibbonAnimationStates.SHIFT_IN_PROGRESS;
         var _loc2_:int = ANIM_DELAY_BY_ITEM * param1;
         if(_loc2_ > 0)
         {
            this._scheduler.scheduleTask(this.shiftItems,_loc2_);
         }
         else
         {
            this.shiftItems();
         }
      }
      
      public function showAnim(param1:int) : void
      {
         this._animationState = RibbonAnimationStates.SHOW_IN_PROGRESS;
         this._scheduler.scheduleTask(this.showAnimByScheduler,param1 * ANIM_DELAY_BY_ITEM);
      }
      
      public function updateData(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String) : void
      {
         this._scheduler.cancelTask(this.onLifetimeCooldown);
         this._scheduler.scheduleTask(this.onLifetimeCooldown,LIFE_TIME);
         this.ribbonId = param1;
         this._isBonus = !StringUtils.isEmpty(param6);
         this._texts.setData(param3,param2,param5,param4);
         this._icons.setDamageSourceIcon(param4);
         this._bonus.update(param6,param7);
         if(this._animationState == RibbonAnimationStates.IS_STATIC_SHOW)
         {
            this.playAnimItems(UPDATE_ANIM,true);
         }
         this._texts.showUpdateAnim();
         this._bonus.show();
      }
      
      private function checkAnimSetFrameIdxs(param1:AnimationSet) : void
      {
         var _loc3_:FrameLabel = null;
         var _loc4_:FrameLabel = null;
         var _loc2_:Array = param1.currentLabels;
         var _loc5_:int = _loc2_.length;
         var _loc6_:int = 0;
         for(; _loc6_ < _loc5_; _loc6_++)
         {
            if(_loc6_ >= _loc5_ - 1)
            {
               continue;
            }
            _loc3_ = _loc2_[_loc6_];
            _loc4_ = _loc2_[_loc6_ + 1];
            switch(_loc3_.name)
            {
               case SHOW_ANIM:
                  this._showLastFrameIdx = _loc4_.frame - FRAME_SHIFT;
                  break;
               case SHOW_MST_ANIM:
                  this._showMSTLastFrameIdx = _loc4_.frame - FRAME_SHIFT;
                  break;
               case HIDE_LEFT_ANIM:
                  this._hideLeftLastFrameIdx = _loc4_.frame - FRAME_SHIFT;
                  break;
               case HIDE_BOTTOM_ANIM:
                  this._hideBottomLastFrameIdx = _loc4_.frame - FRAME_SHIFT;
                  break;
               case SHIFT_ANIM:
                  this._shiftLastFrameIdx = _loc4_.frame - FRAME_SHIFT;
                  break;
            }
         }
      }
      
      private function hideControl() : void
      {
         this.onHideAnimCompleteFrameHandler();
      }
      
      private function onLifetimeCooldown() : void
      {
         this._scheduler.cancelTask(this.onLifetimeCooldown);
         this._animationCompleteCallback(CALLBACK_LIFETIME_COOLDOWN,this.ribbonId);
      }
      
      private function onHideItemInLeft() : void
      {
         this._scheduler.cancelTask(this.onHideItemInLeft);
         this._scheduler.cancelTask(this.shiftItems);
         this._scheduler.cancelTask(this.onLifetimeCooldown);
         this._animationState = RibbonAnimationStates.HIDE_IN_PROGRESS;
         if(this._animationState == RibbonAnimationStates.SHIFT_IN_PROGRESS)
         {
            this._isMustBeHided = true;
         }
         else
         {
            this.playAnimItems(HIDE_LEFT_ANIM,false);
         }
      }
      
      private function cancelTasks() : void
      {
         this._scheduler.cancelTask(this.shiftItems);
         this._scheduler.cancelTask(this.onLifetimeCooldown);
         this._scheduler.cancelTask(this.showAnimByScheduler);
         this._scheduler.cancelTask(this.onHideItemInLeft);
         this._scheduler.cancelTask(this.hideControl);
      }
      
      private function stopAnimations() : void
      {
         this._animationState = RibbonAnimationStates.INVISIBLE;
         this.iconsAnim.gotoAndStop(DEFAULT_STATE);
         this.iconsAnim.visible = false;
         this.textsAnim.visible = false;
         this.bonusAnim.visible = false;
         if(this._idx > 0)
         {
            this.iconsAnim.y = 0;
            this.textsAnim.y = 0;
            this.bonusAnim.y = 0;
         }
         this._idx = 0;
         this._isMustBeHided = false;
      }
      
      private function shiftItems() : void
      {
         this._scheduler.cancelTask(this.playAnimItems);
         this.playAnimItems(SHIFT_ANIM,false);
      }
      
      private function showAnimByScheduler() : void
      {
         this._scheduler.cancelTask(this.showAnimByScheduler);
         this.textsAnim.visible = true;
         this.iconsAnim.visible = true;
         this.bonusAnim.visible = true;
         this.playAnimItems(this._showLbl,true);
         if(this._isExtendedAnim)
         {
            this._texts.showUpdateAnim();
            this._bonus.show();
         }
      }
      
      private function playAnimItems(param1:String, param2:Boolean) : void
      {
         this.iconsAnim.gotoAndPlay(param1);
         this.textsAnim.gotoAndPlay(param1);
         if(param2)
         {
            this._glowAnim.gotoAndPlay(1);
         }
         if(this._isBonus)
         {
            this.bonusAnim.gotoAndPlay(param1);
         }
      }
      
      private function onShowAnimCompleteFrameHandler() : void
      {
         this._animationState = RibbonAnimationStates.IS_STATIC_SHOW;
         this._scheduler.cancelTask(this.onLifetimeCooldown);
         this._scheduler.scheduleTask(this.onLifetimeCooldown,LIFE_TIME);
         this.iconsAnim.stop();
         this._animationCompleteCallback(CALLBACK_TYPE_SHOW_FINISHED,this.ribbonId);
      }
      
      private function onHideAnimCompleteFrameHandler() : void
      {
         this._scheduler.cancelTask(this.hideControl);
         this.stopAnimations();
         this._animationCompleteCallback(CALLBACK_TYPE_HIDE_FINISHED,this.ribbonId);
      }
      
      private function onShiftPositionAnimCompleteFrameHandler() : void
      {
         this._animationState = RibbonAnimationStates.IS_STATIC_SHOW;
         ++this._idx;
         this.textsAnim.y = this.iconsAnim.y = this.bonusAnim.y = ITEM_HEIGHT * this._idx;
         this.textsAnim.gotoAndStop(DEFAULT_STATE);
         this.iconsAnim.gotoAndStop(DEFAULT_STATE);
         this.bonusAnim.gotoAndStop(DEFAULT_STATE);
         if(this._isMustBeHided)
         {
            this.onLifetimeCooldown();
         }
      }
      
      private function onColorMgrSchemasUpdateHandler(param1:ColorSchemeEvent) : void
      {
         this._icons.updateIcons();
         this._texts.updateTextFields();
      }
   }
}
