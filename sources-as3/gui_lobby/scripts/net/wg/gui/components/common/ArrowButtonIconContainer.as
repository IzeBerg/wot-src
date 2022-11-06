package net.wg.gui.components.common
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ArrowButtonIconContainer extends Sprite implements IDisposable
   {
      
      private static const FRAME_LABEL_NORMAL:String = "normal";
      
      private static const FRAME_LABEL_DISABLE:String = "disable";
      
      private static const UNDERSCORE:String = "_";
       
      
      public var arrow:FrameStateCmpnt = null;
      
      private var _enabled:Boolean = true;
      
      private var _btnType:String = "";
      
      private var _disposed:Boolean = false;
      
      public function ArrowButtonIconContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.arrow.dispose();
         this.arrow = null;
      }
      
      public function init(param1:String) : void
      {
         this._btnType = param1;
         this.updateArrow();
      }
      
      public function setArrowTopGap(param1:int) : void
      {
         this.arrow.y = param1;
      }
      
      private function getArrowState() : String
      {
         var _loc1_:String = !!this._enabled ? FRAME_LABEL_NORMAL : FRAME_LABEL_DISABLE;
         return this._btnType + UNDERSCORE + _loc1_;
      }
      
      private function updateArrow() : void
      {
         this.arrow.frameLabel = this.getArrowState();
      }
      
      override public function get height() : Number
      {
         return this.arrow.height;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(this._enabled == param1)
         {
            return;
         }
         this._enabled = param1;
         this.updateArrow();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
