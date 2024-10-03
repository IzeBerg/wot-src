package net.wg.gui.lobby.vehicleInfo
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.ScrollPane;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleInfoViewContent extends UIComponentEx implements IViewStackContent
   {
      
      private static const START_Y:uint = 6;
      
      private static const START_X:uint = 10;
      
      private static const WIDTH:uint = 504;
      
      private static const HEIGHT:uint = 507;
       
      
      public var scrollPane:ScrollPane;
      
      public var scrollBar:ScrollBar;
      
      private var _itemClass:Class;
      
      private var _blocks:Vector.<Sprite>;
      
      public function VehicleInfoViewContent(param1:Class)
      {
         super();
         this._itemClass = param1;
         this._blocks = new Vector.<Sprite>();
         this.scrollPane.setSize(WIDTH,HEIGHT);
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
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
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
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         this.clearBlocks();
         var _loc2_:Vector.<Object> = Vector.<Object>(param1);
         var _loc3_:MovieClip = this.scrollPane.target as MovieClip;
         var _loc4_:int = START_Y;
         if(_loc3_)
         {
            _loc6_ = _loc2_.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc5_ = new this._itemClass() as IVehicleInfoBlock;
               App.utils.asserter.assertNotNull(_loc5_,Errors.INVALID_TYPE + IVehicleInfoBlock);
               _loc5_.setData(_loc2_[_loc7_]);
               _loc5_.x = START_X;
               _loc5_.y = _loc4_;
               _loc4_ += Math.round(_loc5_.height);
               _loc3_.addChild(DisplayObject(_loc5_));
               this._blocks.push(_loc5_);
               _loc7_++;
            }
            _loc3_.bottomMC.y = _loc4_;
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
