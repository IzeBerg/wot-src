package net.wg.gui.rally.controls
{
   import flash.events.Event;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.cyberSport.controls.events.ManualSearchEvent;
   import net.wg.gui.cyberSport.interfaces.IManualSearchDataProvider;
   import net.wg.gui.rally.interfaces.IManualSearchRenderer;
   import net.wg.gui.rally.interfaces.IManualSearchScrollingList;
   import net.wg.utils.IAssertable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class ManualSearchScrollingList extends ScrollingListEx implements IManualSearchScrollingList
   {
       
      
      private var _asserter:IAssertable = null;
      
      public function ManualSearchScrollingList()
      {
         super();
         this._asserter = App.utils.asserter;
      }
      
      override public function set dataProvider(param1:IDataProvider) : void
      {
         if(_dataProvider == param1)
         {
            return;
         }
         if(_dataProvider != null)
         {
            this._asserter.assert(param1 is IManualSearchDataProvider,String(param1));
            _dataProvider.removeEventListener(Event.CHANGE,handleDataChange,false);
            _dataProvider.removeEventListener(ManualSearchEvent.DATA_UPDATED,this.handleDataUpdated,false);
         }
         _dataProvider = param1;
         if(_dataProvider == null)
         {
            return;
         }
         _dataProvider.addEventListener(Event.CHANGE,handleDataChange,false,0,true);
         _dataProvider.addEventListener(ManualSearchEvent.DATA_UPDATED,this.handleDataUpdated,false,0,true);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this._asserter = null;
         super.onDispose();
      }
      
      public function getManualSearchRendererAt(param1:uint, param2:int = 0) : IManualSearchRenderer
      {
         if(_renderers == null)
         {
            return null;
         }
         var _loc3_:uint = param1 - param2;
         if(_loc3_ >= _renderers.length)
         {
            return null;
         }
         return _renderers[_loc3_] as IManualSearchRenderer;
      }
      
      override protected function cleanUpDataProvider() : void
      {
         if(_dataProvider)
         {
            _dataProvider.removeEventListener(ManualSearchEvent.DATA_UPDATED,this.handleDataUpdated,false);
         }
         super.cleanUpDataProvider();
      }
      
      override protected function drawLayout() : void
      {
         var _loc8_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = rowHeight;
         var _loc3_:Number = availableWidth - padding.horizontal;
         var _loc4_:Number = margin + padding.left;
         var _loc5_:Number = margin + padding.top;
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc8_ = getRendererAt(_loc7_);
            _loc8_.x = Math.round(_loc4_);
            _loc8_.y = Math.round(_loc5_ + _loc7_ * _loc2_);
            _loc8_.width = _loc3_;
            if(!_loc6_)
            {
               _loc8_.validateNow();
            }
            _loc7_++;
         }
         drawScrollBar();
      }
      
      private function handleDataUpdated(param1:ManualSearchEvent) : void
      {
         _scrollPosition = Math.min(Math.max(0,_dataProvider.length - _totalRenderers),_scrollPosition);
         IManualSearchDataProvider(_dataProvider).requestUpdatedItems(_scrollPosition,Math.min(_dataProvider.length - 1,_scrollPosition + _totalRenderers - 1),this.updateData);
      }
      
      private function updateData(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:IManualSearchRenderer = null;
         var _loc2_:int = param1.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc2_)
         {
            _loc4_ = param1[_loc6_];
            _loc3_ = _loc4_[0];
            _loc5_ = this.getManualSearchRendererAt(_loc3_,_scrollPosition);
            if(_loc5_)
            {
               _loc5_.update(_loc4_[1]);
            }
            _loc6_++;
         }
      }
   }
}
