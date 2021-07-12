package net.wg.gui.lobby.vehicleCustomization.controls.seasonBar
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.components.common.CounterView;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.components.ImageWrapper;
   import net.wg.gui.lobby.components.TextWrapper;
   import net.wg.gui.lobby.vehicleCustomization.data.seasonBar.CustomizationSeasonBarRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSoundEvent;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationSeasonRenderer extends SoundButtonEx
   {
      
      private static const ANIM_INVALID:String = "invalidate_animation";
      
      private static const DARK_BG_ANIM_STATE_SHOW:String = "show";
      
      private static const DARK_BG_ANIM_STATE_HIDE:String = "hide";
      
      private static const FILLED_SIGN_IDLE_OK_LABEL:String = "idle_ok";
      
      private static const FILLED_SIGN_IDLE_PLUS_LABEL:String = "idle_plus";
      
      private static const FILLED_SIGN_SHOW_OK_LABEL:String = "show_ok";
      
      private static const SMALL_IMG_X_OFFSET:int = 125;
      
      private static const SELECTED_IMG_SMALL_X_OFFSET:int = 135;
      
      private static const SELECTED_SIGN_SMALL_POS:int = 197;
      
      private static const SIGN_SMALL_POS:int = 187;
      
      private static const SIGN_POS:int = 62;
      
      private static const COUNTER_X_OFFSET:int = 4;
       
      
      public var seasonImage:ImageWrapper = null;
      
      public var seasonBG:CustomizationSeasonBGAnimation = null;
      
      public var nameText:TextWrapper = null;
      
      public var darkBG:MovieClip = null;
      
      public var shine:MovieClip = null;
      
      public var filledAnimation:CustomizationSeasonRendererAnimation = null;
      
      public var filledSign:MovieClip = null;
      
      public var counter:CounterView = null;
      
      private var _model:CustomizationSeasonBarRendererVO = null;
      
      private var _firstShow:Boolean = true;
      
      private var _currentFilledState:Boolean = false;
      
      private var _forceAnim:Boolean = false;
      
      private var _isMinResolution:Boolean = false;
      
      public function CustomizationSeasonRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         soundEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.darkBG.stop();
         this.seasonImage.dispose();
         this.seasonImage = null;
         this.nameText.dispose();
         this.nameText = null;
         this.seasonBG.dispose();
         this.seasonBG = null;
         this.filledAnimation.dispose();
         this.filledAnimation = null;
         this.counter.dispose();
         this.counter = null;
         this.filledSign = null;
         this.darkBG = null;
         this.shine = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         super.onMouseRollOverHandler(param1);
         dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,CUSTOMIZATION_ALIASES.SOUND_CUST_HIGHLIGHT));
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(ANIM_INVALID))
         {
            if(selected)
            {
               this.seasonBG.show();
               this.darkBG.gotoAndPlay(DARK_BG_ANIM_STATE_SHOW);
            }
            else
            {
               this.seasonBG.hide();
               this.darkBG.gotoAndPlay(DARK_BG_ANIM_STATE_HIDE);
            }
            this.updateImagePosition();
         }
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this.nameText.tf.htmlText = !!selected ? this._model.nameSelectedText : this._model.nameText;
            this.seasonImage.image.source = this._model.seasonImageSrc;
            if(this.seasonBG.image.source != this._model.seasonBGImageSrc)
            {
               this.seasonBG.image.source = this._model.seasonBGImageSrc;
               this.filledAnimation.image.source = this._model.seasonBGImageSrc;
            }
            if(this.seasonBG.shine.source != this._model.seasonShineImageSrc)
            {
               this.seasonBG.shine.source = this._model.seasonShineImageSrc;
            }
            _loc1_ = this._currentFilledState != this._model.isFilled;
            this._currentFilledState = this._model.isFilled;
            if(this._firstShow)
            {
               if(this._currentFilledState)
               {
                  this.filledSign.gotoAndStop(FILLED_SIGN_IDLE_OK_LABEL);
               }
               else
               {
                  this.filledSign.gotoAndStop(FILLED_SIGN_IDLE_PLUS_LABEL);
               }
               this._firstShow = false;
            }
            else if(_loc1_)
            {
               if(this._currentFilledState)
               {
                  this.filledSign.gotoAndPlay(FILLED_SIGN_SHOW_OK_LABEL);
               }
               else
               {
                  this.filledSign.gotoAndStop(FILLED_SIGN_IDLE_PLUS_LABEL);
               }
               if(this._currentFilledState)
               {
                  if(selected)
                  {
                     this.shine.play();
                  }
                  if(selected)
                  {
                     this.filledAnimation.playOkSelected();
                  }
                  else
                  {
                     this.filledAnimation.playOkNotSelected();
                  }
               }
               else
               {
                  this.shine.gotoAndStop(1);
                  this.filledAnimation.gotoAndStop(1);
               }
            }
            else if(this._forceAnim)
            {
               if(this._currentFilledState)
               {
                  if(selected)
                  {
                     this.filledAnimation.playOkSelected();
                  }
                  else
                  {
                     this.filledAnimation.playOkNotSelected();
                  }
               }
               this._forceAnim = false;
            }
            else
            {
               this.shine.gotoAndStop(1);
               this.filledAnimation.gotoAndStop(1);
            }
         }
         scaleX = scaleY = 1;
      }
      
      override protected function showTooltip() : void
      {
         if(this._isMinResolution)
         {
            super.showTooltip();
         }
      }
      
      public function toggleResolution(param1:Boolean) : void
      {
         if(this._isMinResolution == param1)
         {
            return;
         }
         this._isMinResolution = param1;
         this.seasonBG.toggleResolution(param1);
         this.nameText.visible = !param1;
         this.updateImagePosition();
      }
      
      override public function set data(param1:Object) : void
      {
         this._model = CustomizationSeasonBarRendererVO(param1);
         this._forceAnim = this._model.forceAnim;
         tooltip = this._model.tooltip;
         invalidateData();
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(selected == param1)
         {
            return;
         }
         super.selected = param1;
         invalidate(ANIM_INVALID);
      }
      
      public function setCount(param1:int = 0) : void
      {
         this.counter.visible = param1 > 0;
         if(this.counter.visible)
         {
            this.counter.setCount(param1.toString());
         }
      }
      
      private function updateImagePosition() : void
      {
         if(this._isMinResolution)
         {
            this.seasonImage.image.x = !!selected ? Number(SELECTED_IMG_SMALL_X_OFFSET) : Number(SMALL_IMG_X_OFFSET);
            this.filledSign.x = !!selected ? Number(SELECTED_SIGN_SMALL_POS) : Number(SIGN_SMALL_POS);
         }
         else
         {
            this.seasonImage.image.x = 0;
            this.filledSign.x = SIGN_POS;
         }
         var _loc1_:Rectangle = this.seasonImage.image.getBounds(this);
         this.counter.x = _loc1_.x + COUNTER_X_OFFSET | 0;
      }
   }
}
