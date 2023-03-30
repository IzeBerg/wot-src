package net.wg.gui.battle.components.pointsOfInterestNotificationPanel
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.POI_CONSTS;
   import net.wg.gui.battle.components.pointsOfInterestNotificationPanel.data.PointsOfInterestNotificationVO;
   import net.wg.infrastructure.base.meta.IPointsOfInterestNotificationPanelMeta;
   import net.wg.infrastructure.base.meta.impl.PointsOfInterestNotificationPanelMeta;
   import net.wg.utils.IScheduler;
   import net.wg.utils.StageSizeBoundaries;
   import net.wg.utils.scheduler.Task;
   import scaleform.clik.motion.Tween;
   
   public class PointsOfInterestNotificationPanel extends PointsOfInterestNotificationPanelMeta implements IPointsOfInterestNotificationPanelMeta
   {
      
      private static const POI_STATUS_INDICATOR_Y:uint = 17;
      
      private static const POI_STATUS_INDICATOR_WIDTH:uint = 60;
      
      private static const POI_STATUS_INDICATORS_GAP:uint = 25;
      
      private static const POI_STATUS_INDICATORS_OFFSET_X:uint = POI_STATUS_INDICATOR_WIDTH + POI_STATUS_INDICATORS_GAP;
      
      private static const SMALL_HEIGHT_Y_POS:int = 93;
      
      private static const DEFAULT_Y_POS:int = 115;
      
      private static const Y_POS_DIFF:int = DEFAULT_Y_POS - SMALL_HEIGHT_Y_POS;
      
      private static const STAGE_SIZES_DIFF:int = StageSizeBoundaries.HEIGHT_900 - StageSizeBoundaries.HEIGHT_768;
      
      private static const NOTIFICATION_TEXT_TWEEN_DURATION:int = 250;
      
      private static const NOTIFICATION_ICON_FADE_DELAY:int = 2400;
      
      private static const NOTIFICATION_ALLY_TEXT_STYLE:TextFormat = new TextFormat(null,null,15327935);
      
      private static const NOTIFICATION_ENEMY_TEXT_STYLE:TextFormat = new TextFormat(null,null,16768409);
       
      
      public var notificationTF:TextField = null;
      
      public var tfShadow:Sprite = null;
      
      private var _tasksList:Vector.<Task>;
      
      private var _poiStatusIndicators:Vector.<PoiStatusIndicator>;
      
      private var _notificationPoiStatusIndicator:PoiStatusIndicator = null;
      
      private var _replaySpeed:Number = 1;
      
      private var _notificationTextTween:Tween = null;
      
      private var _tfShadowTween:Tween = null;
      
      private var _scheduler:IScheduler;
      
      public function PointsOfInterestNotificationPanel()
      {
         this._tasksList = new Vector.<Task>(0);
         this._poiStatusIndicators = new Vector.<PoiStatusIndicator>(0);
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.updateYPos();
         this.notificationTF.alpha = Values.ZERO;
         this.tfShadow.alpha = Values.ZERO;
         mouseChildren = mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Task = null;
         var _loc2_:PoiStatusIndicator = null;
         this._scheduler.cancelTask(this.processTasks);
         if(this._notificationPoiStatusIndicator)
         {
            this._scheduler.cancelTask(this._notificationPoiStatusIndicator.fadeOutTween);
         }
         this.clearNotificationTextTween();
         this.clearTfShadowTween();
         this.notificationTF = null;
         this.tfShadow = null;
         for each(_loc1_ in this._tasksList)
         {
            _loc1_.dispose();
         }
         this._tasksList.length = 0;
         this._tasksList = null;
         for each(_loc2_ in this._poiStatusIndicators)
         {
            _loc2_.dispose();
         }
         this._poiStatusIndicators.length = 0;
         this._poiStatusIndicators = null;
         this._notificationPoiStatusIndicator = null;
         this._scheduler = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function addPoiStatus(param1:PointsOfInterestNotificationVO) : void
      {
         var _loc2_:PoiStatusIndicator = null;
         _loc2_ = this.getPoiStatusIndicatorById(param1.id);
         if(!_loc2_)
         {
            _loc2_ = new PoiStatusIndicator();
            _loc2_.y = POI_STATUS_INDICATOR_Y;
            addChild(_loc2_);
            this._poiStatusIndicators.push(_loc2_);
         }
         _loc2_.setData(param1);
         if(!this.isNotificationActive())
         {
            if(param1.status == POI_CONSTS.POI_STATUS_CAPTURING)
            {
               _loc2_.fadeInTween();
            }
            else
            {
               _loc2_.progressCircleAlpha = 0;
            }
            this.poiStatusIndicatorsAlignX();
         }
      }
      
      public function as_addNotification(param1:uint, param2:Boolean, param3:String) : void
      {
         var _loc5_:PoiStatusIndicator = null;
         var _loc4_:PoiStatusIndicator = this.getPoiStatusIndicatorById(param1);
         if(!_loc4_)
         {
            return;
         }
         if(this.isNotificationActive())
         {
            this._tasksList.push(new Task(this.as_addNotification,[param1,param2,param3]));
            return;
         }
         this.prepareNotifyIndicator(_loc4_);
         this._notificationPoiStatusIndicator = _loc4_;
         for each(_loc5_ in this._poiStatusIndicators)
         {
            if(this._notificationPoiStatusIndicator != _loc5_ && _loc5_.getData().status == POI_CONSTS.POI_STATUS_CAPTURING)
            {
               _loc5_.fadeOutTween();
            }
         }
         this._notificationPoiStatusIndicator.onFadeOutComplete = this.onNotificationFadeOutComplete;
         this._notificationPoiStatusIndicator.updateData(POI_CONSTS.POI_STATUS_COOLDOWN,param2);
         this._notificationPoiStatusIndicator.forceUpdateIconHighlight(param2);
         this._notificationPoiStatusIndicator.updateProgress(100);
         this._notificationPoiStatusIndicator.clearFadeTween();
         this._notificationPoiStatusIndicator.progressCircleAlpha = 1;
         this._notificationPoiStatusIndicator.tweenToX(0);
         this.setAsLast(this._notificationPoiStatusIndicator);
         this.notificationTF.htmlText = param3;
         this.notificationTF.setTextFormat(!!param2 ? NOTIFICATION_ALLY_TEXT_STYLE : NOTIFICATION_ENEMY_TEXT_STYLE);
         App.utils.commons.updateTextFieldSize(this.notificationTF,false,true);
         this.switchNotificationTextsVisibility(true);
         this._scheduler.scheduleTask(this.startNotificationFadeOut,NOTIFICATION_ICON_FADE_DELAY * this._replaySpeed);
      }
      
      public function as_setReplaySpeed(param1:Number) : void
      {
         var _loc2_:PoiStatusIndicator = null;
         this._replaySpeed = param1;
         for each(_loc2_ in this._poiStatusIndicators)
         {
            _loc2_.setReplaySpeed(this._replaySpeed);
         }
      }
      
      public function as_updatePoiProgress(param1:uint, param2:uint) : void
      {
         var _loc3_:PoiStatusIndicator = this.getPoiStatusIndicatorById(param1);
         if(_loc3_ && this._notificationPoiStatusIndicator != _loc3_ && _loc3_.getData().status == POI_CONSTS.POI_STATUS_CAPTURING)
         {
            _loc3_.updateProgress(param2);
         }
      }
      
      public function as_updatePoiStatus(param1:uint, param2:uint, param3:Boolean) : void
      {
         var _loc4_:PoiStatusIndicator = this.getPoiStatusIndicatorById(param1);
         if(!_loc4_)
         {
            return;
         }
         if(this._notificationPoiStatusIndicator != _loc4_)
         {
            _loc4_.updateData(param2,param3);
            if(param2 == POI_CONSTS.POI_STATUS_ACTIVE || param2 == POI_CONSTS.POI_STATUS_COOLDOWN)
            {
               if(!this.isNotificationActive())
               {
                  _loc4_.fadeOutTween(false);
               }
               this.setAsLast(_loc4_);
            }
            else if(param2 == POI_CONSTS.POI_STATUS_CAPTURING && !this.isNotificationActive())
            {
               _loc4_.fadeInTween();
            }
            this.poiStatusIndicatorsAlignX();
         }
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         x = param1 >> 1;
         this.updateYPos();
      }
      
      private function setAsLast(param1:PoiStatusIndicator) : void
      {
         this._poiStatusIndicators.splice(this._poiStatusIndicators.indexOf(param1),1);
         this._poiStatusIndicators.push(param1);
      }
      
      private function isNotificationActive() : Boolean
      {
         return this._tasksList.length || this._notificationPoiStatusIndicator;
      }
      
      private function updateYPos() : void
      {
         var _loc1_:int = App.appHeight;
         if(_loc1_ >= StageSizeBoundaries.HEIGHT_900)
         {
            y = DEFAULT_Y_POS;
         }
         else if(_loc1_ < StageSizeBoundaries.HEIGHT_768)
         {
            y = SMALL_HEIGHT_Y_POS;
         }
         else
         {
            y = SMALL_HEIGHT_Y_POS + Y_POS_DIFF * (_loc1_ - StageSizeBoundaries.HEIGHT_768) / STAGE_SIZES_DIFF;
         }
      }
      
      private function startNotificationFadeOut() : void
      {
         if(this._notificationPoiStatusIndicator)
         {
            if(!this._notificationPoiStatusIndicator.fadeOutTween())
            {
               this.clearNotificationTextTween();
               this.clearTfShadowTween();
               this.notificationTF.alpha = this.tfShadow.alpha = 0;
               this.onNotificationShowComplete();
            }
         }
      }
      
      private function cleanUpNotifyIndicator() : void
      {
         if(this._notificationPoiStatusIndicator)
         {
            this.prepareNotifyIndicator(this._notificationPoiStatusIndicator);
            this._notificationPoiStatusIndicator = null;
         }
      }
      
      private function prepareNotifyIndicator(param1:PoiStatusIndicator) : void
      {
         this._scheduler.cancelTask(param1.fadeOutTween);
         param1.onFadeOutComplete = null;
         param1.clearFadeTween();
         param1.progressCircleAlpha = 0;
      }
      
      private function onNotificationFadeOutComplete() : void
      {
         this._notificationPoiStatusIndicator.progressCircleAlpha = 0;
         this.onNotificationShowComplete();
      }
      
      private function getPoiStatusIndicatorById(param1:int) : PoiStatusIndicator
      {
         var _loc2_:PoiStatusIndicator = null;
         for each(_loc2_ in this._poiStatusIndicators)
         {
            if(_loc2_.getData().id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function clearNotificationTextTween() : void
      {
         if(this._notificationTextTween)
         {
            this._notificationTextTween.dispose();
            this._notificationTextTween = null;
         }
      }
      
      private function clearTfShadowTween() : void
      {
         if(this._tfShadowTween)
         {
            this._tfShadowTween.dispose();
            this._tfShadowTween = null;
         }
      }
      
      private function switchNotificationTextsVisibility(param1:Boolean) : void
      {
         this.clearNotificationTextTween();
         this.clearTfShadowTween();
         var _loc2_:Number = !!param1 ? Number(Values.DEFAULT_ALPHA) : Number(Values.ZERO);
         var _loc3_:Function = !!param1 ? Cubic.easeIn : Cubic.easeOut;
         if(this.notificationTF.alpha != _loc2_)
         {
            this._notificationTextTween = new Tween(NOTIFICATION_TEXT_TWEEN_DURATION * this._replaySpeed,this.notificationTF,{"alpha":_loc2_},{"ease":_loc3_});
            this._tfShadowTween = new Tween(NOTIFICATION_TEXT_TWEEN_DURATION * this._replaySpeed,this.tfShadow,{"alpha":_loc2_},{"ease":_loc3_});
         }
      }
      
      private function onNotificationShowComplete() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:PoiStatusIndicator = null;
         this.switchNotificationTextsVisibility(false);
         this.cleanUpNotifyIndicator();
         if(this._tasksList.length)
         {
            this._scheduler.scheduleTask(this.processTasks,NOTIFICATION_TEXT_TWEEN_DURATION * this._replaySpeed);
         }
         else
         {
            _loc1_ = 0;
            for each(_loc2_ in this._poiStatusIndicators)
            {
               _loc1_ = _loc2_.getData().status;
               if(_loc1_ == POI_CONSTS.POI_STATUS_CAPTURING)
               {
                  _loc2_.fadeInTween();
               }
            }
            this.poiStatusIndicatorsAlignX();
         }
      }
      
      private function processTasks() : void
      {
         var _loc1_:Task = this._tasksList.shift();
         _loc1_.invoke();
         _loc1_.dispose();
      }
      
      private function poiStatusIndicatorsAlignX() : void
      {
         var _loc3_:PoiStatusIndicator = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Vector.<PoiStatusIndicator> = new Vector.<PoiStatusIndicator>(0);
         var _loc2_:uint = 0;
         for each(_loc3_ in this._poiStatusIndicators)
         {
            _loc2_ = _loc3_.getData().status;
            if(_loc3_ != this._notificationPoiStatusIndicator && _loc2_ == POI_CONSTS.POI_STATUS_CAPTURING)
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc4_ = _loc1_.length;
         _loc5_ = _loc4_ * POI_STATUS_INDICATORS_OFFSET_X - POI_STATUS_INDICATORS_GAP;
         _loc6_ = -(_loc5_ - POI_STATUS_INDICATOR_WIDTH) >> 1;
         for each(_loc3_ in _loc1_)
         {
            _loc3_.tweenToX(_loc6_);
            _loc6_ += POI_STATUS_INDICATORS_OFFSET_X;
         }
      }
   }
}
