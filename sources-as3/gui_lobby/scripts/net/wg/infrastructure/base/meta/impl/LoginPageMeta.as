package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.login.impl.vo.FilledLoginFormVo;
   import net.wg.gui.login.impl.vo.SimpleFormVo;
   import net.wg.gui.login.impl.vo.SocialIconVo;
   import net.wg.gui.login.impl.vo.SteamLoginFormVo;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class LoginPageMeta extends AbstractView
   {
       
      
      public var onLogin:Function;
      
      public var onRegister:Function;
      
      public var onRecovery:Function;
      
      public var onTextLinkClick:Function;
      
      public var onLoginBySocial:Function;
      
      public var onSetRememberPassword:Function;
      
      public var onLoginNameUpdated:Function;
      
      public var isToken:Function;
      
      public var resetToken:Function;
      
      public var onEscape:Function;
      
      public var isCSISUpdateOnRequest:Function;
      
      public var startListenCsisUpdate:Function;
      
      public var showLegal:Function;
      
      public var changeAccount:Function;
      
      private var _simpleFormVo:SimpleFormVo;
      
      private var _dataProviderSocialIconVo:DataProvider;
      
      private var _filledLoginFormVo:FilledLoginFormVo;
      
      private var _steamLoginFormVo:SteamLoginFormVo;
      
      public function LoginPageMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:SocialIconVo = null;
         if(this._simpleFormVo)
         {
            this._simpleFormVo.dispose();
            this._simpleFormVo = null;
         }
         if(this._dataProviderSocialIconVo)
         {
            for each(_loc1_ in this._dataProviderSocialIconVo)
            {
               _loc1_.dispose();
            }
            this._dataProviderSocialIconVo.cleanUp();
            this._dataProviderSocialIconVo = null;
         }
         if(this._filledLoginFormVo)
         {
            this._filledLoginFormVo.dispose();
            this._filledLoginFormVo = null;
         }
         if(this._steamLoginFormVo)
         {
            this._steamLoginFormVo.dispose();
            this._steamLoginFormVo = null;
         }
         super.onDispose();
      }
      
      public function onLoginS(param1:String, param2:String, param3:String, param4:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onLogin,"onLogin" + Errors.CANT_NULL);
         this.onLogin(param1,param2,param3,param4);
      }
      
      public function onRegisterS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onRegister,"onRegister" + Errors.CANT_NULL);
         this.onRegister(param1);
      }
      
      public function onRecoveryS() : void
      {
         App.utils.asserter.assertNotNull(this.onRecovery,"onRecovery" + Errors.CANT_NULL);
         this.onRecovery();
      }
      
      public function onTextLinkClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onTextLinkClick,"onTextLinkClick" + Errors.CANT_NULL);
         this.onTextLinkClick(param1);
      }
      
      public function onLoginBySocialS(param1:String, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.onLoginBySocial,"onLoginBySocial" + Errors.CANT_NULL);
         this.onLoginBySocial(param1,param2);
      }
      
      public function onSetRememberPasswordS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onSetRememberPassword,"onSetRememberPassword" + Errors.CANT_NULL);
         this.onSetRememberPassword(param1);
      }
      
      public function onLoginNameUpdatedS() : void
      {
         App.utils.asserter.assertNotNull(this.onLoginNameUpdated,"onLoginNameUpdated" + Errors.CANT_NULL);
         this.onLoginNameUpdated();
      }
      
      public function isTokenS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isToken,"isToken" + Errors.CANT_NULL);
         return this.isToken();
      }
      
      public function resetTokenS() : void
      {
         App.utils.asserter.assertNotNull(this.resetToken,"resetToken" + Errors.CANT_NULL);
         this.resetToken();
      }
      
      public function onEscapeS() : void
      {
         App.utils.asserter.assertNotNull(this.onEscape,"onEscape" + Errors.CANT_NULL);
         this.onEscape();
      }
      
      public function isCSISUpdateOnRequestS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.isCSISUpdateOnRequest,"isCSISUpdateOnRequest" + Errors.CANT_NULL);
         return this.isCSISUpdateOnRequest();
      }
      
      public function startListenCsisUpdateS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.startListenCsisUpdate,"startListenCsisUpdate" + Errors.CANT_NULL);
         this.startListenCsisUpdate(param1);
      }
      
      public function showLegalS() : void
      {
         App.utils.asserter.assertNotNull(this.showLegal,"showLegal" + Errors.CANT_NULL);
         this.showLegal();
      }
      
      public function changeAccountS() : void
      {
         App.utils.asserter.assertNotNull(this.changeAccount,"changeAccount" + Errors.CANT_NULL);
         this.changeAccount();
      }
      
      public final function as_setDefaultValues(param1:Object) : void
      {
         var _loc2_:SimpleFormVo = this._simpleFormVo;
         this._simpleFormVo = new SimpleFormVo(param1);
         this.setDefaultValues(this._simpleFormVo);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_showSimpleForm(param1:Boolean, param2:Array, param3:Boolean) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:SocialIconVo = null;
         var _loc4_:DataProvider = this._dataProviderSocialIconVo;
         this._dataProviderSocialIconVo = new DataProvider();
         if(param2)
         {
            _loc5_ = param2.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               this._dataProviderSocialIconVo[_loc6_] = new SocialIconVo(param2[_loc6_]);
               _loc6_++;
            }
         }
         this.showSimpleForm(param1,this._dataProviderSocialIconVo,param3);
         if(_loc4_)
         {
            for each(_loc7_ in _loc4_)
            {
               _loc7_.dispose();
            }
            _loc4_.cleanUp();
         }
      }
      
      public final function as_showFilledLoginForm(param1:Object) : void
      {
         var _loc2_:FilledLoginFormVo = this._filledLoginFormVo;
         this._filledLoginFormVo = new FilledLoginFormVo(param1);
         this.showFilledLoginForm(this._filledLoginFormVo);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_showSteamLoginForm(param1:Object) : void
      {
         var _loc2_:SteamLoginFormVo = this._steamLoginFormVo;
         this._steamLoginFormVo = new SteamLoginFormVo(param1);
         this.showSteamLoginForm(this._steamLoginFormVo);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setDefaultValues(param1:SimpleFormVo) : void
      {
         var _loc2_:String = "as_setDefaultValues" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function showSimpleForm(param1:Boolean, param2:DataProvider, param3:Boolean) : void
      {
         var _loc4_:String = "as_showSimpleForm" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc4_);
         throw new AbstractException(_loc4_);
      }
      
      protected function showFilledLoginForm(param1:FilledLoginFormVo) : void
      {
         var _loc2_:String = "as_showFilledLoginForm" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function showSteamLoginForm(param1:SteamLoginFormVo) : void
      {
         var _loc2_:String = "as_showSteamLoginForm" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
