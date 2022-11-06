package net.wg.gui.battle.views.calloutPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.views.calloutPanel.components.InteractionDynamicTextLabel;
   import net.wg.gui.battle.views.calloutPanel.components.VehicleInfoLabel;
   import net.wg.infrastructure.base.meta.ICalloutPanelMeta;
   import net.wg.infrastructure.base.meta.impl.CalloutPanelMeta;
   
   public class CalloutPanel extends CalloutPanelMeta implements ICalloutPanelMeta
   {
      
      private static const FADEIN_STATE_NAME:String = "fadeIn";
      
      private static const FADEOUT_STATE_NAME:String = "fadeOut";
      
      private static const TRIGGERED_FADEOUT_STATE_NAME:String = "fadeTriggered";
      
      private static const FADEOUT_ANIMATION_ENDFRAME:int = 83;
      
      private static const TRIGGERED_FADEOUT_ANIMATION_ENDFRAME:int = 67;
       
      
      public var triggeredCalloutActionOverlay:MovieClip = null;
      
      public var triggeredCalloutAction:MovieClip = null;
      
      public var calloutActionOverlay:MovieClip = null;
      
      public var calloutAction:MovieClip = null;
      
      public var tankText:VehicleInfoLabel = null;
      
      public var interactionText:InteractionDynamicTextLabel = null;
      
      private var _hasShowData:Boolean = false;
      
      private var _hasHideData:Boolean = false;
      
      private var _wasAnswered:Boolean = false;
      
      public function CalloutPanel()
      {
         super();
         addFrameScript(FADEOUT_ANIMATION_ENDFRAME,this.onFadeOutAnimationCompleted);
         addFrameScript(TRIGGERED_FADEOUT_ANIMATION_ENDFRAME,this.onFadeOutAnimationCompleted);
         this.setCompVisible(false);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.tankText.updatePositionOnDraw();
            this.interactionText.updatePositionOnDraw();
         }
      }
      
      override protected function onDispose() : void
      {
         stop();
         addFrameScript(FADEOUT_ANIMATION_ENDFRAME,null);
         addFrameScript(TRIGGERED_FADEOUT_ANIMATION_ENDFRAME,null);
         this.triggeredCalloutActionOverlay = null;
         this.triggeredCalloutAction = null;
         this.calloutActionOverlay = null;
         this.calloutAction = null;
         this.tankText.dispose();
         this.tankText = null;
         this.interactionText.dispose();
         this.interactionText = null;
         super.onDispose();
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
         if(param1 == _isCompVisible)
         {
            return;
         }
         if(param1 && this._hasShowData)
         {
            super.setCompVisible(param1);
            gotoAndPlay(FADEIN_STATE_NAME);
         }
         else if(!param1)
         {
            if(this._hasHideData)
            {
               onHideStartS();
               if(this._wasAnswered)
               {
                  gotoAndPlay(TRIGGERED_FADEOUT_STATE_NAME);
               }
               else
               {
                  gotoAndPlay(FADEOUT_STATE_NAME);
               }
               this._hasHideData = false;
            }
            else
            {
               if(this._hasShowData)
               {
                  this.resetAndStopAnimation();
               }
               super.setCompVisible(param1);
            }
         }
      }
      
      public function as_setHideData(param1:Boolean, param2:String) : void
      {
         if(param1)
         {
            this.triggeredCalloutActionOverlay.gotoAndStop(param2);
            this.triggeredCalloutAction.gotoAndStop(param2);
         }
         this._hasHideData = true;
         this._wasAnswered = param1;
      }
      
      public function as_setData(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
         this.calloutActionOverlay.gotoAndStop(param1);
         this.calloutAction.gotoAndStop(param1);
         this.tankText.setVehicleData(param2,param3);
         this.interactionText.setTextData(param4,param6,param5);
         invalidateData();
         this._hasShowData = true;
      }
      
      private function onFadeOutAnimationCompleted() : void
      {
         this.resetAndStopAnimation();
         this.setCompVisible(false);
      }
      
      private function resetAndStopAnimation() : void
      {
         this._hasShowData = false;
         this._hasHideData = false;
         this._wasAnswered = false;
         stop();
         onHideCompletedS();
      }
   }
}
