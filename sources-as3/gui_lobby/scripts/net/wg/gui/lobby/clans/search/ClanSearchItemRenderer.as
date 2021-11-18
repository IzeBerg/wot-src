package net.wg.gui.lobby.clans.search
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.lobby.clans.common.IClanNameField;
   import net.wg.gui.lobby.clans.search.VOs.ClanSearchItemVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class ClanSearchItemRenderer extends TableRenderer
   {
      
      private static const ARROW_RIGHT:int = 16;
       
      
      public var clanCmp:IClanNameField = null;
      
      public var playersTF:TextField = null;
      
      public var creationDateTF:TextField = null;
      
      public var ratingTF:TextField = null;
      
      public var arrow:Image = null;
      
      private var _rendererVO:ClanSearchItemVO = null;
      
      public function ClanSearchItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._rendererVO = ClanSearchItemVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         this.clanCmp.canShowBg = true;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.clanCmp.dispose();
         this.clanCmp = null;
         this.arrow.dispose();
         this.arrow = null;
         this.ratingTF = null;
         this.creationDateTF = null;
         this.playersTF = null;
         this._rendererVO = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._rendererVO != null;
            this.clanCmp.visible = _loc1_;
            this.playersTF.visible = _loc1_;
            this.creationDateTF.visible = _loc1_;
            this.ratingTF.visible = _loc1_;
            if(_loc1_)
            {
               this.clanCmp.clanVO = this._rendererVO.clanInfo;
               this.playersTF.htmlText = this._rendererVO.players;
               this.creationDateTF.htmlText = this._rendererVO.creationDate;
               this.ratingTF.htmlText = this._rendererVO.rating;
               this.arrow.source = this._rendererVO.arrowIcon;
            }
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.arrow.visible = selected;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.arrow.x = width - ARROW_RIGHT;
         }
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(this._rendererVO && App.utils.commons.isRightButton(param1))
         {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_CLAN,this,this._rendererVO.clanInfo);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._rendererVO)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CLAN_COMMON_INFO,null,this._rendererVO.clanInfo.dbID);
         }
      }
   }
}
