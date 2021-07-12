package net.wg.gui.prebattle.battleSession
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.events.MessengerBarEvent;
   import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
   import net.wg.gui.prebattle.meta.IBattleSessionListMeta;
   import net.wg.gui.prebattle.meta.impl.BattleSessionListMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   
   public class BattleSessionList extends BattleSessionListMeta implements IBattleSessionListMeta
   {
      
      private static const TEAM_LIST:String = "teamList";
       
      
      public var groupsScrollBar:ScrollBar;
      
      public var groupsList:ScrollingListEx;
      
      public var groupListBG:MovieClip;
      
      private var contentPadding:Padding;
      
      public function BattleSessionList()
      {
         this.contentPadding = new Padding(38,13,8,13);
         super();
         showWindowBgForm = false;
         canMinimize = true;
         enabledCloseBtn = false;
      }
      
      override public function as_setGeometry(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         param3 = this.groupListBG.width + this.contentPadding.left + this.contentPadding.right;
         param4 = this.groupListBG.height + this.contentPadding.top + this.contentPadding.bottom;
         super.as_setGeometry(param1,param2,param3,param4);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.groupsList.addEventListener(ListEventEx.ITEM_CLICK,this.handleTeamItemClick);
         this.setConstraints();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
         this.groupsList.removeEventListener(ListEventEx.ITEM_CLICK,this.handleTeamItemClick);
         this.groupsList.dispose();
         this.groupsList = null;
         this.groupsScrollBar.dispose();
         this.groupsScrollBar = null;
         App.utils.data.cleanupDynamicObject(this.contentPadding);
         this.contentPadding = null;
         this.groupListBG = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onRequestFocusHandler);
         window.setTitleIcon(TEAM_LIST);
         window.title = CHAT.CHANNELS_SPECIAL_BATTLES;
         geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW,getClientIDS());
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function refreshList(param1:DataProvider) : void
      {
         this.groupsList.dataProvider = param1;
      }
      
      private function setConstraints() : void
      {
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement(this.groupsList.name,this.groupsList,Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
         constraints.addElement(this.groupListBG.name,this.groupListBG,Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
         constraints.addElement(this.groupsScrollBar.name,this.groupsScrollBar,Constraints.TOP | Constraints.BOTTOM | Constraints.RIGHT);
      }
      
      private function onRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         setFocus(param1.focusContainer.getComponentForFocus());
      }
      
      private function handleTeamItemClick(param1:ListEventEx) : void
      {
         var _loc2_:BSListRendererVO = BSListRendererVO(param1.itemData);
         requestToJoinTeamS(_loc2_.prbID,_loc2_.prbType);
      }
   }
}
