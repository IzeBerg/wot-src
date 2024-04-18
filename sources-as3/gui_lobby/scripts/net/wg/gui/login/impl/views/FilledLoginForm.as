package net.wg.gui.login.impl.views
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.impl.ToolTipParams;
   import net.wg.gui.components.controls.IconTextBigButton;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.login.IFormBaseVo;
   import net.wg.gui.login.impl.ev.LoginEvent;
   import net.wg.gui.login.impl.vo.FilledLoginFormVo;
   import net.wg.gui.login.impl.vo.SubmitDataVo;
   import scaleform.clik.events.ButtonEvent;
   
   public class FilledLoginForm extends LoginFormView
   {
      
      public static var INV_TOKEN:String = "inv_token";
       
      
      public var serverField:TextField = null;
      
      public var accountField:TextField = null;
      
      public var accountNameField:TextFieldShort = null;
      
      public var changeAccount:SoundButtonEx = null;
      
      public var socialSubmit:IconTextBigButton = null;
      
      private var _dataVo:FilledLoginFormVo = null;
      
      public function FilledLoginForm()
      {
         super();
      }
      
      override public function getSubmitData() : SubmitDataVo
      {
         var _loc1_:SubmitDataVo = new SubmitDataVo();
         _loc1_.login = this._dataVo.userName;
         _loc1_.pwd = Values.EMPTY_STR;
         _loc1_.host = getSelectedServerName();
         _loc1_.isSocial = true;
         return _loc1_;
      }
      
      override public function updateVo(param1:IFormBaseVo) : void
      {
         var _loc2_:String = null;
         this._dataVo = param1 as FilledLoginFormVo;
         App.utils.asserter.assertNotNull(this._dataVo,"_dataVo" + Errors.CANT_NULL);
         this.socialSubmit.tooltip = TOOLTIPS.LOGIN_SOCIAL_ENTER;
         if(this._dataVo.socialId != Values.EMPTY_STR)
         {
            _loc2_ = App.utils.locale.makeString(TOOLTIPS.login_social(this._dataVo.socialId));
            this.socialSubmit.tooltipParams = new ToolTipParams({},{"social":_loc2_});
         }
         if(this._dataVo.icoPath)
         {
            this.socialSubmit.htmlIconStr = this._dataVo.icoPath;
         }
         super.updateVo(param1);
      }
      
      override protected function dispatchFocus() : void
      {
         if(this._dataVo.haveToken)
         {
            dispatchEvent(new LoginEvent(LoginEvent.FOCUS_INIT,true,false,submit));
         }
         else
         {
            dispatchEvent(new LoginEvent(LoginEvent.FOCUS_INIT,true,false,this.socialSubmit));
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.serverField.text = MENU.LOGIN_SERVER;
         this.accountField.text = MENU.LOGIN_ACCOUNT;
         this.changeAccount.label = MENU.LOGIN_CHANGEAACCOUNT;
         this.socialSubmit.label = MENU.LOGIN_SUBMITBYSOCIAL;
         this.changeAccount.addEventListener(ButtonEvent.CLICK,this.onChangeAccountClick);
         this.socialSubmit.addEventListener(ButtonEvent.CLICK,this.onSubmitWithoutToken);
         this.changeAccount.tooltip = TOOLTIPS.LOGIN_CHANGEACCOUNT;
         this.accountNameField.buttonMode = false;
         App.utils.commons.initTabIndex(new <InteractiveObject>[submit,this.changeAccount,server]);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(!this._dataVo)
         {
            return;
         }
         if(isInvalid(INV_TOKEN))
         {
            submit.visible = this._dataVo.haveToken;
            this.socialSubmit.visible = !this._dataVo.haveToken;
         }
         if(isInvalid(LoginFormView.INVALID_INIT_FOCUS))
         {
            this.dispatchFocus();
         }
      }
      
      override protected function redrawAll() : void
      {
         invalidate(INV_TOKEN);
         this.accountNameField.label = this._dataVo.userName;
         if(this._dataVo.icoPath)
         {
            this.socialSubmit.htmlIconStr = this._dataVo.icoPath;
         }
      }
      
      override protected function onDispose() : void
      {
         this.changeAccount.removeEventListener(ButtonEvent.CLICK,this.onChangeAccountClick);
         this.changeAccount.dispose();
         this.changeAccount = null;
         this.socialSubmit.removeEventListener(ButtonEvent.CLICK,this.onSubmitWithoutToken);
         this.socialSubmit.dispose();
         this.socialSubmit = null;
         this.accountNameField.dispose();
         this.accountNameField = null;
         this._dataVo = null;
         super.onDispose();
      }
      
      private function onChangeAccountClick(param1:ButtonEvent) : void
      {
         dispatchEvent(new LoginEvent(LoginEvent.ON_CHANGE_ACCOUNT_CLICK,true,false));
      }
      
      private function onSubmitWithoutToken(param1:ButtonEvent) : void
      {
         dispatchEvent(new LoginEvent(LoginEvent.ON_SUBMIT_WITHOUT_TOKEN,true,false,null,false,this._dataVo.socialId));
      }
   }
}
