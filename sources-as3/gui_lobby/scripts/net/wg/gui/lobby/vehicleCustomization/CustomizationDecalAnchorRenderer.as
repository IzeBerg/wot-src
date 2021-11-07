package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationAnchorEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSoundEvent;
   import net.wg.gui.utils.FrameHelper;
   
   public class CustomizationDecalAnchorRenderer extends CustomizationAnchorRenderer
   {
      
      private static const LOCK_ANIM_FRAME_LABEL:String = "lockStart";
      
      private static const LOCK_SOUND_FRAME_LABEL:String = "playSound";
      
      private static const OFFSET_FRAME_TWO:uint = 2;
      
      private static const ON_MAGNETIC_RESET:String = "onMagneticReset";
      
      private static const HIT_HALF_SCALE:Number = 0.5;
       
      
      public var anchorEmptyUnavailble:MovieClip = null;
      
      public var anchorHoveredFilled:MovieClip = null;
      
      public var anchorHoveredEmpty:MovieClip = null;
      
      private var _frameHelper:FrameHelper = null;
      
      public function CustomizationDecalAnchorRenderer()
      {
         super();
         this.initFramesScript();
      }
      
      override public function onMagneticReset() : void
      {
         invalidate(ON_MAGNETIC_RESET);
      }
      
      override protected function applyNewState(param1:Boolean = true) : void
      {
         super.applyNewState(param1);
         hitAreaSprite.scaleX = hitAreaSprite.scaleY = HIT_HALF_SCALE;
         switch(currentState)
         {
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_LOCKED:
               addVisibleMc(this.anchorEmptyUnavailble);
               enabled = false;
               if(visible && App.cursor.getAttachedSprite() && param1)
               {
                  deactivateAlpha();
                  alpha = Values.DEFAULT_ALPHA;
                  this.anchorEmptyUnavailble.gotoAndPlay(LOCK_ANIM_FRAME_LABEL);
               }
               else
               {
                  activateAll();
                  this.anchorEmptyUnavailble.gotoAndStop(this.anchorEmptyUnavailble.totalFrames);
               }
               break;
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_REMOVED:
               addVisibleMc(this.anchorHoveredFilled);
               this.anchorHoveredFilled.scaleX = this.anchorHoveredFilled.scaleY = BASE_SCALE;
               hitAreaSprite.scaleX = hitAreaSprite.scaleY = HIT_SCALE_MIN;
               break;
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_UNSELECTED_FILLED:
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_SELECTED_FILLED:
               hitAreaSprite.scaleX = hitAreaSprite.scaleY = HIT_SCALE_MIN;
               break;
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_PREVIEW:
               addVisibleMc(this.anchorHoveredEmpty);
         }
      }
      
      override protected function resetPreviousState(param1:Boolean = true) : void
      {
         super.resetPreviousState(param1);
         switch(currentState)
         {
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_LOCKED:
               removeVisibleMc(this.anchorEmptyUnavailble);
               enabled = true;
               if(visible && App.cursor.getAttachedSprite() && param1)
               {
                  deactivateAlpha();
                  alpha = Values.DEFAULT_ALPHA;
                  anchorUnselectedEmpty.gotoAndPlay(LOCK_ANIM_FRAME_LABEL);
               }
               else
               {
                  activateAll();
                  anchorUnselectedEmpty.gotoAndStop(anchorUnselectedEmpty.totalFrames);
               }
               break;
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_REMOVED:
               removeVisibleMc(this.anchorHoveredFilled);
               anchorUnselectedFilled.scaleX = anchorUnselectedFilled.scaleY = BASE_SCALE;
               break;
            case CUSTOMIZATION_ALIASES.ANCHOR_STATE_PREVIEW:
               removeVisibleMc(this.anchorHoveredEmpty);
         }
      }
      
      override protected function configUI() : void
      {
         var _loc1_:uint = 0;
         super.configUI();
         _loc1_ = this.anchorEmptyUnavailble.totalFrames;
         this.anchorEmptyUnavailble.hitArea = this.anchorHoveredFilled.hitArea = this.anchorHoveredEmpty.hitArea = hitAreaSprite;
         this.anchorEmptyUnavailble.mouseEnabled = this.anchorEmptyUnavailble.mouseChildren = false;
         this.anchorEmptyUnavailble.gotoAndStop(_loc1_);
         this.anchorEmptyUnavailble.addFrameScript(_loc1_ - OFFSET_FRAME_TWO,activateAll);
         _loc1_ = anchorUnselectedEmpty.totalFrames;
         anchorUnselectedEmpty.mouseEnabled = anchorUnselectedEmpty.mouseChildren = false;
         anchorUnselectedEmpty.gotoAndStop(_loc1_);
         anchorUnselectedEmpty.addFrameScript(_loc1_ - OFFSET_FRAME_TWO,activateAll);
         this.anchorHoveredEmpty.mouseEnabled = this.anchorHoveredEmpty.mouseChildren = false;
         this.anchorHoveredFilled.mouseEnabled = this.anchorHoveredFilled.mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         anchorUnselectedEmpty.addFrameScript(this._frameHelper.getFrameByLabel(LOCK_SOUND_FRAME_LABEL),null);
         this._frameHelper.setTarget(anchorUnselectedEmpty);
         this.anchorEmptyUnavailble.addFrameScript(this._frameHelper.getFrameByLabel(LOCK_SOUND_FRAME_LABEL),null);
         this.anchorEmptyUnavailble = null;
         this._frameHelper.dispose();
         this._frameHelper = null;
         this.anchorHoveredFilled = null;
         this.anchorHoveredEmpty = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(ON_MAGNETIC_RESET))
         {
            if(currentState == CUSTOMIZATION_ALIASES.ANCHOR_STATE_LOCKED)
            {
               activateAll();
               this.anchorEmptyUnavailble.gotoAndStop(this.anchorEmptyUnavailble.totalFrames);
            }
            else if(currentState == CUSTOMIZATION_ALIASES.ANCHOR_STATE_UNSELECTED_EMPTY)
            {
               activateAll();
               anchorUnselectedEmpty.gotoAndStop(anchorUnselectedEmpty.totalFrames);
            }
         }
      }
      
      private function initFramesScript() : void
      {
         this._frameHelper = new FrameHelper(this.anchorEmptyUnavailble);
         this.anchorEmptyUnavailble.addFrameScript(this._frameHelper.getFrameByLabel(LOCK_SOUND_FRAME_LABEL),this.playLockSound);
         this._frameHelper.setTarget(anchorUnselectedEmpty);
         anchorUnselectedEmpty.addFrameScript(this._frameHelper.getFrameByLabel(LOCK_SOUND_FRAME_LABEL),this.playUnlockSound);
      }
      
      private function playLockSound() : void
      {
         dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,CUSTOMIZATION_ALIASES.SOUND_CUST_LOCK));
      }
      
      private function playUnlockSound() : void
      {
         dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,CUSTOMIZATION_ALIASES.SOUND_RADIAL_UNLOCK));
      }
      
      override protected function onAnchorMouseOver(param1:MouseEvent) : void
      {
         if(getLocked())
         {
            return;
         }
         super.onAnchorMouseOver(param1);
      }
      
      override protected function onAnchorMouseOut(param1:MouseEvent) : void
      {
         if(getLocked())
         {
            return;
         }
         super.onAnchorMouseOut(param1);
      }
      
      override protected function onAnchorMouseClick(param1:MouseEvent) : void
      {
         if(getLocked())
         {
            dispatchEvent(new CustomizationSoundEvent(CustomizationSoundEvent.PLAY_SOUND,CUSTOMIZATION_ALIASES.SOUND_CUST_NEGATIVE));
            dispatchEvent(new CustomizationAnchorEvent(CustomizationAnchorEvent.LOCKED_ANCHOR,this));
            return;
         }
         super.onAnchorMouseClick(param1);
      }
   }
}
