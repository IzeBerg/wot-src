package net.wg.infrastructure.managers.utils.impl
{
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.advanced.HelpLayoutControl;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.utils.IAssertable;
   import net.wg.utils.IUtils;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import net.wg.utils.helpLayout.IHelpLayout;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   
   public class HelpLayoutManager implements IHelpLayout
   {
       
      
      private var _modalBackground:DisplayObject;
      
      private var _components:Vector.<IHelpLayoutComponent>;
      
      private var _controlsByComponentsMap:Dictionary;
      
      private var _isShown:Boolean;
      
      public function HelpLayoutManager()
      {
         super();
         this._components = new Vector.<IHelpLayoutComponent>(0);
         this._controlsByComponentsMap = new Dictionary();
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         this.removeBackground();
         this.removeControls(true);
         this._components.length = 0;
         this._components = null;
         for(_loc1_ in this._controlsByComponentsMap)
         {
            delete this._controlsByComponentsMap[_loc1_];
         }
         this._controlsByComponentsMap = null;
      }
      
      public function hide() : void
      {
         if(this._isShown)
         {
            this._isShown = false;
            this.removeBackground();
            this.removeControls(false);
         }
      }
      
      public function isShown() : Boolean
      {
         return this._isShown;
      }
      
      public function registerComponent(param1:IHelpLayoutComponent) : void
      {
         if(this._components.indexOf(param1) == -1)
         {
            this._components.push(param1);
            param1.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onComponentDisposeHandler);
         }
      }
      
      public function show() : void
      {
         if(!this._isShown)
         {
            this._isShown = true;
            this.createBackground();
            this.createControls();
         }
      }
      
      public function unregisterComponent(param1:IHelpLayoutComponent) : void
      {
         var _loc3_:Object = null;
         var _loc4_:HelpLayoutControl = null;
         param1.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onComponentDisposeHandler);
         var _loc2_:Number = this._components.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._components.splice(_loc2_,1);
            _loc3_ = this._controlsByComponentsMap[param1];
            for each(_loc4_ in _loc3_)
            {
               this.removeControl(_loc4_,true);
            }
            delete this._controlsByComponentsMap[param1];
         }
      }
      
      private function removeControls(param1:Boolean) : void
      {
         var _loc2_:* = null;
         var _loc3_:HelpLayoutControl = null;
         for(_loc2_ in this._controlsByComponentsMap)
         {
            for each(_loc3_ in this._controlsByComponentsMap[_loc2_])
            {
               this.removeControl(_loc3_,param1);
            }
            if(param1)
            {
               delete this._controlsByComponentsMap[_loc2_];
            }
         }
      }
      
      private function removeControl(param1:HelpLayoutControl, param2:Boolean) : void
      {
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         if(param2)
         {
            param1.dispose();
         }
      }
      
      private function createBackground() : void
      {
         this._modalBackground = App.utils.popupMgr.create(Linkages.POPUP_MODAL);
         var _loc1_:Stage = App.instance.stage;
         if(this._modalBackground != null)
         {
            this._modalBackground.alpha = 0.5;
            this._modalBackground.width = _loc1_.width;
            this._modalBackground.height = _loc1_.height;
         }
      }
      
      private function removeBackground() : void
      {
         if(this._modalBackground != null)
         {
            if(this._modalBackground.parent)
            {
               App.utils.popupMgr.remove(this._modalBackground);
            }
            this._modalBackground = null;
         }
      }
      
      private function createControls() : void
      {
         var _loc4_:IHelpLayoutComponent = null;
         var _loc5_:Vector.<HelpLayoutVO> = null;
         var _loc6_:HelpLayoutVO = null;
         var _loc7_:HelpLayoutControl = null;
         var _loc1_:IUtils = App.utils;
         var _loc2_:IAssertable = _loc1_.asserter;
         var _loc3_:DisplayObject = null;
         for each(_loc4_ in this._components)
         {
            _loc3_ = _loc4_ as DisplayObject;
            if(!(_loc3_ && !_loc3_.visible))
            {
               _loc5_ = _loc4_.getLayoutProperties();
               for each(_loc6_ in _loc5_)
               {
                  _loc2_.assertNotNull(_loc6_.message,"HelpLayoutVO#message" + Errors.CANT_NULL);
                  _loc2_.assert(_loc6_.message.length > 0,"text in HelpLayoutVO#message can`t empty!");
                  if(this._controlsByComponentsMap[_loc4_] == undefined)
                  {
                     this._controlsByComponentsMap[_loc4_] = {};
                  }
                  _loc7_ = this._controlsByComponentsMap[_loc4_][_loc6_.id] as HelpLayoutControl;
                  if(_loc7_)
                  {
                     _loc1_.popupMgr.show(_loc7_,_loc6_.x,_loc6_.y,_loc6_.scope);
                  }
                  else
                  {
                     _loc7_ = _loc1_.popupMgr.create(Linkages.HELP_LAYOUT_CONTROL_LINKAGE,_loc6_) as HelpLayoutControl;
                     App.utils.asserter.assertNotNull(_loc7_,"control" + Errors.CANT_NULL);
                     this._controlsByComponentsMap[_loc4_][_loc6_.id] = _loc7_;
                  }
                  _loc7_.setData(_loc6_);
                  _loc6_.dispose();
               }
               if(_loc5_)
               {
                  _loc5_.length = 0;
               }
            }
         }
      }
      
      private function onComponentDisposeHandler(param1:LifeCycleEvent) : void
      {
         this.unregisterComponent(param1.currentTarget as IHelpLayoutComponent);
      }
   }
}
