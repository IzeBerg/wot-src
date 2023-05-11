package net.wg.gui.rally.views.list
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.helpers.UserInfoTextLoadingController;
   import net.wg.gui.rally.interfaces.IRallyVO;
   
   public class SimpleRallyDetailsSection extends BaseRallyDetailsSection
   {
       
      
      public var headerTF:TextField;
      
      public var descriptionTF:TextField;
      
      private var _userInfoTextLoadingController:UserInfoTextLoadingController = null;
      
      public function SimpleRallyDetailsSection()
      {
         super();
         this._userInfoTextLoadingController = new UserInfoTextLoadingController();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.headerTF)
         {
            this.headerTF.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            this.headerTF.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         }
         if(this.descriptionTF)
         {
            this.descriptionTF.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            this.descriptionTF.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         }
         this._userInfoTextLoadingController.setControlledUserNameTextField(this.headerTF);
         this._userInfoTextLoadingController.clearUserName();
      }
      
      override protected function onDispose() : void
      {
         if(this.headerTF)
         {
            this.headerTF.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            this.headerTF.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
            this.headerTF = null;
         }
         if(this.descriptionTF)
         {
            this.descriptionTF.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            this.descriptionTF.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
            this.descriptionTF = null;
         }
         this._userInfoTextLoadingController.dispose();
         this._userInfoTextLoadingController = null;
         super.onDispose();
      }
      
      override protected function setChangedVisibilityItems() : void
      {
         super.setChangedVisibilityItems();
         addItemsToChangedVisibilityList(this.headerTF,this.descriptionTF);
      }
      
      override protected function updateElements() : void
      {
         super.updateElements();
         if(isModelAvailable())
         {
            this.updateTitle(model);
            this.updateDescription(model);
         }
      }
      
      override protected function updateNoRallyScreen(param1:Boolean) : void
      {
         super.updateNoRallyScreen(param1);
         this._userInfoTextLoadingController.clearUserName();
      }
      
      protected function updateTitle(param1:IRallyVO) : void
      {
         if(param1 && param1.commanderExtendedUserVO)
         {
            this._userInfoTextLoadingController.setUserNameFromProps(App.utils.commons.getUserProps(param1.commanderExtendedUserVO.userName,param1.commanderExtendedUserVO.clanAbbrev,param1.commanderExtendedUserVO.region));
         }
         else
         {
            this._userInfoTextLoadingController.clearUserName();
         }
      }
      
      protected function updateDescription(param1:IRallyVO) : void
      {
         this.descriptionTF.text = param1.description;
      }
      
      protected function get userInfoTextLoadingController() : UserInfoTextLoadingController
      {
         return this._userInfoTextLoadingController;
      }
      
      private function onControlRollOverHandler(param1:MouseEvent) : void
      {
         onControlRollOver(param1.currentTarget);
      }
      
      private function onControlRollOutHandler(param1:MouseEvent) : void
      {
         onControlRollOut(param1.currentTarget);
      }
   }
}
