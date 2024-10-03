package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;
   import net.wg.gui.battle.views.vehicleMarkers.events.StatusAnimationEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class VehicleAnimatedStatusBaseMarker extends MovieClip implements IDisposable
   {
      
      protected static const STATE_SHOW:String = "show";
      
      protected static const STATE_BASE:String = "base";
      
      protected static const STATE_HIDE:String = "hide";
      
      protected static const STATE_HIDDEN:String = "hidden";
      
      protected static const LABEL_SOURCE:String = "_source";
      
      protected static const HIDDEN_STATE_STOP_FRAME:int = 52;
      
      protected static const HIDE_STATE_STOP_FRAME:int = 41;
      
      protected static const HIDE_STATE_NEXT_PLAY_FRAME:int = 44;
       
      
      protected var oneShotAnimation:Boolean = false;
      
      protected var color:String = "";
      
      private var _altasIconAlias:String = "";
      
      private var _atlasSrcMode:Boolean;
      
      private var _statusID:int = -1;
      
      private var _disposed:Boolean = false;
      
      private var _isSourceVehicle:Boolean = false;
      
      public function VehicleAnimatedStatusBaseMarker()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
         visible = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function hideEffectTimer(param1:Boolean = false) : void
      {
         this.oneShotAnimation = false;
         if(currentFrameLabel && currentFrameLabel != STATE_HIDDEN)
         {
            if(param1)
            {
               gotoAndPlay(HIDE_STATE_NEXT_PLAY_FRAME);
            }
            else
            {
               gotoAndStop(STATE_HIDDEN);
            }
         }
         else
         {
            visible = false;
         }
      }
      
      public function isAtlasSrcMode() : Boolean
      {
         return this._atlasSrcMode;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function isVisible() : Boolean
      {
         return visible || currentFrameLabel != STATE_HIDDEN;
      }
      
      public function resetMarkerStates() : void
      {
         this.oneShotAnimation = false;
         visible = false;
         gotoAndStop(1);
      }
      
      public function setEffectColor(param1:String, param2:uint) : void
      {
         if(param1 == this.color)
         {
            return;
         }
         this.color = param1;
         this.updateColorSettings(param2);
      }
      
      public function setStatusID(param1:int) : void
      {
         this._statusID = param1;
         this._altasIconAlias = VehicleMarkersConstants.getStatusMarkerIconNameByStatusId(param1);
         this._atlasSrcMode = !StringUtils.isEmpty(this._altasIconAlias);
      }
      
      public function setVisibility(param1:Boolean) : void
      {
         if(visible == param1)
         {
            return;
         }
         visible = param1;
         if(param1 && currentLabel != STATE_BASE && currentLabel != STATE_HIDE)
         {
            gotoAndPlay(STATE_BASE);
         }
      }
      
      public function setupFrameEvents() : void
      {
         addFrameScript(HIDDEN_STATE_STOP_FRAME,this.onHiddenStateShowed);
         addFrameScript(HIDE_STATE_STOP_FRAME,this.evaluateOneShotAnimationFrameStates);
      }
      
      public function showEffectTimer(param1:Number, param2:Boolean, param3:Boolean, param4:Boolean = true, param5:Boolean = true) : void
      {
         this.oneShotAnimation = param3;
         visible = true;
         gotoAndPlay(!!param4 ? STATE_SHOW : STATE_BASE);
         this._isSourceVehicle = param2;
         this.updateSourceVehicle();
      }
      
      public function updateAssets() : void
      {
      }
      
      public function updateEffectTimer(param1:Number, param2:Boolean, param3:Boolean = false) : void
      {
         if(!param2)
         {
            return;
         }
         if(!visible)
         {
            if(this._atlasSrcMode)
            {
               this.updateAssets();
            }
            visible = true;
            if(!param3)
            {
               gotoAndStop(STATE_BASE);
            }
         }
         if(param3)
         {
            gotoAndPlay(STATE_SHOW);
         }
      }
      
      protected function onDispose() : void
      {
         stop();
         addFrameScript(HIDE_STATE_STOP_FRAME,null);
         addFrameScript(HIDDEN_STATE_STOP_FRAME,null);
      }
      
      protected function updateColorSettings(param1:uint) : void
      {
      }
      
      protected function updateSourceVehicle() : void
      {
      }
      
      protected function onHiddenStateShowed() : void
      {
         visible = false;
         dispatchEvent(new StatusAnimationEvent(StatusAnimationEvent.EVENT_HIDDEN,this._statusID,this.oneShotAnimation));
         this.oneShotAnimation = false;
      }
      
      protected function evaluateOneShotAnimationFrameStates() : void
      {
         if(this.oneShotAnimation && currentFrame == HIDE_STATE_STOP_FRAME + 1)
         {
            gotoAndPlay(HIDE_STATE_NEXT_PLAY_FRAME);
         }
         else if(currentFrame == HIDDEN_STATE_STOP_FRAME)
         {
            this.onHiddenStateShowed();
         }
      }
      
      public function get altasIconAlias() : String
      {
         return this._altasIconAlias;
      }
      
      public function get arrowColorFrame() : String
      {
         return !!this._isSourceVehicle ? this.color + LABEL_SOURCE : this.color;
      }
   }
}
