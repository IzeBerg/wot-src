package net.wg.gui.crewOperations
{
   import net.wg.gui.components.controls.ScrollingListEx;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class CrewOperationsScrollingList extends ScrollingListEx
   {
       
      
      public function CrewOperationsScrollingList()
      {
         super();
      }
      
      override protected function drawLayout() : void
      {
      }
      
      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         return _dataProvider.length;
      }
      
      private function positionRenderers() : void
      {
         var _loc1_:int = 0;
         var _loc6_:IListItemRenderer = null;
         var _loc2_:int = _renderers.length;
         var _loc3_:Number = margin + padding.left;
         var _loc4_:Number = margin + padding.top;
         var _loc5_:Number = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc6_ = getRendererAt(_loc1_);
            _loc6_.x = Math.round(_loc3_);
            _loc6_.y = Math.round(_loc4_ + _loc5_);
            _loc5_ += _loc6_.height;
            _loc1_++;
         }
      }
      
      override protected function populateData(param1:Array) : void
      {
         super.populateData(param1);
         this.positionRenderers();
      }
      
      override public function get height() : Number
      {
         return this.actualHeight;
      }
      
      override public function get width() : Number
      {
         return this.actualWidth;
      }
      
      override public function get availableHeight() : Number
      {
         return Math.round(this.actualHeight) - (margin << 1);
      }
   }
}
