package net.wg.gui.components.controls
{
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.interfaces.IDraggableList;
   import net.wg.gui.events.ListEventEx;
   import scaleform.clik.core.UIComponent;
   import scaleform.gfx.MouseEventEx;
   
   public class DragableListItemRenderer extends SoundListItemRenderer
   {
       
      
      protected var isDragging:Boolean = false;
      
      private var DRAGGING_DELTA:Number = 10;
      
      private var startDragX:Number = 0;
      
      protected var _empty:Boolean = false;
      
      protected var draggableOwner:IDraggableList = null;
      
      protected var _dataDirty:Boolean = false;
      
      private var _dragEnabled:Boolean = false;
      
      public function DragableListItemRenderer()
      {
         super();
      }
      
      public function imitateMouseOver() : void
      {
         this.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER,false,false,this.mouseX,this.mouseY));
      }
      
      override public function set owner(param1:UIComponent) : void
      {
         super.owner = param1;
         this.draggableOwner = param1 as IDraggableList;
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         if(this.draggableOwner && !this.draggableOwner.isSliding)
         {
            super.handleMouseRollOver(param1);
         }
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         if(this.draggableOwner && !this.draggableOwner.isSliding)
         {
            super.handleMouseRollOut(param1);
         }
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(!this.isDragging && this.dragEnabled)
         {
            _loc2_ = param1 as MouseEventEx;
            _loc3_ = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
            _loc4_ = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
            this.startDragX = owner.mouseX;
            this.isDragging = true;
            dispatchEvent(new ListEventEx(ListEventEx.ITEM_DRAG_START,false,true,index,-1,-1,this,this.data,_loc3_,_loc4_));
         }
         super.handleMousePress(param1);
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         if(this.isDragging && this.dragEnabled)
         {
            this.isDragging = false;
            dispatchEvent(new ListEventEx(ListEventEx.ITEM_DRAG_STOP,false,true,index));
         }
         super.handleMouseRelease(param1);
         if(Math.abs(this.startDragX - owner.mouseX) > this.DRAGGING_DELTA)
         {
            return;
         }
      }
      
      override protected function handleReleaseOutside(param1:MouseEvent) : void
      {
         if(this.isDragging && this.dragEnabled)
         {
            this.isDragging = false;
            dispatchEvent(new ListEventEx(ListEventEx.ITEM_DRAG_STOP,false,false,index));
         }
         super.handleReleaseOutside(param1);
         if(Math.abs(this.startDragX - owner.mouseX) > this.DRAGGING_DELTA)
         {
            return;
         }
      }
      
      [Inspectable(defaultValue="false",name="dragEnabled")]
      public function set dragEnabled(param1:Boolean) : void
      {
         if(param1 == this._dragEnabled)
         {
            return;
         }
         this._dragEnabled = param1;
      }
      
      public function get dragEnabled() : Boolean
      {
         return this._dragEnabled;
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1)
         {
            this.empty = param1.empty;
         }
      }
      
      public function get empty() : Boolean
      {
         return this._empty;
      }
      
      public function set empty(param1:Boolean) : void
      {
         if(this._empty == param1)
         {
            return;
         }
         this._empty = param1;
         this._dataDirty = true;
         tabEnabled = !!focusable ? Boolean(false) : Boolean(!this._empty);
         setState(!enabled ? "disabled" : "up");
      }
   }
}
