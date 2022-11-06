package net.wg.gui.components.common
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class Spark extends Sprite implements IDisposable
   {
       
      
      public var sparkAnimation:MovieClip = null;
      
      private var _zone:Rectangle = null;
      
      private var _disposed:Boolean = false;
      
      public function Spark()
      {
         super();
      }
      
      private static function randRange(param1:Number, param2:Number) : Number
      {
         return Number(Math.random() * (param2 - param1) + param1);
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.zone = null;
         this.sparkAnimation.stop();
         this.sparkAnimation = null;
      }
      
      public function init(param1:Rectangle, param2:String) : void
      {
         this.zone = param1;
         this.name = param2;
      }
      
      public function startAnimation() : void
      {
         var _loc1_:Number = NaN;
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false);
         if(stage)
         {
            this.reposition();
            _loc1_ = this.sparkAnimation.totalFrames - 1;
            this.sparkAnimation.gotoAndPlay(1 + Math.floor(Math.random() * _loc1_));
            this.sparkAnimation.addFrameScript(_loc1_,this.sparkAnimationDispatch);
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false);
         }
      }
      
      private function sparkAnimationDispatch() : void
      {
         this.reposition();
      }
      
      private function reposition() : void
      {
         var _loc1_:Number = 1;
         if(Math.random() > 0.75)
         {
            _loc1_ = randRange(0.7,1);
         }
         else
         {
            _loc1_ = randRange(0.2,0.4);
         }
         if(this._zone != null)
         {
            x = Math.floor(randRange(this._zone.x,this._zone.width));
            y = Math.floor(randRange(this._zone.y,this._zone.height));
         }
         scaleX = this.scaleY = _loc1_;
         alpha = randRange(0.05,0.5);
         rotation = randRange(-120,-100);
      }
      
      public function get zone() : Rectangle
      {
         return this._zone;
      }
      
      public function set zone(param1:Rectangle) : void
      {
         this._zone = param1;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.startAnimation();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
