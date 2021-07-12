package net.wg.gui.login.impl
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import net.wg.gui.login.impl.ev.LoginViewStackEvent;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.core.UIComponent;
   
   public class LoginViewStack extends Sprite implements IDisposable
   {
       
      
      private var _cachedViews:Dictionary;
      
      private var _currentView:IUIComponentEx;
      
      private var _currentLinkage:String;
      
      public function LoginViewStack()
      {
         super();
         tabEnabled = false;
         this._cachedViews = new Dictionary(true);
      }
      
      override public function toString() : String
      {
         return "[WG LoginViewStack " + name + "]";
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         for(_loc1_ in this._cachedViews)
         {
            if(this._cachedViews[_loc1_] is IDisposable)
            {
               IDisposable(this._cachedViews[_loc1_]).dispose();
            }
         }
         App.utils.data.cleanupDynamicObject(this._cachedViews);
         this._cachedViews = null;
      }
      
      public function show(param1:String) : IUIComponentEx
      {
         var _loc2_:IUIComponentEx = this.createView(param1);
         this.setCurrentView(_loc2_,param1);
         if(_loc2_ != null)
         {
            if(IViewStackContent(_loc2_).canShowAutomatically())
            {
               _loc2_.visible = true;
            }
         }
         return _loc2_;
      }
      
      private function setCurrentView(param1:IUIComponentEx, param2:String) : void
      {
         if(this._currentView != null)
         {
            this._currentView.visible = false;
         }
         this._currentView = param1;
         this._currentLinkage = param2;
         if(this._currentView && this._currentLinkage)
         {
            dispatchEvent(new LoginViewStackEvent(LoginViewStackEvent.VIEW_CHANGED,this._currentView,this._currentLinkage));
         }
      }
      
      private function createView(param1:String) : IUIComponentEx
      {
         var _loc2_:IUIComponentEx = null;
         if(this._cachedViews[param1] != null)
         {
            _loc2_ = this._cachedViews[param1];
         }
         else
         {
            if(App.utils)
            {
               _loc2_ = App.utils.classFactory.getComponent(param1,UIComponent);
               App.utils.asserter.assert(_loc2_ is IViewStackContent,"view must implements IViewStackContent");
            }
            _loc2_.visible = false;
            this.addChild(DisplayObject(_loc2_));
            _loc2_.validateNow();
            dispatchEvent(new LoginViewStackEvent(LoginViewStackEvent.NEED_UPDATE,_loc2_,param1));
            if(_loc2_ != null)
            {
               this._cachedViews[param1] = _loc2_;
            }
         }
         return _loc2_;
      }
      
      public function get currentLinkage() : String
      {
         return this._currentLinkage;
      }
      
      public function get currentView() : IUIComponentEx
      {
         return this._currentView;
      }
   }
}
