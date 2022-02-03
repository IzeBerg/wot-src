package net.wg.gui.components.predictionIndicator
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PredictionIndicatorItem extends Sprite implements IDisposable
   {
      
      private static const DEGREE_180:int = 180;
      
      private static const LBL_SHOW:String = "show";
      
      private static const LBL_HIDE:String = "hide";
       
      
      public var animMc:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function PredictionIndicatorItem()
      {
         super();
         visible = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.animMc = null;
      }
      
      public function hide() : void
      {
         visible = false;
         this.animMc.gotoAndStop(LBL_HIDE);
      }
      
      public function setYaw(param1:Number) : void
      {
         this.animMc.rotation = param1 * DEGREE_180 / Math.PI;
      }
      
      public function show() : void
      {
         this.animMc.gotoAndPlay(LBL_SHOW);
         visible = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
