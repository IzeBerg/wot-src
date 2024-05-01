package net.wg.gui.lobby.profile.pages.summary
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class LineTextFieldsLayout implements IDisposable
   {
       
      
      private var _maxWidth:uint;
      
      private var _centerAreaWidth:int;
      
      private var leftPairs:Vector.<Array>;
      
      private var rightPairs:Vector.<Array>;
      
      private var _disposed:Boolean = false;
      
      public function LineTextFieldsLayout(param1:uint, param2:int)
      {
         this.leftPairs = new Vector.<Array>();
         this.rightPairs = new Vector.<Array>();
         super();
         this._maxWidth = param1;
         this._centerAreaWidth = param2;
      }
      
      public function layout() : void
      {
         this.applyGap(this.leftPairs);
         this.applyGap(this.rightPairs,(this._maxWidth + this._centerAreaWidth) / 2);
      }
      
      private function applyGap(param1:Vector.<Array>, param2:int = 0) : void
      {
         var _loc6_:Array = null;
         var _loc8_:DisplayObject = null;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc3_:uint = param1.length;
         if(param1.length == 0 || param1[0].length == 0)
         {
            return;
         }
         var _loc4_:Number = DisplayObject(param1[0][0]).width;
         var _loc5_:int = Math.round(((this._maxWidth - this._centerAreaWidth) / 2 - _loc3_ * _loc4_) / (_loc3_ + 1));
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_)
         {
            _loc6_ = param1[_loc7_];
            _loc9_ = _loc6_.length;
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
               _loc8_ = _loc6_[_loc10_];
               _loc8_.x = param2 + _loc5_ + _loc7_ * (_loc4_ + _loc5_);
               _loc10_++;
            }
            _loc7_++;
         }
      }
      
      public function addLeftPair(param1:DisplayObject, param2:DisplayObject) : void
      {
         this.leftPairs.push([param1,param2]);
      }
      
      public function addRightPair(param1:DisplayObject, param2:DisplayObject) : void
      {
         this.rightPairs.push([param1,param2]);
      }
      
      public function set maxWidth(param1:uint) : void
      {
         this._maxWidth = param1;
      }
      
      public function set centerAreaWidth(param1:int) : void
      {
         this._centerAreaWidth = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         while(this.leftPairs.length > 0)
         {
            this.leftPairs.splice(this.leftPairs.length - 1,1);
         }
         this.leftPairs = null;
         while(this.rightPairs.length > 0)
         {
            this.rightPairs.splice(this.rightPairs.length - 1,1);
         }
         this.rightPairs = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
