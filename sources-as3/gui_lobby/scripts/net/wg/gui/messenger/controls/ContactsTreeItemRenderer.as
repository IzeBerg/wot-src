package net.wg.gui.messenger.controls
{
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.messenger.data.ContactItemVO;
   import net.wg.gui.messenger.data.ContactsListTreeItemInfo;
   import net.wg.gui.messenger.data.ITreeItemInfo;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.InputEvent;
   
   public class ContactsTreeItemRenderer extends ContactItemRenderer
   {
      
      private static const ITEM_INSIDE_GROUP_PADDING:int = 10;
      
      private static const MAIN_GROUP_ITEM_LINKAGE:String = "MainGroupItemUI";
      
      private static const CONTACT_GROUP_ITEM_LINKAGE:String = "ContactGroupItemUI";
      
      private static const EMPTY_HIGHLIGHT_AREA_LINKAGE:String = "EmptyHighlightAreaUI";
      
      private static const CONTACT_ITEM_LINKAGE:String = "ContactItemUI";
       
      
      private var _myData:ITreeItemInfo;
      
      private var _dashedArea:EmptyHighlightArea;
      
      private var _contactItem:ContactItem;
      
      private var _mainGroupItem:MainGroupItem;
      
      private var _contactGroupItem:ContactGroupItem;
      
      private var _currentContentItem:UIComponent;
      
      private var _isNewDataIsEqualOldData:Boolean = true;
      
      public function ContactsTreeItemRenderer()
      {
         super();
         _toggle = false;
      }
      
      override public function getCurrentContentItem() : UIComponent
      {
         return this._currentContentItem;
      }
      
      override public function getData() : Object
      {
         return this._myData;
      }
      
      override public function setData(param1:Object) : void
      {
         this._isNewDataIsEqualOldData = false;
         if(param1 && this._myData && this._myData.id != null)
         {
            if(ContactsListTreeItemInfo(this._myData).isEquals(ContactsListTreeItemInfo(param1)))
            {
               this._isNewDataIsEqualOldData = true;
               return;
            }
         }
         this._myData = ITreeItemInfo(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraintsDisabled = true;
         constraints = null;
      }
      
      override protected function draw() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:UIComponent = null;
         var _loc4_:IUpdatable = null;
         var _loc5_:EmptyRowVO = null;
         var _loc6_:Number = NaN;
         super.draw();
         var _loc1_:Boolean = !this._isNewDataIsEqualOldData && isInvalid(InvalidationType.DATA);
         if(_loc1_)
         {
            if(this._myData)
            {
               visible = true;
               _loc2_ = true;
               if(this._myData.isBrunch)
               {
                  if(this._myData.parent == null)
                  {
                     if(this._mainGroupItem == null)
                     {
                        this._mainGroupItem = App.utils.classFactory.getComponent(MAIN_GROUP_ITEM_LINKAGE,MainGroupItem);
                     }
                     _loc3_ = this._mainGroupItem;
                     _loc2_ = false;
                  }
                  else
                  {
                     if(this._contactGroupItem == null)
                     {
                        this._contactGroupItem = App.utils.classFactory.getComponent(CONTACT_GROUP_ITEM_LINKAGE,ContactGroupItem);
                     }
                     _loc3_ = this._contactGroupItem;
                  }
               }
               else if(this._myData.id == null)
               {
                  if(this._dashedArea == null)
                  {
                     this._dashedArea = App.utils.classFactory.getComponent(EMPTY_HIGHLIGHT_AREA_LINKAGE,EmptyHighlightArea);
                     this._dashedArea.setSize(_width,_height);
                  }
                  _loc5_ = new EmptyRowVO(this._myData.data);
                  _loc6_ = !!_loc5_.isVisible ? Number(1) : Number(0);
                  this._dashedArea.dashedAreaAlpha = _loc6_;
                  this._dashedArea.defaultTextAlpha = _loc6_;
                  _loc3_ = this._dashedArea;
                  _loc2_ = _loc5_.isActive;
               }
               else
               {
                  if(this._contactItem == null)
                  {
                     this._contactItem = App.utils.classFactory.getComponent(CONTACT_ITEM_LINKAGE,ContactItem);
                  }
                  if(this._myData.parent.parent == null)
                  {
                     this._contactItem.x = 0;
                     this._contactItem.width = _width;
                  }
                  else
                  {
                     this._contactItem.x = ITEM_INSIDE_GROUP_PADDING;
                     this._contactItem.width = _width - ITEM_INSIDE_GROUP_PADDING;
                  }
                  _loc3_ = this._contactItem;
               }
               if(_loc3_ != this._currentContentItem)
               {
                  if(this._currentContentItem)
                  {
                     removeChild(this._currentContentItem);
                  }
                  addChild(_loc3_);
               }
               this._currentContentItem = _loc3_;
               _loc4_ = this._currentContentItem as IUpdatable;
               if(_loc4_)
               {
                  _loc4_.update(this._myData.data);
                  this._currentContentItem.validateNow();
               }
               this.enabled = _loc2_;
               if(this.isItemOver() && !this._isNewDataIsEqualOldData)
               {
                  this.updateTooltip();
               }
            }
            else
            {
               visible = false;
            }
            this._isNewDataIsEqualOldData = true;
         }
         if(_loc1_ || isInvalid(DRAGGING_ITEM_INV))
         {
            alpha = !isNaN(draggedItemId) && this._currentContentItem != null && this._currentContentItem == this._contactItem && ContactItemVO(this._contactItem.data).dbID == draggedItemId ? Number(0.3) : Number(1);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._dashedArea)
         {
            this._dashedArea.dispose();
            this._dashedArea = null;
         }
         if(this._contactItem)
         {
            this._contactItem.dispose();
         }
         if(this._mainGroupItem)
         {
            this._mainGroupItem.dispose();
         }
         if(this._contactGroupItem)
         {
            this._contactGroupItem.dispose();
         }
         this._contactItem = null;
         this._mainGroupItem = null;
         this._contactGroupItem = null;
         this._currentContentItem = null;
         this._myData = null;
         background = null;
         super.onDispose();
      }
      
      protected function showTooltip() : void
      {
         var _loc1_:ContactItemVO = null;
         if(this._currentContentItem == this._contactItem && this._contactItem)
         {
            _loc1_ = ContactItemVO(this._contactItem.data);
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CONTACT,null,_loc1_.dbID,null);
         }
         else if(this._currentContentItem == this._contactGroupItem)
         {
            App.toolTipMgr.show(this._contactGroupItem.label);
         }
      }
      
      protected function hideTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      private function updateTooltip() : void
      {
         this.hideTooltip();
         if(this._myData.id != null && !this._myData.isBrunch)
         {
            this.showTooltip();
         }
      }
      
      private function isItemOver() : Boolean
      {
         var _loc1_:Point = new Point(mouseX,mouseY);
         _loc1_ = this.localToGlobal(_loc1_);
         return this.hitTestPoint(_loc1_.x,_loc1_.y,true);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(super.enabled == param1)
         {
            return;
         }
         super.enabled = param1;
      }
      
      override public function get data() : Object
      {
         return this._myData;
      }
      
      override public function get getCursorType() : String
      {
         if(this._currentContentItem == this._contactItem)
         {
            return Cursors.DRAG_OPEN;
         }
         if(this._currentContentItem == this._contactGroupItem)
         {
            return Cursors.HAND;
         }
         return Cursors.ARROW;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.showTooltip();
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this.hideTooltip();
      }
   }
}

import net.wg.data.daapi.base.DAAPIDataClass;

class EmptyRowVO extends DAAPIDataClass
{
    
   
   public var isActive:Boolean;
   
   public var isVisible:Boolean;
   
   function EmptyRowVO(param1:Object)
   {
      super(param1);
   }
}
