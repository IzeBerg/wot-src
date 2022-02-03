package net.wg.gui.components.predictionIndicator
{
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.IRootAppMainContent;
   
   public class PredictionIndicator extends Sprite implements IRootAppMainContent
   {
      
      private static const PADDING_LEFT:int = 251;
      
      private static const PADDING_TOP:int = 188;
       
      
      public var hit_0:PredictionIndicatorItem = null;
      
      public var hit_1:PredictionIndicatorItem = null;
      
      public var hit_2:PredictionIndicatorItem = null;
      
      public var hit_3:PredictionIndicatorItem = null;
      
      public var hit_4:PredictionIndicatorItem = null;
      
      private var _items:Vector.<PredictionIndicatorItem> = null;
      
      private var _stageHalfWidth:int = 0;
      
      private var _stageHalfHeight:int = 0;
      
      private var _xPos:int = 0;
      
      private var _yPos:int = 0;
      
      private var _guiScale:int = 1;
      
      private var _disposed:Boolean = false;
      
      public function PredictionIndicator()
      {
         super();
         blendMode = BlendMode.SCREEN;
         this._items = new <PredictionIndicatorItem>[this.hit_0,this.hit_1,this.hit_2,this.hit_3,this.hit_4];
      }
      
      public function as_hide(param1:int) : void
      {
         if(param1 < 0 || param1 >= this._items.length)
         {
            return;
         }
         this._items[param1].hide();
      }
      
      public function as_setPosition(param1:Number, param2:Number) : void
      {
         this._xPos = param1;
         this._yPos = param2;
         this.updatePosition();
      }
      
      public function as_setScreenSettings(param1:Number, param2:Number, param3:Number) : void
      {
         this._guiScale = param1;
         this._stageHalfWidth = param2 >> 1;
         this._stageHalfHeight = param3 >> 1;
         this.updatePosition();
      }
      
      public function as_setYaw(param1:int, param2:Number) : void
      {
         this._items[param1].setYaw(param2);
      }
      
      public function as_show(param1:int) : void
      {
         if(param1 < 0 || param1 >= this._items.length)
         {
            return;
         }
         var _loc2_:PredictionIndicatorItem = this._items[param1];
         _loc2_.show();
         setChildIndex(_loc2_,numChildren - 1);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._items.length = 0;
         this._items = null;
         this.hit_0.dispose();
         this.hit_1.dispose();
         this.hit_2.dispose();
         this.hit_3.dispose();
         this.hit_4.dispose();
         this.hit_0 = null;
         this.hit_1 = null;
         this.hit_2 = null;
         this.hit_3 = null;
         this.hit_4 = null;
      }
      
      public function hideAll() : void
      {
         var _loc1_:PredictionIndicatorItem = null;
         for each(_loc1_ in this._items)
         {
            _loc1_.hide();
         }
      }
      
      private function updatePosition() : void
      {
         var _loc1_:PredictionIndicatorItem = null;
         x = PADDING_LEFT - this._stageHalfWidth + this._xPos;
         y = PADDING_TOP - this._stageHalfHeight + this._yPos;
         for each(_loc1_ in this._items)
         {
            _loc1_.scaleX = _loc1_.scaleY = this._guiScale;
         }
      }
      
      public function set rotateInfo(param1:Boolean) : void
      {
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
