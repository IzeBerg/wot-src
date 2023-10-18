package net.wg.gui.lobby.profile.data
{
   import flash.display.DisplayObject;
   
   public class SectionLayoutManager
   {
       
      
      protected var store:Vector.<LayoutItemInfo>;
      
      protected var isInitialized:Boolean;
      
      private var minH:uint;
      
      private var maxH:uint;
      
      private var currentValue:uint = 0;
      
      public function SectionLayoutManager(param1:Number, param2:Number)
      {
         this.store = new Vector.<LayoutItemInfo>();
         super();
         this.minH = param1;
         this.maxH = param2;
      }
      
      public function dispose() : void
      {
         this.currentValue = 0;
         while(this.store.length > 0)
         {
            this.store.splice(this.store.length - 1,1);
         }
         this.store = null;
      }
      
      public function registerComponents(... rest) : void
      {
         var _loc3_:LayoutItemInfo = null;
         var _loc4_:DisplayObject = null;
         var _loc2_:uint = rest.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = new LayoutItemInfo();
            _loc4_ = rest[_loc5_];
            _loc3_.item = _loc4_;
            _loc3_.position = _loc4_.y / this.minH;
            this.store.push(_loc3_);
            _loc5_++;
         }
      }
      
      public function setDimension(param1:Number, param2:Number) : void
      {
         param2 = Math.max(this.minH,Math.min(this.maxH,param2));
         if(this.currentValue == param2)
         {
            return;
         }
         this.currentValue = param2;
         var _loc3_:uint = this.store.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this.applyDimensionToItem(_loc4_);
            _loc4_++;
         }
         this.isInitialized = true;
      }
      
      protected function applyDimensionToItem(param1:int) : void
      {
         var _loc2_:LayoutItemInfo = this.store[param1];
         _loc2_.item.y = Math.round(_loc2_.position * this.currentValue);
      }
   }
}
