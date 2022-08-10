package net.wg.gui.lobby.training
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.TileList;
   import net.wg.gui.interfaces.IDropList;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class DropTileList extends TileList implements IDropList
   {
      
      private static const INVALIDATE_RENDERERS_WIDTH:String = "invalidateRenderersWidth";
      
      private static const DRAG_OVER:String = "dragOver";
      
      private static const DRAG_OUT:String = "dragOut";
       
      
      private var _selectable:Boolean = false;
      
      public var focusIndicator:MovieClip;
      
      public function DropTileList()
      {
         super();
         this.focusIndicator.visible = false;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler,false,0,true);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.focusIndicator.gotoAndStop(DRAG_OVER);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler,false);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler,false);
         this.focusIndicator = null;
         super.onDispose();
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.focusIndicator.gotoAndStop(DRAG_OUT);
      }
      
      public function highlightList() : void
      {
         this.focusIndicator.visible = true;
      }
      
      public function hideHighLight() : void
      {
         this.focusIndicator.visible = false;
      }
      
      public function get selectable() : Boolean
      {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:IListItemRenderer = null;
         this._selectable = param1;
         if(_renderers != null)
         {
            _loc2_ = _renderers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = getRendererAt(_loc3_);
               _loc4_.selectable = this._selectable;
               _loc3_++;
            }
         }
      }
      
      override protected function updateScrollBar() : void
      {
         if(_scrollBar)
         {
            super.updateScrollBar();
            if(_scrollBar.visible)
            {
               _scrollBar.x = _width - _scrollBar.width - scrollBarPadding.right;
            }
            else
            {
               _scrollBar.x = _width;
            }
            invalidate(INVALIDATE_RENDERERS_WIDTH);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         var _loc4_:IListItemRenderer = null;
         var _loc5_:uint = 0;
         super.draw();
         if(isInvalid(INVALIDATE_RENDERERS_WIDTH))
         {
            _loc1_ = _renderers.length;
            _loc2_ = columnWidth;
            _loc3_ = isInvalid(InvalidationType.DATA);
            _loc5_ = 0;
            while(_loc5_ < _loc1_)
            {
               _loc4_ = getRendererAt(_loc5_);
               _loc4_.x = _loc5_ % _totalColumns * (_loc2_ + padding.right) + margin + padding.left;
               _loc4_.width = columnWidth;
               if(!_loc3_)
               {
                  _loc4_.validateNow();
               }
               _loc5_++;
            }
         }
      }
   }
}
