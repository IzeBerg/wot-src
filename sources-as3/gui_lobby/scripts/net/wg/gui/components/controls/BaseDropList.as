package net.wg.gui.components.controls
{
   import flash.events.MouseEvent;
   import net.wg.gui.interfaces.IDropList;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class BaseDropList extends ScrollingListEx implements IDropList
   {
       
      
      private var _selectable:Boolean = false;
      
      public function BaseDropList()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut,false,0,true);
         this.hideHighLight();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseOver,false);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseOut,false);
         super.onDispose();
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
      
      public function highlightList() : void
      {
      }
      
      public function hideHighLight() : void
      {
      }
      
      protected function onMouseOver(param1:MouseEvent) : void
      {
      }
      
      protected function onMouseOut(param1:MouseEvent) : void
      {
      }
   }
}
