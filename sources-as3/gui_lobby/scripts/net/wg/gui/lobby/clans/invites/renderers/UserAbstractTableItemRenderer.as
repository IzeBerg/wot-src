package net.wg.gui.lobby.clans.invites.renderers
{
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.helpers.UserInfoTextLoadingController;
   import net.wg.gui.lobby.clans.invites.VOs.UserInvitesWindowItemVO;
   import net.wg.infrastructure.interfaces.IUserProps;
   import scaleform.clik.constants.InvalidationType;
   
   public class UserAbstractTableItemRenderer extends ClanInvitesWindowAbstractTableItemRenderer
   {
       
      
      public var userName:TextField = null;
      
      public var contextMenuArea:Sprite = null;
      
      private var _userInfoTextLoadingController:UserInfoTextLoadingController = null;
      
      private var _rendererVO:UserInvitesWindowItemVO = null;
      
      public function UserAbstractTableItemRenderer()
      {
         super();
         this._userInfoTextLoadingController = new UserInfoTextLoadingController();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._rendererVO = UserInvitesWindowItemVO(param1);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.contextMenuArea.removeEventListener(MouseEvent.CLICK,this.onContextMenuAreaClickHandler);
         this.userName = null;
         this.contextMenuArea = null;
         this._userInfoTextLoadingController.dispose();
         this._userInfoTextLoadingController = null;
         this._rendererVO = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:IUserProps = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._rendererVO != null;
            _loc2_ = _loc1_ && this._rendererVO.hasShowMoreButton;
            this.userName.visible = _loc1_ && !_loc2_;
            if(this.userName.visible)
            {
               _loc3_ = App.utils.commons.getUserProps(this._rendererVO.userInfo.userName,this._rendererVO.userInfo.clanAbbrev,this._rendererVO.userInfo.region,this._rendererVO.userInfo.igrType,this._rendererVO.userInfo.tags);
               this.contextMenuArea.mouseEnabled = true;
               this._userInfoTextLoadingController.setUserNameFromProps(_loc3_);
               if(this._userInfoTextLoadingController.getIsUserNameLoading())
               {
                  this.contextMenuArea.mouseEnabled = false;
               }
            }
            else
            {
               this._userInfoTextLoadingController.clearUserName();
            }
         }
      }
      
      override protected function onConfigUI() : void
      {
         super.onConfigUI();
         addRollOverComponent(this.contextMenuArea);
         this.contextMenuArea.addEventListener(MouseEvent.CLICK,this.onContextMenuAreaClickHandler);
         this.contextMenuArea.buttonMode = true;
         this.contextMenuArea.useHandCursor = true;
         this._userInfoTextLoadingController.setControlledUserNameTextField(this.userName);
         this._userInfoTextLoadingController.clearUserName();
      }
      
      override protected function onComponentRollOverHandlerImpl(param1:IEventDispatcher) : void
      {
         var _loc2_:UserVO = null;
         super.onComponentRollOverHandlerImpl(param1);
         if(this._rendererVO != null && param1 == this.contextMenuArea)
         {
            _loc2_ = this._rendererVO.userInfo;
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CONTACT,null,_loc2_.dbID,_loc2_.userName);
         }
      }
      
      private function onContextMenuAreaClickHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isRightButton(param1))
         {
            if(this._rendererVO != null && this._rendererVO.canShowContextMenu)
            {
               App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BASE_USER,this,this._rendererVO.userInfo);
            }
         }
      }
   }
}
