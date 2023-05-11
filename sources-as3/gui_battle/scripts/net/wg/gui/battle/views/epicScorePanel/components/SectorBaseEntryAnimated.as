package net.wg.gui.battle.views.epicScorePanel.components
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.EpicProgressCircle;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SectorBaseEntryAnimated extends MovieClip implements IDisposable
   {
      
      private static const DEFAULT_STATE:String = "default";
      
      private static const LOCKED_STATE:String = "locked";
      
      private static const TARGET_FOCUS_STATE:String = "target_focus";
      
      private static const START_CAPTURE_OTHER:String = "start_capture_other";
      
      private static const START_CAPTURE_END_FRAME:int = 50;
       
      
      public var base:SectorBaseScoreEntry = null;
      
      public var primaryTarget:MovieClip = null;
      
      private var _currentState:String = "";
      
      private var _isCurrentTarget:Boolean = false;
      
      private var _locked:Boolean = false;
      
      private var _captured:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function SectorBaseEntryAnimated()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         stop();
         this.primaryTarget = null;
         this.base.dispose();
         this.base = null;
      }
      
      public function init(param1:int, param2:Boolean) : void
      {
         this.base.setBaseId(param1);
         this.progressCircleElement.setOwner(param2);
         this.progressCircleElement.setColorBlindMode(App.colorSchemeMgr.getIsColorBlindS());
         this.setState(DEFAULT_STATE);
      }
      
      public function setAsPrimaryTarget(param1:Boolean) : void
      {
         if(!param1 && this.progressCircleElement.capturingActive)
         {
            this.setState(START_CAPTURE_OTHER);
         }
         else if(this._locked)
         {
            this.setState(LOCKED_STATE);
         }
         else
         {
            this.setState(!!param1 ? TARGET_FOCUS_STATE : DEFAULT_STATE);
         }
         this._isCurrentTarget = param1;
      }
      
      public function setBaseCaptureProgress(param1:Number, param2:Boolean) : void
      {
         this.progressCircleElement.updateProgress(param1);
         if(!this._isCurrentTarget && !this._captured)
         {
            if(this.progressCircleElement.capturingActive && this._currentState != START_CAPTURE_OTHER)
            {
               this.setState(START_CAPTURE_OTHER);
            }
            else if(param1 > 0 && this._currentState != START_CAPTURE_OTHER)
            {
               this._currentState = START_CAPTURE_OTHER;
               gotoAndStop(START_CAPTURE_END_FRAME);
            }
            else if(!this.progressCircleElement.capturingActive)
            {
               this.setState(!!this._locked ? LOCKED_STATE : DEFAULT_STATE);
            }
         }
      }
      
      public function setBaseState(param1:Boolean, param2:Boolean) : void
      {
         this._captured = param2;
         if(param2)
         {
            this.setState(DEFAULT_STATE);
         }
         this.progressCircleElement.setOwner(!!param1 ? Boolean(param2) : Boolean(!param2));
      }
      
      private function setState(param1:String) : void
      {
         if(param1 == this._currentState)
         {
            return;
         }
         this._currentState = param1;
         gotoAndPlay(param1);
      }
      
      public function set locked(param1:Boolean) : void
      {
         if(this._locked == param1)
         {
            return;
         }
         this._locked = param1;
         this.setState(param1 && !this._captured ? LOCKED_STATE : (!!this._isCurrentTarget ? TARGET_FOCUS_STATE : DEFAULT_STATE));
      }
      
      private function get progressCircleElement() : EpicProgressCircle
      {
         return this.base.progressCapture;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
