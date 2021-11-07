package net.wg.gui.components.crosshairPanel.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CrosshairClipQuantityBar extends MovieClip implements IDisposable
   {
      
      public static const STATE_NORMAL:String = "normal";
      
      public static const STATE_RELOADED:String = "reloaded";
      
      public static const STATE_RELOAD_FINISHED:String = "reload_finished";
      
      public static const MODE_PERCENT:String = "percent";
      
      public static const MODE_QUEUE:String = "queue";
      
      public static const MODE_AMMO:String = "ammo";
       
      
      public var capacityBar:MovieClip = null;
      
      public var quantityInClipBar:MovieClip = null;
      
      private var _isUseFrameAnimation:Boolean = true;
      
      private var _currentQuantityInClip:Number = -1;
      
      private var _initQuantityBarTotalFrames:Number = -1;
      
      private var _initClipCapacity:Number = -1;
      
      private var _initBurst:Number = -1;
      
      private var _initMode:String = "percent";
      
      public function CrosshairClipQuantityBar()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.capacityBar = null;
         this.quantityInClipBar = null;
      }
      
      public function initialize(param1:String, param2:Number, param3:Number, param4:Number, param5:Boolean) : void
      {
         this._initMode = param1;
         this._initClipCapacity = param2;
         this._initBurst = param3;
         this._initQuantityBarTotalFrames = param4;
         this._isUseFrameAnimation = param5;
         this.capacityBar.gotoAndStop(this._initQuantityBarTotalFrames);
      }
      
      public function updateInfo(param1:Number, param2:String, param3:Boolean) : void
      {
         this._currentQuantityInClip = param1;
         if(param3 && this._initClipCapacity == this._currentQuantityInClip)
         {
            if(this._isUseFrameAnimation)
            {
               gotoAndPlay(STATE_RELOADED);
            }
            else
            {
               gotoAndPlay(STATE_RELOAD_FINISHED);
            }
         }
         else
         {
            gotoAndStop(param2);
         }
         this.quantityInClipBar.gotoAndStop(this.calcCurrentFrame());
      }
      
      private function calcCurrentFrame() : Number
      {
         var _loc1_:Number = this._initQuantityBarTotalFrames;
         if(this._initClipCapacity != this._currentQuantityInClip)
         {
            if(this._initMode == MODE_QUEUE)
            {
               _loc1_ = Math.ceil(this._currentQuantityInClip / this._initBurst) + 1;
            }
            else if(this._initMode == MODE_AMMO)
            {
               _loc1_ = this._currentQuantityInClip + 1;
            }
            else
            {
               _loc1_ = this._initQuantityBarTotalFrames * this._currentQuantityInClip / this._initClipCapacity ^ 0;
            }
         }
         return _loc1_;
      }
   }
}
