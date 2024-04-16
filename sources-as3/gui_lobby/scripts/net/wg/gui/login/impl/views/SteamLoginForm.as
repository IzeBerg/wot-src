package net.wg.gui.login.impl.views
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.login.IFormBaseVo;
   import net.wg.gui.login.impl.ev.LoginEvent;
   import net.wg.gui.login.impl.vo.SteamLoginFormVo;
   import net.wg.gui.login.impl.vo.SubmitDataVo;
   
   public class SteamLoginForm extends LoginFormView
   {
       
      
      public var serverField:TextField = null;
      
      public var accountField:TextField = null;
      
      public var accountNameField:TextFieldShort = null;
      
      private var _dataVo:SteamLoginFormVo = null;
      
      public function SteamLoginForm()
      {
         super();
      }
      
      override public function getSubmitData() : SubmitDataVo
      {
         var _loc1_:SubmitDataVo = super.getSubmitData();
         _loc1_.login = this._dataVo.userName;
         return _loc1_;
      }
      
      override public function updateVo(param1:IFormBaseVo) : void
      {
         this._dataVo = SteamLoginFormVo(param1);
         super.updateVo(param1);
      }
      
      override protected function dispatchFocus() : void
      {
         dispatchEvent(new LoginEvent(LoginEvent.FOCUS_INIT,true,false,submit));
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.serverField.text = MENU.LOGIN_SERVER;
         this.accountField.text = MENU.LOGIN_ACCOUNT;
         this.accountNameField.buttonMode = false;
         App.utils.commons.initTabIndex(new <InteractiveObject>[submit,server]);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(!this._dataVo)
         {
            return;
         }
         if(isInvalid(LoginFormView.INVALID_INIT_FOCUS))
         {
            this.dispatchFocus();
         }
      }
      
      override protected function redrawAll() : void
      {
         this.accountNameField.label = this._dataVo.userName;
      }
      
      override protected function onDispose() : void
      {
         this.accountNameField.dispose();
         this.accountNameField = null;
         this._dataVo = null;
         super.onDispose();
      }
   }
}
