package net.wg.gui.components.controls
{
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class ScrollingListWithDisRenderers extends SortableScrollingList
   {
       
      
      private var _isFocusedDisabledRenderers:Boolean;
      
      public function ScrollingListWithDisRenderers()
      {
         super();
      }
      
      override protected function populateData(param1:Array) : void
      {
         var _loc5_:IListItemRenderer = null;
         var _loc6_:int = 0;
         var _loc7_:ListData = null;
         App.toolTipMgr.hide();
         var _loc2_:int = param1.length;
         var _loc3_:int = _renderers.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = getRendererAt(_loc4_);
            _loc6_ = _scrollPosition + _loc4_;
            _loc5_.enabled = _loc4_ < _loc2_ && param1 && param1[_loc4_].enabled;
            _loc5_.setData(param1[_loc4_]);
            _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_ && this.rendererIsEnabled(_loc5_));
            _loc5_.setListData(_loc7_);
            _loc5_.validateNow();
            _loc4_++;
         }
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.updateStatesForVisibleRenderers();
         }
      }
      
      override protected function selectedRenderer(param1:IListItemRenderer, param2:Boolean) : void
      {
         var _loc3_:Boolean = this.rendererIsEnabled(param1);
         param1.selected = param2 && _loc3_;
         param1.validateNow();
      }
      
      protected function rendererIsEnabled(param1:IListItemRenderer) : Boolean
      {
         return this.isFocusedDisabledRenderers || param1.enabled;
      }
      
      private function updateStatesForVisibleRenderers() : void
      {
         refreshData();
      }
      
      public function get isFocusedDisabledRenderers() : Boolean
      {
         return this._isFocusedDisabledRenderers;
      }
      
      [Inspectable(defaultValue="false",name="isFocusedDisRenderers",verbose="1")]
      public function set isFocusedDisabledRenderers(param1:Boolean) : void
      {
         this._isFocusedDisabledRenderers = param1;
      }
   }
}
