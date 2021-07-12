package net.wg.gui.messenger.windows
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.messenger.meta.ILobbyChannelWindowMeta;
   import net.wg.gui.messenger.meta.impl.LobbyChannelWindowMeta;
   import scaleform.clik.utils.ConstrainedElement;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   import scaleform.gfx.MouseEventEx;
   
   public class LobbyChannelWindow extends LobbyChannelWindowMeta implements ILobbyChannelWindowMeta
   {
      
      private static const INVALID_LIST_VISIBILITY:String = "invalidListVisibility";
      
      private static const INVALID_WARNING_VISIBILITY:String = "invalidWarningVisibility";
      
      private static const MEMBERS_LIST:String = "membersList";
      
      private static const MESSAGE_AREA:String = "messageArea";
      
      private static const WARNING_PADDING:int = 2;
      
      private static const WARNING_PANEL:String = "warningPanel";
       
      
      public var warningPanel:PMWarningPanel;
      
      public var membersList:ScrollingListEx;
      
      protected var _membersDP:DAAPIDataProvider;
      
      private var _needToHideList:Boolean = false;
      
      private var _showWarning:Boolean = false;
      
      private var _membersListElement:ConstrainedElement;
      
      private var _msgAreaElement:ConstrainedElement;
      
      private const CONTENT_PADDING:Padding = new Padding(38,10,11,10);
      
      private const SB_PADDING:Padding = new Padding(0,0,0,0);
      
      public function LobbyChannelWindow()
      {
         super();
         this._membersDP = new DAAPIDataProvider();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.contentPadding = this.CONTENT_PADDING;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints.addElement(MEMBERS_LIST,this.membersList,Constraints.RIGHT | Constraints.TOP | Constraints.BOTTOM);
         constraints.addElement(WARNING_PANEL,this.warningPanel,Constraints.RIGHT | Constraints.TOP | Constraints.LEFT);
         this._membersListElement = constraints.getElement(MEMBERS_LIST);
         this._msgAreaElement = constraints.getElement(MESSAGE_AREA);
         this.membersList.sbPadding = this.SB_PADDING;
         this.membersList.addEventListener(ListEventEx.ITEM_CLICK,this.onMemberItemClickHandler);
         this.membersList.dataProvider = this._membersDP;
         this.membersList.smartScrollBar = true;
         window.titleUseHtml = true;
         this.warningPanel.closeWarningBtn.addEventListener(MouseEvent.CLICK,this.onCloseWarningClick);
      }
      
      override protected function draw() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:DisplayObject = null;
         if(isInvalid(INVALID_LIST_VISIBILITY) && this._needToHideList)
         {
            this._needToHideList = false;
            this.membersList.visible = false;
            _loc1_ = channelComponent.messageArea;
            _loc2_ = DisplayObject(channelComponent.sendButton);
            _loc1_.width = _loc2_.x + _loc2_.width - (_loc1_.x << 1);
            constraints.removeElement(MESSAGE_AREA);
            constraints.addElement(MESSAGE_AREA,channelComponent.messageArea,Constraints.ALL);
         }
         if(isInvalid(INVALID_WARNING_VISIBILITY) && this.warningPanel.visible != this._showWarning)
         {
            this.warningPanel.visible = this._showWarning;
            if(this.membersList.visible)
            {
               this.updatePartSize(this.membersList,this._membersListElement,this._showWarning);
            }
            this.updatePartSize(channelComponent.messageArea,this._msgAreaElement,this._showWarning);
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this._membersDP.cleanUp();
         this._membersDP = null;
         this.membersList.removeEventListener(ListEventEx.ITEM_CLICK,this.onMemberItemClickHandler);
         this.membersList.dispose();
         this.membersList = null;
         this.warningPanel.dispose();
         this.warningPanel = null;
         this._membersListElement = null;
         this._msgAreaElement = null;
         super.onDispose();
      }
      
      public function as_getMembersDP() : Object
      {
         return this._membersDP;
      }
      
      public function as_hideMembersList() : void
      {
         this._needToHideList = true;
         invalidate(INVALID_LIST_VISIBILITY);
      }
      
      public function as_showWarning(param1:String) : void
      {
         this.warningPanel.setWarning(param1);
         this.warningVisibility = true;
      }
      
      private function updatePartSize(param1:MovieClip, param2:ConstrainedElement, param3:Boolean) : void
      {
         var _loc4_:Number = this.warningPanel.height - WARNING_PADDING;
         if(param3)
         {
            param2.top += _loc4_;
            param1.y += _loc4_;
            param1.height -= _loc4_;
         }
         else
         {
            param2.top -= _loc4_;
            param1.y -= _loc4_;
            param1.height += _loc4_;
         }
      }
      
      public function get warningVisibility() : Boolean
      {
         return this._showWarning;
      }
      
      public function set warningVisibility(param1:Boolean) : void
      {
         if(this._showWarning == param1)
         {
            return;
         }
         this._showWarning = param1;
         invalidate(INVALID_WARNING_VISIBILITY);
      }
      
      private function onMemberItemClickHandler(param1:ListEventEx) : void
      {
         if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_USER,this,param1.itemData);
         }
      }
      
      private function onCloseWarningClick(param1:MouseEvent) : void
      {
         this.warningVisibility = false;
         onWarningCloseS();
      }
   }
}
