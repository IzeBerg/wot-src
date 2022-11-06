package net.wg.gui.lobby.clans.profile.renderers
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.lobby.clans.profile.VOs.ClanMemberVO;
   import net.wg.gui.messenger.controls.ContactItem;
   import scaleform.clik.constants.InvalidationType;
   
   public class ClanProfileMemberItemRenderer extends TableRenderer
   {
       
      
      public var userName:ContactItem = null;
      
      public var roleTF:TextField = null;
      
      public var personalRatingTF:TextField = null;
      
      public var battlesCountTF:TextField = null;
      
      public var winsTF:TextField = null;
      
      public var awgExpTF:TextField = null;
      
      public var daysInClanTF:TextField = null;
      
      public var contextMenuArea:Sprite = null;
      
      public var postIcon:Image = null;
      
      private var _rendererVO:ClanMemberVO = null;
      
      public function ClanProfileMemberItemRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._rendererVO = ClanMemberVO(param1);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.contextMenuArea.removeEventListener(MouseEvent.CLICK,this.onContextMenuAreaClickHandler);
         this.contextMenuArea.removeEventListener(MouseEvent.ROLL_OVER,this.onContextMenuAreaRollOverHandler);
         this.contextMenuArea.removeEventListener(MouseEvent.ROLL_OUT,this.onContextMenuAreaRollOutHandler);
         this.contextMenuArea = null;
         this.userName.dispose();
         this.userName = null;
         this.postIcon.dispose();
         this.postIcon = null;
         this.roleTF = null;
         this.personalRatingTF = null;
         this.battlesCountTF = null;
         this.winsTF = null;
         this.awgExpTF = null;
         this.daysInClanTF = null;
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
            if(_loc1_)
            {
               this.userName.data = this._rendererVO.contactItem;
               this.roleTF.htmlText = this._rendererVO.post;
               this.personalRatingTF.htmlText = this._rendererVO.personalRating;
               this.battlesCountTF.htmlText = this._rendererVO.battlesCount;
               this.winsTF.htmlText = this._rendererVO.wins;
               this.awgExpTF.htmlText = this._rendererVO.awgExp;
               this.daysInClanTF.htmlText = this._rendererVO.daysInClan;
               this.postIcon.source = this._rendererVO.postIcon;
            }
            this.visible = _loc1_;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.contextMenuArea.addEventListener(MouseEvent.ROLL_OVER,this.onContextMenuAreaRollOverHandler);
         this.contextMenuArea.addEventListener(MouseEvent.ROLL_OUT,this.onContextMenuAreaRollOutHandler);
         this.contextMenuArea.addEventListener(MouseEvent.CLICK,this.onContextMenuAreaClickHandler);
         this.contextMenuArea.buttonMode = true;
         this.contextMenuArea.useHandCursor = true;
         App.utils.commons.updateChildrenMouseEnabled(this,false);
         this.contextMenuArea.mouseEnabled = true;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
      }
      
      private function onContextMenuAreaRollOverHandler(param1:MouseEvent) : void
      {
         if(this._rendererVO != null)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CONTACT,null,this._rendererVO.dbID,this._rendererVO.userName);
         }
      }
      
      private function onContextMenuAreaRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onContextMenuAreaClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         if(App.utils.commons.isRightButton(param1))
         {
            if(this._rendererVO != null && this._rendererVO.canShowContextMenu)
            {
               _loc2_ = {
                  "dbID":this._rendererVO.dbID,
                  "userName":this._rendererVO.userName,
                  "clanAbbrev":true,
                  "showClanProfile":false
               };
               App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_USER,this,_loc2_);
            }
         }
      }
   }
}
