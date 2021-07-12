package net.wg.gui.components.advanced
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DigitsComponent extends Sprite implements IDisposable
   {
      
      private static var GAPS:Dictionary = new Dictionary();
      
      {
         GAPS[BadgeSizes.X24] = -2;
         GAPS[BadgeSizes.X48] = -3;
         GAPS[BadgeSizes.X80] = -7;
         GAPS[BadgeSizes.X220] = -10;
      }
      
      private var _digits:Vector.<AtlasDigit>;
      
      private var _isAtlasSource:Boolean = false;
      
      private var _size:String = null;
      
      public function DigitsComponent(param1:Boolean)
      {
         this._digits = new Vector.<AtlasDigit>();
         this._isAtlasSource = param1;
         super();
      }
      
      public final function dispose() : void
      {
         var _loc3_:AtlasDigit = null;
         var _loc1_:int = this._digits.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._digits.pop();
            removeChild(_loc3_.sprite);
            _loc3_.dispose();
            _loc2_++;
         }
         this._size = null;
         this._digits = null;
      }
      
      public function setData(param1:String, param2:String) : void
      {
         var _loc6_:AtlasDigit = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc3_:int = this._digits.length;
         var _loc4_:int = Boolean(param1) ? int(param1.length) : int(Values.ZERO);
         this._size = param2;
         var _loc5_:AtlasDigit = null;
         if(_loc3_ < _loc4_)
         {
            while(_loc3_ < _loc4_)
            {
               _loc5_ = new AtlasDigit(this._isAtlasSource,this.updatePosition);
               this._digits.push(_loc5_);
               addChild(_loc5_.sprite);
               _loc3_++;
            }
         }
         else
         {
            while(_loc3_ > _loc4_)
            {
               _loc6_ = this._digits.pop();
               removeChild(_loc6_.sprite);
               _loc6_.dispose();
               _loc3_--;
            }
         }
         if(this._size != Values.EMPTY_STR)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               _loc8_ = param1.charAt(_loc7_);
               _loc5_ = this._digits[_loc7_];
               if(_loc5_.digit != _loc8_)
               {
                  _loc5_.setData(_loc8_,param2);
               }
               _loc7_++;
            }
         }
         if(this._isAtlasSource)
         {
            this.updatePosition();
         }
      }
      
      private function updatePosition() : void
      {
         var _loc2_:AtlasDigit = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this._digits)
         {
            _loc2_.sprite.x = _loc1_;
            _loc1_ += _loc2_.sprite.width + GAPS[this._size];
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
   }
}
