package net.wg.gui.messenger.controls
{
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Errors;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.interfaces.IDropList;
   import net.wg.gui.messenger.data.ContactsGroupEvent;
   import net.wg.gui.messenger.data.GroupRulesVO;
   import net.wg.gui.messenger.data.ITreeItemInfo;
   import net.wg.gui.messenger.evnts.ContactsScrollingListEvent;
   import net.wg.infrastructure.events.DragEvent;
   import net.wg.infrastructure.events.DropEvent;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.gfx.MouseEventEx;
   
   public class ContactScrollingList extends BaseContactsScrollingList implements IDropList
   {
       
      
      private var currentDropCandidate:ITreeItemInfo;
      
      private var highlight:ContactsListHighlightArea;
      
      private var isCtrlPressed:Boolean;
      
      private var currentSelectedEmptyItem:EmptyHighlightArea;
      
      private var lastListItemIndex:int = -1;
      
      private var isUnderDrugging:Boolean;
      
      public function ContactScrollingList()
      {
         super();
         preventDefaultFocus = false;
      }
      
      override protected function populateData(param1:Array) : void
      {
         super.populateData(param1);
         if(this.isUnderDrugging)
         {
            this.checkDragDrop(ITreeItemInfo(getRendererAt(this.lastListItemIndex).getData()),this.lastListItemIndex);
         }
         dispatchEvent(new ContactsScrollingListEvent(ContactsScrollingListEvent.DATA_POPULATED,true));
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(DropEvent.END_DROP,this.dropEndHandler,false,0,true);
         addEventListener(DragEvent.START_DRAG,this.dragStartHandler,false,0,true);
         addEventListener(DragEvent.END_DRAG,this.dragEndHandler,false,0,true);
         App.gameInputMgr.setKeyHandler(Keyboard.CONTROL,KeyboardEvent.KEY_DOWN,this.ctrlDownHandler,true);
         App.gameInputMgr.setKeyHandler(Keyboard.CONTROL,KeyboardEvent.KEY_UP,this.ctrlUpHandler,true);
      }
      
      override protected function onDispose() : void
      {
         this.clearDragDrop();
         removeEventListener(DropEvent.END_DROP,this.dropEndHandler);
         removeEventListener(DragEvent.START_DRAG,this.dragStartHandler);
         removeEventListener(DropEvent.END_DROP,this.dragEndHandler);
         App.gameInputMgr.clearKeyHandler(Keyboard.CONTROL,KeyboardEvent.KEY_DOWN,this.ctrlDownHandler);
         App.gameInputMgr.clearKeyHandler(Keyboard.CONTROL,KeyboardEvent.KEY_UP,this.ctrlUpHandler);
         if(this.highlight)
         {
            this.highlight.dispose();
            this.highlight = null;
         }
         this.currentDropCandidate = null;
         this.currentSelectedEmptyItem = null;
         super.onDispose();
      }
      
      public function hideHighLight() : void
      {
         if(this.highlight)
         {
            this.highlight.visible = false;
         }
         this.hideOldEmptyItem();
      }
      
      public function highlightList() : void
      {
      }
      
      private function checkDragDrop(param1:ITreeItemInfo, param2:int) : void
      {
         var _loc3_:EmptyHighlightArea = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:ITreeItemInfo = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:GroupRulesVO = null;
         this.lastListItemIndex = param2;
         if(param1 != null && param1.parent != null)
         {
            _loc4_ = 0;
            _loc5_ = 0;
            _loc6_ = rowCount;
            if(param1.isBrunch)
            {
               this.currentDropCandidate = param1;
               _loc4_ = param2;
               _loc5_ = Math.min(!!param1.isOpened ? Number(param1.children.length + 1) : Number(1),_loc6_ - param2);
               if(_loc5_ == 2)
               {
                  _loc3_ = ContactsTreeItemRenderer(_renderers[param2 + 1]).getCurrentContentItem() as EmptyHighlightArea;
               }
            }
            else
            {
               this.currentDropCandidate = param1.parent;
               _loc4_ = 0;
               _loc3_ = ContactsTreeItemRenderer(_renderers[param2]).getCurrentContentItem() as EmptyHighlightArea;
               _loc8_ = param2 - 1;
               while(_loc8_ >= 0)
               {
                  _loc7_ = ITreeItemInfo(_renderers[_loc8_].getData());
                  if(_loc7_.isBrunch)
                  {
                     if(_loc7_.parent == null)
                     {
                        _loc4_ = _loc8_ + 1;
                        break;
                     }
                     if(this.currentDropCandidate.id != _loc7_.id)
                     {
                        _loc4_ = _loc8_ + 1;
                        break;
                     }
                     _loc4_ = _loc8_;
                     break;
                  }
                  if(this.currentDropCandidate.id != _loc7_.parent.id)
                  {
                     _loc4_ = _loc8_ + 1;
                     break;
                  }
                  _loc8_--;
               }
               _loc9_ = param2;
               while(_loc9_ < _loc6_)
               {
                  _loc7_ = ITreeItemInfo(_renderers[_loc9_].getData());
                  if(!_loc7_)
                  {
                     break;
                  }
                  if((!!_loc7_.isBrunch ? _loc7_.id : _loc7_.parent.id) != this.currentDropCandidate.id)
                  {
                     break;
                  }
                  _loc5_++;
                  _loc9_++;
               }
               _loc5_ += param2 - _loc4_;
               if(_loc5_ == 0)
               {
                  _loc5_ = 1;
               }
            }
            if(this.currentDropCandidate.parent)
            {
               _loc10_ = GroupRulesVO.fromObject(this.currentDropCandidate.data);
               if(_loc10_.isDropAllowed())
               {
                  this.showHighlight(true,_loc4_,_loc5_);
               }
               else
               {
                  this.currentDropCandidate = null;
                  this.showHighlight(false,_loc4_,_loc5_);
               }
            }
            else
            {
               this.showHighlight(true,_loc4_,_loc5_);
            }
         }
         else
         {
            this.currentDropCandidate = null;
            this.hideHighLight();
         }
         this.hideOldEmptyItem();
         if(_loc3_)
         {
            _loc3_.highlightArea(true);
            _loc3_.dashedArea.visible = false;
         }
         this.currentSelectedEmptyItem = _loc3_;
      }
      
      private function hideOldEmptyItem() : void
      {
         if(this.currentSelectedEmptyItem)
         {
            this.currentSelectedEmptyItem.highlightArea(false);
            this.currentSelectedEmptyItem.dashedArea.visible = true;
         }
      }
      
      private function showHighlight(param1:Boolean, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         _loc4_ = rowHeight;
         this.highlight.x = 0;
         this.highlight.y = param2 * _loc4_;
         this.highlight.width = _width;
         this.highlight.height = param3 * _loc4_;
         this.highlight.setDefColor(param1);
         this.highlight.visible = true;
      }
      
      private function clearDragDrop() : void
      {
         this.isUnderDrugging = false;
         removeEventListener(ListEventEx.ITEM_ROLL_OVER,this.listItemMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.listMouseOutHandler);
         this.hideHighLight();
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      override protected function dispatchItemEvent(param1:Event) : Boolean
      {
         var _loc2_:String = null;
         switch(param1.type)
         {
            case ButtonEvent.PRESS:
               _loc2_ = ListEventEx.ITEM_PRESS;
               break;
            case ButtonEvent.CLICK:
               _loc2_ = ListEventEx.ITEM_CLICK;
               break;
            case ButtonEvent.DRAG_OVER:
               _loc2_ = ListEventEx.ITEM_DRAG_OVER;
               break;
            case ButtonEvent.DRAG_OUT:
               _loc2_ = ListEventEx.ITEM_DRAG_OUT;
               break;
            case ButtonEvent.RELEASE_OUTSIDE:
               _loc2_ = ListEventEx.ITEM_RELEASE_OUTSIDE;
               break;
            case MouseEvent.ROLL_OVER:
               _loc2_ = ListEventEx.ITEM_ROLL_OVER;
               break;
            case MouseEvent.ROLL_OUT:
               _loc2_ = ListEventEx.ITEM_ROLL_OUT;
               break;
            case MouseEvent.DOUBLE_CLICK:
               _loc2_ = ListEventEx.ITEM_DOUBLE_CLICK;
               break;
            default:
               return true;
         }
         var _loc3_:IListItemRenderer = param1.currentTarget as IListItemRenderer;
         App.utils.asserter.assertNotNull(_loc3_,"renderer" + Errors.CANT_NULL);
         var _loc4_:uint = 0;
         if(param1 is ButtonEvent)
         {
            _loc4_ = (param1 as ButtonEvent).controllerIdx;
         }
         else if(param1 is MouseEventEx)
         {
            _loc4_ = (param1 as MouseEventEx).mouseIdx;
         }
         var _loc5_:uint = 0;
         if(param1 is ButtonEvent)
         {
            _loc5_ = (param1 as ButtonEvent).buttonIdx;
         }
         else if(param1 is MouseEventEx)
         {
            _loc5_ = (param1 as MouseEventEx).buttonIdx;
         }
         var _loc6_:Boolean = false;
         if(param1 is ButtonEvent)
         {
            _loc6_ = (param1 as ButtonEvent).isKeyboard;
         }
         var _loc7_:ListEventEx = new ListEventEx(_loc2_,false,true,_loc3_.index,0,_loc3_.index,_loc3_,_loc3_.getData(),_loc4_,_loc5_,_loc6_);
         callLogEvent(_loc7_,_loc3_.index);
         return dispatchEvent(_loc7_);
      }
      
      private function dragStartHandler(param1:DragEvent) : void
      {
         this.isUnderDrugging = true;
         if(this.highlight == null)
         {
            this.highlight = new ContactsListHighlightArea();
            addChildAt(this.highlight,0);
         }
         addEventListener(ListEventEx.ITEM_ROLL_OVER,this.listItemMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.listMouseOutHandler);
         this.checkDragDrop(ITreeItemInfo(IDropItem(param1.dragItem).data),_renderers.indexOf(IListItemRenderer(param1.dragItem)));
      }
      
      private function dragEndHandler(param1:DragEvent) : void
      {
         this.clearDragDrop();
      }
      
      private function dropEndHandler(param1:DropEvent) : void
      {
         var _loc2_:ContactsGroupEvent = null;
         var _loc3_:ContactsTreeItemRenderer = null;
         var _loc4_:ITreeItemInfo = null;
         if(this.currentDropCandidate)
         {
            _loc2_ = new ContactsGroupEvent(!!this.isCtrlPressed ? ContactsGroupEvent.CONTACT_COPY_GROUP : ContactsGroupEvent.CONTACT_CHANGE_GROUP,true);
            _loc3_ = App.cursor.getAttachedSprite() as ContactsTreeItemRenderer;
            App.utils.asserter.assertNotNull(_loc3_,"draggingItem" + Errors.CANT_NULL);
            _loc4_ = ITreeItemInfo(_loc3_.getData());
            _loc2_.contactID = Number(_loc4_.id);
            _loc2_.contactName = _loc4_.data.userProps.userName;
            _loc2_.targetGroup = this.currentDropCandidate;
            _loc2_.excludeGroup = _loc4_.parent;
            dispatchEvent(_loc2_);
         }
         this.clearDragDrop();
      }
      
      private function listItemMouseOverHandler(param1:ListEventEx) : void
      {
         this.checkDragDrop(ITreeItemInfo(param1.itemData),_renderers.indexOf(param1.itemRenderer));
      }
      
      private function listMouseOutHandler(param1:Event) : void
      {
         this.hideHighLight();
      }
      
      private function ctrlDownHandler(param1:InputEvent) : void
      {
         this.isCtrlPressed = true;
      }
      
      private function ctrlUpHandler(param1:InputEvent) : void
      {
         this.isCtrlPressed = false;
      }
   }
}
