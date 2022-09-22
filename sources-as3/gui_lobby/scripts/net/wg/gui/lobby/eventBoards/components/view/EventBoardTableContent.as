package net.wg.gui.lobby.eventBoards.components.view
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.gui.lobby.eventBoards.components.Pagination;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableRendererContainerVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class EventBoardTableContent extends BaseDAAPIComponent implements IUIComponentEx
   {
      
      private static const AWARDS_HEIGHT:int = 80;
      
      private static const PAGINATION_MARGIN:int = 30;
      
      private static const PAGINATION_POS_X:int = 460;
      
      private static const INV_MY_PLACE:String = "InvMyPlace";
       
      
      public var pagination:Pagination = null;
      
      private var _renderers:Vector.<IListItemRenderer>;
      
      private var _data:EventBoardTableRendererContainerVO = null;
      
      private var _selectedIndex:int = -1;
      
      public function EventBoardTableContent()
      {
         this._renderers = new Vector.<IListItemRenderer>(0);
         super();
      }
      
      public function setData(param1:EventBoardTableRendererContainerVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function getRendererPosition(param1:uint) : Number
      {
         if(this._renderers == null)
         {
            return NaN;
         }
         if(param1 >= this._renderers.length)
         {
            return NaN;
         }
         return Number(DisplayObject(this._renderers[param1]).y - AWARDS_HEIGHT);
      }
      
      public function setMyPlace(param1:uint) : void
      {
         this._selectedIndex = param1;
         invalidate(INV_MY_PLACE);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.setupRenderers(this._data);
         }
         if(this._data && isInvalid(INV_MY_PLACE))
         {
            if(this._selectedIndex < this._renderers.length && this._renderers[this._selectedIndex])
            {
               this._renderers[this._selectedIndex].selected = true;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearRenderers(this._renderers);
         this.pagination = null;
         this._renderers = null;
         this._data = null;
         super.onDispose();
      }
      
      private function setupRenderers(param1:EventBoardTableRendererContainerVO) : void
      {
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:IListItemRenderer = null;
         if(this.numChildren > 0)
         {
            this.clearRenderers(this._renderers);
            this.height = 0;
         }
         var _loc2_:int = param1.tableDP.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.tableDP[_loc3_];
            _loc5_ = _loc4_.rendererLinkage;
            _loc6_ = App.utils.classFactory.getComponent(_loc5_,IListItemRenderer);
            _loc6_.x = 0;
            _loc6_.y = this.height;
            _loc6_.setData(_loc4_);
            this._renderers.push(_loc6_);
            this.addChild(DisplayObject(_loc6_));
            this.height += _loc6_.height;
            _loc3_++;
         }
         if(this.pagination)
         {
            this.pagination.x = PAGINATION_POS_X;
            this.pagination.y = this.height + PAGINATION_MARGIN;
            this.height += this.pagination.height + PAGINATION_MARGIN;
            this.pagination.visible = this.pagination.paginationEnabled();
         }
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function clearRenderers(param1:Vector.<IListItemRenderer>) : void
      {
         var _loc2_:DisplayObject = null;
         while(this.numChildren > 1)
         {
            _loc2_ = this.getChildAt(1);
            if(_loc2_ is IDisposable)
            {
               IDisposable(_loc2_).dispose();
            }
            this.removeChildAt(1);
         }
         param1.splice(0,param1.length);
      }
   }
}
