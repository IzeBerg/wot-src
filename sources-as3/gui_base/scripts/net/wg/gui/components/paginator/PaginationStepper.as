package net.wg.gui.components.paginator
{
   import net.wg.gui.events.ListEventEx;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class PaginationStepper extends CoreList
   {
       
      
      public function PaginationStepper()
      {
         super();
      }
      
      override protected function drawLayout() : void
      {
         var _loc4_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = getRendererAt(_loc3_);
            _loc4_.x = _loc2_;
            _loc2_ += _loc4_.width;
            _loc3_++;
         }
         dispatchEventAndSound(new ListEventEx(ListEventEx.LAYOUT_CHANGE));
      }
      
      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         return _totalRenderers;
      }
      
      override protected function updateSelectedIndex() : void
      {
         this.updateRenderer(_selectedIndex,true);
      }
      
      override protected function createRenderer(param1:uint) : IListItemRenderer
      {
         var _loc2_:IListItemRenderer = super.createRenderer(param1);
         _loc2_.index = param1;
         return _loc2_;
      }
      
      private function updateRenderer(param1:int, param2:Boolean = false) : void
      {
         if(param1 < 0 || param1 >= _renderers.length)
         {
            return;
         }
         var _loc3_:IListItemRenderer = getRendererAt(param1);
         _loc3_.selected = param2;
      }
      
      override public function set selectedIndex(param1:int) : void
      {
         if(_selectedIndex == param1 || param1 < 0)
         {
            return;
         }
         this.updateRenderer(_selectedIndex);
         _selectedIndex = param1;
         invalidateSelectedIndex();
         dispatchEventAndSound(new ListEventEx(ListEventEx.INDEX_CHANGE,true,false,_selectedIndex));
      }
      
      public function set renderersCount(param1:int) : void
      {
         _totalRenderers = param1;
         invalidateRenderers();
      }
   }
}
