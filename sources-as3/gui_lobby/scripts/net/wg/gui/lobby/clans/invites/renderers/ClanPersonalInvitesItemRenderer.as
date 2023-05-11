package net.wg.gui.lobby.clans.invites.renderers
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.CompactCheckBox;
   import net.wg.gui.lobby.clans.common.IClanNameField;
   import net.wg.gui.lobby.clans.invites.VOs.PersonalInviteVO;
   import net.wg.gui.lobby.clans.invites.components.AcceptActions;
   import net.wg.utils.ICommons;
   
   public class ClanPersonalInvitesItemRenderer extends ClanInvitesWindowAbstractTableItemRenderer
   {
      
      private static const DISABLED_ALPHA:Number = 0.5;
       
      
      public var accept:AcceptActions = null;
      
      public var clanName:IClanNameField = null;
      
      public var clanNameCheckBox:CompactCheckBox = null;
      
      public var contextMenuArea:Sprite = null;
      
      private var _rendererVO:PersonalInviteVO = null;
      
      private var _commons:ICommons = null;
      
      public function ClanPersonalInvitesItemRenderer()
      {
         super();
         this._commons = App.utils.commons;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._rendererVO = PersonalInviteVO(param1);
      }
      
      override protected function onDispose() : void
      {
         this.accept.dispose();
         this.accept = null;
         this.clanName.removeEventListener(MouseEvent.ROLL_OVER,this.onClanNameRollOverHandler);
         this.clanName.removeEventListener(MouseEvent.ROLL_OUT,this.onClanNameRollOutHandler);
         this.clanName.removeEventListener(MouseEvent.CLICK,this.onClanNameClickHandler);
         this.clanName.dispose();
         this.clanName = null;
         this.clanNameCheckBox.removeEventListener(MouseEvent.CLICK,this.onClanNameCheckBoxClickHandler);
         this.clanNameCheckBox.dispose();
         this.clanNameCheckBox = null;
         this._rendererVO = null;
         this._commons = null;
         this.contextMenuArea = null;
         super.onDispose();
      }
      
      override protected function onConfigUI() : void
      {
         super.onConfigUI();
         this.contextMenuArea.visible = false;
         this.clanNameCheckBox.label = "";
         this.clanNameCheckBox.visible = false;
         this.clanName.addEventListener(MouseEvent.ROLL_OVER,this.onClanNameRollOverHandler);
         this.clanName.addEventListener(MouseEvent.ROLL_OUT,this.onClanNameRollOutHandler);
         this.clanName.addEventListener(MouseEvent.CLICK,this.onClanNameClickHandler);
         this.clanNameCheckBox.addEventListener(MouseEvent.CLICK,this.onClanNameCheckBoxClickHandler);
      }
      
      override protected function onDataUpdated() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         super.onDataUpdated();
         _loc1_ = this._rendererVO != null;
         _loc2_ = _loc1_ && this._rendererVO.hasShowMoreButton;
         var _loc3_:Boolean = _loc1_ && this._rendererVO.enabled && !_loc2_;
         if(_loc1_)
         {
            this.clanName.clanVO = this._rendererVO.clanVO;
            this.clanName.buttonMode = this._rendererVO.canShowContextMenu;
            this.clanName.useHandCursor = this._rendererVO.canShowContextMenu;
            this.clanNameCheckBox.enabled = _loc3_;
            this.clanNameCheckBox.selected = this._rendererVO.checked;
            if(!_loc2_)
            {
               alpha = !!_loc3_ ? Number(Values.DEFAULT_ALPHA) : Number(DISABLED_ALPHA);
               this.accept.setModel(this._rendererVO.actions,this._rendererVO.dbID);
            }
            else
            {
               alpha = Values.DEFAULT_ALPHA;
            }
         }
         this.accept.visible = _loc1_ && !_loc2_;
         this.clanNameCheckBox.visible = _loc1_ && !_loc2_;
         this.clanName.visible = _loc1_ && !_loc2_;
      }
      
      private function dispatchCheckChangeEvent() : void
      {
         var _loc1_:String = !!this.clanNameCheckBox.selected ? ClanTableRendererItemEvent.ITEM_UNCHECKED : ClanTableRendererItemEvent.ITEM_CHECKED;
         var _loc2_:ClanTableRendererItemEvent = new ClanTableRendererItemEvent(_loc1_,true);
         _loc2_.dbID = this._rendererVO.dbID;
         dispatchEvent(_loc2_);
      }
      
      private function onClanNameRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CLAN_COMMON_INFO,null,this._rendererVO.clanVO.dbID);
      }
      
      private function onClanNameRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onClanNameCheckBoxClickHandler(param1:MouseEvent) : void
      {
         if(this._rendererVO.enabled && this._commons.isLeftButton(param1))
         {
            this.dispatchCheckChangeEvent();
         }
      }
      
      private function onClanNameClickHandler(param1:MouseEvent) : void
      {
         if(this._rendererVO.enabled && this._commons.isLeftButton(param1))
         {
            this.dispatchCheckChangeEvent();
         }
         else if(this._commons.isRightButton(param1))
         {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_CLAN,this,{
               "dbID":this._rendererVO.clanVO.dbID,
               "clanName":this._rendererVO.clanVO.clanName,
               "clanAbbrev":this._rendererVO.clanVO.clanAbbrev
            });
         }
      }
   }
}
