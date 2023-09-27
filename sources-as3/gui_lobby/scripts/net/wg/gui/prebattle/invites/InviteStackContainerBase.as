package net.wg.gui.prebattle.invites
{
   import flash.display.InteractiveObject;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.events.ListEventEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.utils.Constraints;
   import scaleform.gfx.MouseEventEx;
   
   public class InviteStackContainerBase extends UIComponentEx implements IViewStackContent
   {
       
      
      public var rosterList:ScrollingListEx;
      
      public var dataProvider:DAAPIDataProvider;
      
      public function InviteStackContainerBase()
      {
         this.dataProvider = new DAAPIDataProvider();
         super();
      }
      
      override protected function onDispose() : void
      {
         this.rosterList.removeEventListener(ListEventEx.ITEM_CLICK,this.showContextMenu);
         this.rosterList.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.rosterList_itemDoubleClickHandler);
         this.rosterList.disposeRenderers();
         this.rosterList = null;
         this.dataProvider.cleanUp();
         this.dataProvider = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.dataProvider = param1 as DAAPIDataProvider;
         this.rosterList.dataProvider = this.dataProvider;
         this.rosterList.validateNow();
      }
      
      override protected function configUI() : void
      {
         focusable = true;
         super.configUI();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement(this.rosterList.name,this.rosterList,Constraints.ALL);
         this.rosterList.addEventListener(ListEventEx.ITEM_CLICK,this.showContextMenu);
         this.rosterList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.rosterList_itemDoubleClickHandler);
         this.rosterList.useRightButton = true;
         this.rosterList.useRightButtonForSelect = true;
         this.rosterList.dataProvider = this.dataProvider as IDataProvider;
         this.rosterList.smartScrollBar = true;
         this.initDispatcher(SendInvitesEvent.INIT_COMPONENT,this);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(constraints && isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
         }
      }
      
      private function showContextMenu(param1:ListEventEx) : void
      {
         if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            this.initDispatcher(SendInvitesEvent.SHOW_CONTEXT_MENU,param1.itemData);
         }
      }
      
      protected function initDispatcher(param1:String, param2:Object) : void
      {
         var _loc3_:SendInvitesEvent = new SendInvitesEvent(param1,true);
         _loc3_.initItem = param2;
         dispatchEvent(_loc3_);
      }
      
      private function rosterList_itemDoubleClickHandler(param1:ListEventEx) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            if(param1.itemData)
            {
               this.initDispatcher(SendInvitesEvent.LIST_DOUBLE_CLICK,param1.itemData);
            }
         }
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
   }
}
