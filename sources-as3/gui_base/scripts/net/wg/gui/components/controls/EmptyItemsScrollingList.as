package net.wg.gui.components.controls
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class EmptyItemsScrollingList extends ScrollingListEx
   {
       
      
      public function EmptyItemsScrollingList()
      {
         super();
      }
      
      override protected function populateData(param1:Array) : void
      {
         var _loc5_:IListItemRenderer = null;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:ListData = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = _renderers.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_baseDisposed)
            {
               return;
            }
            _loc5_ = getRendererAt(_loc4_);
            _loc6_ = _scrollPosition + _loc4_;
            _loc7_ = param1[_loc4_];
            _loc8_ = new ListData(_loc6_,itemToLabel(_loc7_),_selectedIndex == _loc6_);
            _loc5_.enabled = _loc4_ < _loc2_;
            _loc5_.setListData(_loc8_);
            externalSetupRenderer(_loc5_);
            _loc5_.setData(_loc7_);
            _loc5_.validateNow();
            UIComponent(_loc5_).visible = _loc7_ != null;
            _loc4_++;
         }
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
   }
}
