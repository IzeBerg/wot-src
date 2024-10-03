package net.wg.gui.components.crosshairPanel.components
{
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class OverheatBar extends MovieClip implements IDisposable
   {
      
      public static const Y_OFFSET:int = 19;
      
      public static const X_OFFSET:int = -41;
      
      private static const FULL_PROGRESS:Number = 1;
      
      private static const ANIM_START_FRAME:uint = 1;
      
      private static const STATE_OVERHEAT:String = "overheat";
      
      private static const STATE_HIDE_ANIM:String = "hide";
      
      private static const STATE_INVISIBLE:String = "invisible";
      
      private static const STATE_PREFIX:String = "state_";
      
      private static const MiN_STATE_VALUE:Number = 0;
      
      private static const MAX_STATE_VALUE:Number = 1;
       
      
      public var bar:MovieClip = null;
      
      private var _progress:MovieClip = null;
      
      private var _markers:Vector.<MovieClip> = null;
      
      private var _anim:MovieClip = null;
      
      private var _curProgress:Number = 0;
      
      private var _overheatStates:Vector.<Number> = null;
      
      private var _disposed:Boolean = false;
      
      private var _isOverheated:Boolean = false;
      
      private var _progressFrames:int = 0;
      
      private var _state:String;
      
      private var _curStateMin:Number = 0;
      
      private var _curStateMax:Number = 0;
      
      public function OverheatBar()
      {
         super();
         this._markers = new Vector.<MovieClip>(0);
         this._overheatStates = new Vector.<Number>(0);
         this._progress = this.bar.progress;
         this._anim = this.bar.anim;
         this._anim.gotoAndStop(this._anim.totalFrames - 1);
         this.state = STATE_HIDE_ANIM;
         this._progressFrames = this._progress.totalFrames;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearMarkers();
         this.bar = null;
         this._progress = null;
         this._markers.length = 0;
         this._markers = null;
         this._overheatStates.length = 0;
         this._overheatStates = null;
         this._anim = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function onChangeCrosshair(param1:Number, param2:Boolean) : void
      {
         this._curProgress = -1;
         this._curStateMin = MiN_STATE_VALUE;
         this._curStateMax = MiN_STATE_VALUE;
         if(param1 <= MiN_STATE_VALUE)
         {
            this.state = STATE_INVISIBLE;
         }
         else
         {
            this._state = Values.EMPTY_STR;
            this.updateInfo(param1,param2);
         }
      }
      
      public function setOverheatMarkers(param1:Vector.<Number>) : void
      {
         var _loc2_:Number = NaN;
         this.clearMarkers();
         this._overheatStates = param1.slice(0,param1.length);
         for each(_loc2_ in this._overheatStates)
         {
            this.addMarker(_loc2_);
         }
         this._overheatStates.push(MAX_STATE_VALUE);
      }
      
      public function updateInfo(param1:Number, param2:Boolean) : void
      {
         if(this._curProgress == param1 && this._isOverheated == param2)
         {
            return;
         }
         this._curProgress = param1;
         this._isOverheated = param2;
         if(this._curStateMin >= param1 || param1 > this._curStateMax || this._isOverheated)
         {
            this.updateState();
         }
         this._progress.gotoAndStop(int(param1 * this._progressFrames));
      }
      
      private function addMarker(param1:Number) : void
      {
         var _loc2_:Class = null;
         var _loc3_:MovieClip = null;
         if(0 < param1 && param1 < 1)
         {
            _loc2_ = getDefinitionByName(Linkages.OVERHEAT_STATE_MARKER) as Class;
            _loc3_ = new _loc2_();
            this._markers.push(_loc3_);
            this.bar.addChild(_loc3_);
            _loc3_.gotoAndStop(_loc3_.totalFrames * param1);
         }
         else
         {
            DebugUtils.LOG_ERROR("Value must be in range 0 .. 1");
         }
      }
      
      private function clearMarkers() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._markers)
         {
            this.bar.removeChild(_loc1_);
         }
         this._markers.splice(0,this._markers.length);
         this._overheatStates.splice(0,this._overheatStates.length);
      }
      
      private function updateState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         if(this._isOverheated)
         {
            this.state = STATE_OVERHEAT;
            if(this._curProgress == FULL_PROGRESS)
            {
               this._anim.gotoAndPlay(ANIM_START_FRAME);
            }
         }
         else if(this._curProgress == 0)
         {
            this.state = STATE_HIDE_ANIM;
            this._curStateMax = MiN_STATE_VALUE;
         }
         else
         {
            _loc1_ = this._overheatStates.length;
            _loc2_ = MiN_STATE_VALUE;
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               if(_loc4_ != 0)
               {
                  _loc2_ = this._overheatStates[_loc4_ - 1];
               }
               _loc3_ = this._overheatStates[_loc4_];
               if(_loc2_ < this._curProgress && this._curProgress < _loc3_)
               {
                  this._curStateMin = _loc2_;
                  this._curStateMax = _loc3_;
                  this.state = STATE_PREFIX + String(_loc4_);
                  break;
               }
               _loc4_++;
            }
         }
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function set state(param1:String) : void
      {
         if(this._state == param1)
         {
            return;
         }
         this._state = param1;
         if(param1 == STATE_HIDE_ANIM)
         {
            gotoAndPlay(STATE_HIDE_ANIM);
         }
         else
         {
            gotoAndStop(this._state);
         }
      }
   }
}
