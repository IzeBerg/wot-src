package net.wg.gui.components.crosshairPanel.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class OverheatBar extends MovieClip implements IDisposable
   {
      
      public static const Y_OFFSET:int = 19;
      
      public static const X_OFFSET:int = -41;
      
      public static const FRAME_COUNT:int = 100;
      
      private static const FULL_PROGRESS:uint = 1;
      
      private static const ANIM_START_FRAME:uint = 1;
      
      private static const STATE_NORMAL:String = "normal";
      
      private static const STATE_OVERHEATED:String = "overheated";
      
      private static const STATE_OVERHEATED_BLIND:String = "overheated_blind";
      
      private static const STATE_COLD:String = "cold";
       
      
      public var bar:MovieClip = null;
      
      public var marker:MovieClip = null;
      
      public var anim:MovieClip = null;
      
      private var _progress:Number = 0;
      
      private var _disposed:Boolean = false;
      
      private var _isOverheated:Boolean = false;
      
      private var _isColorBlind:Boolean = false;
      
      public function OverheatBar()
      {
         super();
         this.visible = false;
         this.marker.visible = false;
      }
      
      public final function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this.onDispose();
         this._disposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setOverheatMark(param1:Number) : void
      {
         this.marker.visible = param1 > 0;
         this.marker.gotoAndStop(param1 * FRAME_COUNT);
      }
      
      public function updateInfo(param1:Number, param2:Boolean) : void
      {
         if(this._progress == param1 && this._isOverheated == param2)
         {
            return;
         }
         super.visible = true;
         this._progress = param1;
         this._isOverheated = param2;
         if(!param2 && this._progress <= 0)
         {
            gotoAndPlay(STATE_COLD);
         }
         else if(param2)
         {
            gotoAndStop(!!this._isColorBlind ? STATE_OVERHEATED_BLIND : STATE_OVERHEATED);
         }
         else
         {
            gotoAndStop(STATE_NORMAL);
         }
         this.bar.gotoAndStop(this._progress * FRAME_COUNT);
         if(this._progress == FULL_PROGRESS)
         {
            this.anim.gotoAndPlay(ANIM_START_FRAME);
         }
      }
      
      protected function onDispose() : void
      {
         this.marker = null;
         this.bar = null;
         this.anim = null;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1 && this._progress > 0;
      }
      
      public function set isColorBlind(param1:Boolean) : void
      {
         this._isColorBlind = param1;
         if(this._isOverheated)
         {
            gotoAndStop(!!this._isColorBlind ? STATE_OVERHEATED_BLIND : STATE_OVERHEATED);
         }
      }
   }
}
