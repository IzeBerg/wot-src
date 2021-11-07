package net.wg.gui.rally
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.infrastructure.base.meta.IAbstractRallyViewMeta;
   import net.wg.infrastructure.base.meta.IAbstractRallyWindowMeta;
   import net.wg.infrastructure.base.meta.impl.AbstractRallyWindowMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.controls.Button;
   
   public class AbstractRallyWindow extends AbstractRallyWindowMeta implements IAbstractRallyWindowMeta
   {
       
      
      public var stack:ViewStack;
      
      protected var currentView:IAbstractRallyViewMeta;
      
      public function AbstractRallyWindow()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this.stack)
         {
            this.stack.dispose();
            this.stack = null;
         }
         this.currentView = null;
         super.onDispose();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.currentView.removeEventListener(RallyViewsEvent.LOAD_VIEW_REQUEST,this.onCurrentViewLoadViewRequestHandler);
         super.onBeforeDispose();
      }
      
      public function as_enableWndCloseBtn(param1:Boolean) : void
      {
         enabledCloseBtn = param1;
         Button(window.getCloseBtn()).enabled = param1;
      }
      
      public function as_loadView(param1:String, param2:String) : void
      {
         if(this.currentView)
         {
            this.currentView.removeEventListener(RallyViewsEvent.LOAD_VIEW_REQUEST,this.onCurrentViewLoadViewRequestHandler);
            if(!this.stack.cache)
            {
               this.unregisterCurrentView();
            }
         }
         var _loc3_:IViewStackContent = this.stack.show(param1,param1);
         this.registerCurrentView(_loc3_,param2);
         App.toolTipMgr.hide();
      }
      
      protected function registerCurrentView(param1:IViewStackContent, param2:String) : void
      {
         this.currentView = param1 as IAbstractRallyViewMeta;
         assertNotNull(this.currentView,"currentView" + Errors.CANT_NULL);
         this.currentView.as_setPyAlias(param2);
         this.currentView.addEventListener(RallyViewsEvent.LOAD_VIEW_REQUEST,this.onCurrentViewLoadViewRequestHandler);
         this.registerComponent(this.currentView);
      }
      
      protected function registerComponent(param1:IAbstractRallyViewMeta) : void
      {
         var _loc2_:IDAAPIModule = param1 as IDAAPIModule;
         assertNotNull(_loc2_,"iDAAPIModule" + Errors.CANT_NULL);
         registerFlashComponentS(_loc2_,param1.as_getPyAlias());
      }
      
      protected function unregisterCurrentView() : void
      {
         setFocus(this);
         unregisterComponent(this.currentView.as_getPyAlias());
      }
      
      protected function onViewLoadRequest(param1:*) : void
      {
      }
      
      private function onCurrentViewLoadViewRequestHandler(param1:RallyViewsEvent) : void
      {
         this.onViewLoadRequest(param1.data);
      }
   }
}
