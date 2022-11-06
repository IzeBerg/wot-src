package net.wg.gui.lobby.clans.profile
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.ClanEmblem;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.clans.common.ClanBaseInfoVO;
   import net.wg.gui.lobby.clans.common.IClanHeaderComponent;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileHeaderStateVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class ClanProfileMainWindowBaseHeader extends UIComponentEx implements IClanHeaderComponent
   {
      
      protected static const INV_HEADER_STATE:String = "InvHeaderState";
      
      protected static const EMBLEM_SHADOW_COLOR:uint = 0;
       
      
      public var bg:UILoaderAlt = null;
      
      public var clanNameTF:TextField = null;
      
      public var creationDateTF:TextField = null;
      
      public var clanEmblem:ClanEmblem = null;
      
      protected var _baseInfo:ClanBaseInfoVO = null;
      
      protected var _headerStateData:ClanProfileHeaderStateVO;
      
      private var _common:ICommons = null;
      
      public function ClanProfileMainWindowBaseHeader()
      {
         super();
         this._common = App.utils.commons;
         mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.clanNameTF.removeEventListener(MouseEvent.ROLL_OVER,this.onClanNameRollOverHandler);
         this.clanNameTF.removeEventListener(MouseEvent.ROLL_OUT,this.onClanNameRollOutHandler);
         this.clanNameTF = null;
         this.creationDateTF = null;
         this.clearFilters();
         this.clanEmblem.dispose();
         this.clanEmblem = null;
         if(this.bg)
         {
            this.bg.dispose();
            this.bg = null;
         }
         this._headerStateData = null;
         this._baseInfo = null;
         this._common = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._baseInfo)
         {
            this.updateClanTexts(this._baseInfo.name,this._baseInfo.creationDate);
            if(this.bg)
            {
               this.bg.source = this._baseInfo.bgIcon;
               this.bg.mouseEnabled = false;
               this.bg.mouseChildren = false;
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.clanNameTF.addEventListener(MouseEvent.ROLL_OVER,this.onClanNameRollOverHandler);
         this.clanNameTF.addEventListener(MouseEvent.ROLL_OUT,this.onClanNameRollOutHandler);
         this.setClanEmblemShadowFilter();
      }
      
      public function setBaseInfo(param1:ClanBaseInfoVO) : void
      {
         this._baseInfo = param1;
         invalidateData();
      }
      
      public function setEmblem(param1:String) : void
      {
         this.clanEmblem.setImage(param1);
      }
      
      public function setState(param1:ClanProfileHeaderStateVO) : void
      {
         this._headerStateData = param1;
         invalidate(INV_HEADER_STATE);
      }
      
      public function updateFilters(param1:Boolean) : void
      {
         if(param1)
         {
            this.setFilter();
         }
         else
         {
            this.clearFilters();
         }
      }
      
      protected function setClanEmblemShadowFilter() : void
      {
         this.setFilter();
      }
      
      protected function updateClanTexts(param1:String, param2:String) : void
      {
         this._common.truncateTextFieldText(this.clanNameTF,param1);
         this.creationDateTF.htmlText = param2;
      }
      
      protected function sendActionEvent(param1:String) : void
      {
         dispatchEvent(new ClanProfileEvent(ClanProfileEvent.HEADER_BUTTON_CLICK,param1,null));
      }
      
      private function setFilter() : void
      {
         this._common.setShadowFilter(this.clanEmblem,EMBLEM_SHADOW_COLOR);
      }
      
      private function clearFilters() : void
      {
         if(this.clanEmblem && this.clanEmblem.filters)
         {
            this.clanEmblem.filters.splice(0,this.clanEmblem.filters.length);
            this.clanEmblem.filters = null;
         }
      }
      
      private function onClanNameRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onClanNameRollOverHandler(param1:MouseEvent) : void
      {
         if(this._baseInfo && this.clanNameTF.text != this._baseInfo.name)
         {
            App.toolTipMgr.show(this._baseInfo.name);
         }
      }
   }
}
