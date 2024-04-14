package net.wg.gui.lobby.personalMissions.components.firstEntry
{
   import fl.motion.easing.Cubic;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.personalMissions.data.InfoItemRendererVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class InfoItemRenderer extends SoundButtonEx
   {
      
      protected static const INVALID_SETTINGS:String = "invalidSettings";
      
      private static const TF_INNER_PADDING:int = 4;
      
      private static const TWEEN_DURATION:int = 300;
       
      
      public var titleTF:TextField;
      
      public var descriptionTF:TextField;
      
      public var icon:UILoaderAlt;
      
      public var bg:InfoItemRendererBg = null;
      
      public var bgOver:InfoItemRendererBg = null;
      
      public var moreAnim:MoreTextAnim = null;
      
      private var _rendererData:InfoItemRendererVO = null;
      
      private var _tween:Tween;
      
      private var _tweenHit:Tween;
      
      private var _settings:PMInfoVewSettings = null;
      
      private var _isAllowUseTween:Boolean = false;
      
      public function InfoItemRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.moreAnim.setText(PERSONAL_MISSIONS.PERSONALMISSIONFIRSTENTRYVIEW_ITEMS_MORE);
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
      }
      
      override protected function preInitialize() : void
      {
         constraintsDisabled = true;
         preventAutosizing = true;
         super.preInitialize();
      }
      
      override protected function onDispose() : void
      {
         this._rendererData = null;
         this.titleTF = null;
         this.descriptionTF = null;
         this.moreAnim.dispose();
         this.moreAnim = null;
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.icon.dispose();
         this.icon = null;
         this.bg.dispose();
         this.bg = null;
         this.bgOver.dispose();
         this.bgOver = null;
         this.clearTween();
         this.clearHitTween();
         this._settings = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._rendererData && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._rendererData.titleLabel;
            this.descriptionTF.htmlText = this._rendererData.descriptionLabel;
            this.icon.source = this._rendererData.iconSource;
            invalidate(INVALID_SETTINGS);
         }
         if(this._settings && isInvalid(INVALID_SETTINGS))
         {
            this.onSettingsUpdate();
         }
      }
      
      public function setData(param1:InfoItemRendererVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._rendererData = param1;
         invalidateData();
      }
      
      private function createTweenOver(param1:int) : Tween
      {
         return new Tween(TWEEN_DURATION,this,{"y":param1},{
            "paused":false,
            "ease":Cubic.easeInOut,
            "fastTransform":false
         });
      }
      
      private function createTweenOut() : Tween
      {
         return new Tween(TWEEN_DURATION,this,{"y":Values.ZERO},{
            "paused":false,
            "ease":Cubic.easeInOut,
            "fastTransform":false
         });
      }
      
      private function createTweenHitOver(param1:int, param2:int) : Tween
      {
         return new Tween(TWEEN_DURATION,hitMc,{"height":param1 - param2},{
            "paused":false,
            "ease":Cubic.easeInOut,
            "fastTransform":false
         });
      }
      
      private function createTweenHitOut(param1:int) : Tween
      {
         return new Tween(TWEEN_DURATION,hitMc,{"height":param1},{
            "paused":false,
            "ease":Cubic.easeInOut,
            "fastTransform":false
         });
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function clearHitTween() : void
      {
         if(this._tweenHit)
         {
            this._tweenHit.paused = true;
            this._tweenHit.dispose();
            this._tweenHit = null;
         }
      }
      
      private function onSettingsUpdate() : void
      {
         this.icon.scaleX = this.icon.scaleY = this._settings.cardIconScale;
         this.icon.y = this._settings.cardIconYPos;
         this.titleTF.y = this.icon.y + this.icon.height + this._settings.cardTitleTopGap;
         this.titleTF.x = this._settings.cardInnerGap;
         this.titleTF.width = this._settings.cardWidth - (this._settings.cardInnerGap << 1);
         var _loc1_:TextFormat = this.titleTF.getTextFormat();
         _loc1_.size = this._settings.cardTitleFontSize;
         this.titleTF.setTextFormat(_loc1_);
         this.titleTF.height = this.titleTF.textHeight + TF_INNER_PADDING;
         this.descriptionTF.y = this.titleTF.y + this.titleTF.height + this._settings.carDescriptionTopGap;
         this.descriptionTF.x = this._settings.cardInnerGap;
         this.descriptionTF.width = this._settings.cardWidth - (this._settings.cardInnerGap << 1);
         _loc1_ = this.descriptionTF.getTextFormat();
         _loc1_.size = this._settings.cardDescriptionFontSize;
         this.descriptionTF.setTextFormat(_loc1_);
         this.moreAnim.setSize(this._settings.cardWidth,this._settings.cardHeight,this._settings.cardMoreYPos);
         this.bg.setSize(this._settings.cardWidth,this._settings.cardHeight);
         this.bgOver.setSize(this._settings.cardWidth,this._settings.cardHeight);
         hitMc.width = this._settings.cardWidth;
         hitMc.height = this._settings.cardHeight;
         this.icon.x = this._settings.cardWidth - this.icon.width >> 1;
      }
      
      public function set settings(param1:PMInfoVewSettings) : void
      {
         if(this._settings == param1)
         {
            return;
         }
         this._settings = param1;
         invalidate(INVALID_SETTINGS);
      }
      
      public function get id() : int
      {
         return Boolean(this._rendererData) ? int(this._rendererData.index) : int(Values.DEFAULT_INT);
      }
      
      public function set isAllowUseTween(param1:Boolean) : void
      {
         this._isAllowUseTween = param1;
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         if(!enabled || !this._isAllowUseTween || !this._settings)
         {
            return;
         }
         this.clearTween();
         this.clearHitTween();
         this._tween = this.createTweenOver(this._settings.cardAnimDelta);
         this._tweenHit = this.createTweenHitOver(this._settings.cardHeight,this._settings.cardAnimDelta);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         if(!enabled || !this._isAllowUseTween || !this._settings)
         {
            return;
         }
         this.clearTween();
         this.clearHitTween();
         this._tween = this.createTweenOut();
         this._tweenHit = this.createTweenHitOut(this._settings.cardHeight);
      }
      
      private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidate(INVALID_SETTINGS);
      }
   }
}
