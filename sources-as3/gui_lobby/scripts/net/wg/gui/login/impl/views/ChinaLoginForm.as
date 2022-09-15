package net.wg.gui.login.impl.views
{
   import flash.display.InteractiveObject;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.login.IFormBaseVo;
   import net.wg.gui.login.impl.ev.LoginEvent;
   import net.wg.gui.login.impl.vo.FilledLoginFormVo;
   import net.wg.gui.login.impl.vo.SubmitDataVo;
   
   public class ChinaLoginForm extends LoginFormView
   {
      
      private static const INV_TOKEN:String = "inv_token";
      
      private static const DATA_VO_MSG:String = "_dataVo";
       
      
      public var serverField:TextField = null;
      
      public var accountField:TextField = null;
      
      public var accountNameField:TextFieldShort = null;
      
      private var _dataVo:FilledLoginFormVo = null;
      
      public function ChinaLoginForm()
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
         this._dataVo = param1 as FilledLoginFormVo;
         App.utils.asserter.assertNotNull(this._dataVo,DATA_VO_MSG + Errors.CANT_NULL);
         super.updateVo(param1);
      }
      
      override protected function dispatchFocus() : void
      {
         if(this._dataVo.haveToken)
         {
            dispatchEvent(new LoginEvent(LoginEvent.FOCUS_INIT,true,false,submit));
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.serverField.text = MENU.LOGIN_SERVER;
         this.accountField.text = MENU.LOGIN_ACCOUNT;
         this.accountNameField.buttonMode = false;
         App.utils.commons.initTabIndex(new <InteractiveObject>[submit]);
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
         }
         if(isInvalid(LoginFormView.INVALID_INIT_FOCUS))
         {
            this.dispatchFocus();
         }
      }
      
      override protected function redrawAll() : void
      {
         this.accountNameField.label = this._dataVo.userName;
         invalidate(INV_TOKEN);
         invalidateSize();
      }
      
      override protected function onDispose() : void
      {
         this.accountNameField.dispose();
         this.accountNameField = null;
         this.serverField = null;
         this._dataVo = null;
         super.onDispose();
      }
   }
}
