package net.wg.gui.lobby.vehicleInfo
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleInfoViewContent extends UIComponentEx implements IViewStackContent
   {
      
      private static const OFFSET_Y:Number = 19;
      
      private static const START_Y:Number = 6;
      
      private static const START_X:Number = 10;
       
      
      private var _itemClass:Class;
      
      private var _blocks:Vector.<Sprite>;
      
      public function VehicleInfoViewContent(param1:Class)
      {
         super();
         this._itemClass = param1;
         this._blocks = new Vector.<Sprite>();
      }
      
      override public function toString() : String
      {
         return "[WG " + this + " " + name + "]";
      }
      
      override protected function onDispose() : void
      {
         this.clearBlocks();
         this._blocks = null;
         this._itemClass = null;
         super.onDispose();
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function update(param1:Object) : void
      {
         var _loc5_:IVehicleInfoBlock = null;
         this.clearBlocks();
         var _loc2_:Vector.<Object> = param1 as Vector.<Object>;
         App.utils.asserter.assertNotNull(_loc2_,Errors.INVALID_TYPE + Vector);
         var _loc3_:uint = _loc2_.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new this._itemClass() as IVehicleInfoBlock;
            App.utils.asserter.assertNotNull(_loc5_,Errors.INVALID_TYPE + IVehicleInfoBlock);
            _loc5_.setData(_loc2_[_loc4_]);
            _loc5_.x = START_X;
            _loc5_.y = START_Y + OFFSET_Y * _loc4_;
            this.addChild(DisplayObject(_loc5_));
            _loc4_++;
         }
      }
      
      private function clearBlocks() : void
      {
         var _loc3_:Sprite = null;
         var _loc1_:uint = this._blocks.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._blocks[_loc2_];
            IDisposable(_loc3_).dispose();
            removeChild(_loc3_);
            _loc2_++;
         }
         this._blocks.splice(0,_loc1_);
      }
   }
}
