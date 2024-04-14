package net.wg.gui.lobby.missions.components
{
   import net.wg.gui.components.controls.VerticalListViewPort;
   import net.wg.gui.components.controls.scroller.ScrollerBase;
   import net.wg.gui.components.controls.scroller.data.ScrollConfig;
   import net.wg.gui.lobby.eventBoards.components.MissionsEventBoardsBody;
   import net.wg.gui.lobby.missions.components.headerComponents.MarathonHeaderConditionItemRenderer;
   import net.wg.infrastructure.interfaces.IListDAAPIDataProvider;
   import net.wg.infrastructure.managers.IPopoverManager;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class MissionsList extends ScrollerBase
   {
      
      private static const GAP:int = 50;
       
      
      private var _viewPort:VerticalListViewPort;
      
      private var _dataProvider:IDataProvider;
      
      private var _itemRendererClassName:String;
      
      public function MissionsList()
      {
         super();
         this._viewPort = new VerticalListViewPort();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:ScrollConfig = new ScrollConfig();
         _loc1_.normalizeWheelScrollDelta = false;
         _loc1_.mouseWheelScrollDuration = 0;
         this.scrollConfig = _loc1_;
         cropContent = true;
         useTimer = true;
         touchScrollEnabled = false;
         this._viewPort.gap = GAP;
         viewPort = this._viewPort;
      }
      
      override protected function roundToNearest(param1:Number, param2:Number) : Number
      {
         return param1;
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.RENDERERS))
         {
            this._viewPort.itemRendererClassName = this._itemRendererClassName;
         }
         if(this._dataProvider != null && isInvalid(InvalidationType.DATA))
         {
            this._viewPort.dataProvider = this._dataProvider;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this._viewPort.dispose();
         this._viewPort = null;
         this._dataProvider = null;
         super.onDispose();
      }
      
      override protected function startScroll() : void
      {
         super.startScroll();
         var _loc1_:IPopoverManager = App.popoverMgr;
         if(_loc1_.popoverCaller != null && (_loc1_.popoverCaller is MarathonHeaderConditionItemRenderer || _loc1_.popoverCaller is MissionsEventBoardsBody))
         {
            _loc1_.hide();
         }
      }
      
      override protected function isViewPortUnderMouse() : Boolean
      {
         return true;
      }
      
      public function scrollTo(param1:Number, param2:Number = 0.0) : void
      {
         verticalScrollPosition = param1;
         this.startScroll();
         throwToVerticalPosition(param1,param2);
      }
      
      public function scrollToItem(param1:String, param2:*) : void
      {
         this.scrollToIndex(IListDAAPIDataProvider(this._dataProvider).getItemIndex(param1,param2));
      }
      
      public function scrollToIndex(param1:int) : void
      {
         if(param1 > this._viewPort.getBottomVisibleRendererIndex())
         {
            this.scrollContentToPosition(verticalScrollPosition + height);
            if(param1 > this._viewPort.getBottomVisibleRendererIndex())
            {
               this.scrollToIndex(param1);
            }
         }
         if(param1 <= this._viewPort.getBottomVisibleRendererIndex())
         {
            this.scrollContentToPosition(this._viewPort.getRendererPosition(param1));
         }
      }
      
      public function scrollToEvent(param1:String, param2:*) : void
      {
         var _loc3_:int = IListDAAPIDataProvider(this._dataProvider).getItemIndex(param1,param2);
         this.scrollContentToPosition(this._viewPort.getRendererY(_loc3_));
      }
      
      private function scrollContentToPosition(param1:Number) : void
      {
         verticalScrollPosition = param1;
         validateNow();
         this._viewPort.validateNow();
      }
      
      public function get itemRendererClassName() : String
      {
         return this._itemRendererClassName;
      }
      
      public function set itemRendererClassName(param1:String) : void
      {
         if(this._itemRendererClassName == param1)
         {
            return;
         }
         this._itemRendererClassName = param1;
         invalidate(InvalidationType.RENDERERS);
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         if(this._dataProvider == param1)
         {
            return;
         }
         this._dataProvider = param1;
         invalidateData();
      }
   }
}
