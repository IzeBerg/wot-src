package net.wg.infrastructure.managers.impl
{
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
   import net.wg.data.daapi.ContextMenuOptionsVO;
   import net.wg.infrastructure.base.meta.impl.ContextMenuManagerMeta;
   import net.wg.infrastructure.interfaces.IContextItem;
   import net.wg.infrastructure.interfaces.IContextMenu;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IContextMenuManager;
   import net.wg.utils.IClassFactory;
   
   public class ContextMenuManager extends ContextMenuManagerMeta implements IContextMenuManager
   {
       
      
      private var _currentMenu:IContextMenu = null;
      
      public function ContextMenuManager()
      {
         super();
      }
      
      override protected function setOptions(param1:ContextMenuOptionsVO) : void
      {
         var _loc2_:DisplayObject = null;
         if(param1.options.length)
         {
            assertNotNull(this._currentMenu,"Current context menu" + Errors.CANT_NULL);
            this._currentMenu.build(param1.options,this._currentMenu.clickPoint);
            _loc2_ = DisplayObject(this._currentMenu);
            _loc2_.visible = true;
         }
         else
         {
            this.hide();
         }
      }
      
      public function as_hide() : void
      {
         this.hide();
      }
      
      public function as_show(param1:String, param2:Object) : void
      {
         this.show(param1,null,param2);
      }
      
      public function dispose() : void
      {
         this.hide();
      }
      
      public function hide() : void
      {
         var _loc1_:DisplayObject = null;
         if(this._currentMenu != null)
         {
            this.callLogEvent(this._currentMenu,EVENT_LOG_CONSTANTS.EVENT_TYPE_CONTEXT_MENU_HIDE);
            _loc1_ = DisplayObject(this._currentMenu);
            if(_loc1_.stage && _loc1_.stage.hasEventListener(Event.RESIZE))
            {
               _loc1_.stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
            }
            if(this._currentMenu is IDisposable)
            {
               IDisposable(this._currentMenu).dispose();
            }
            App.utils.popupMgr.popupCanvas.removeChild(_loc1_);
            this._currentMenu = null;
         }
         if(!disposed)
         {
            onHideS();
         }
      }
      
      public function isShown() : Boolean
      {
         return this._currentMenu != null;
      }
      
      public function show(param1:String, param2:DisplayObject = null, param3:Object = null) : void
      {
         this.hide();
         this._currentMenu = this.constructMenu(null,param2);
         this.callLogEvent(this._currentMenu,EVENT_LOG_CONSTANTS.EVENT_TYPE_CONTEXT_MENU_SHOW);
         requestOptionsS(param1,param3);
      }
      
      protected function constructMenu(param1:Vector.<IContextItem>, param2:DisplayObject) : IContextMenu
      {
         var _loc6_:Point = null;
         var _loc7_:Stage = null;
         var _loc3_:IClassFactory = App.utils.classFactory;
         var _loc4_:IContextMenu = _loc3_.getComponent(Linkages.CONTEXT_MENU,IContextMenu);
         var _loc5_:DisplayObject = DisplayObject(_loc4_);
         _loc5_.visible = false;
         if(param2)
         {
            _loc6_ = param2.localToGlobal(new Point(param2.mouseX,param2.mouseY));
         }
         else
         {
            _loc7_ = App.stage;
            _loc6_ = new Point(_loc7_.mouseX * _loc7_.scaleX,_loc7_.mouseY * _loc7_.scaleX);
         }
         _loc6_.x = _loc6_.x / App.appScale >> 0;
         _loc6_.y = _loc6_.y / App.appScale >> 0;
         App.utils.popupMgr.show(_loc5_,_loc6_.x,_loc6_.y);
         _loc4_.build(param1,_loc6_);
         _loc4_.onItemSelectCallback = this.onItemSelect;
         _loc4_.onReleaseOutsideCallback = this.onReleaseOutside;
         _loc5_.stage.addEventListener(Event.RESIZE,this.onStageResizeHandler);
         return _loc4_;
      }
      
      private function onItemSelect(param1:String) : void
      {
         onOptionSelectS(param1);
         this.hide();
      }
      
      private function onReleaseOutside() : void
      {
         this.hide();
      }
      
      private function callLogEvent(param1:IContextMenu, param2:String) : void
      {
         var _loc3_:DisplayObject = param1 as DisplayObject;
         App.utils.asserter.assertNotNull(_loc3_,Errors.CANT_NULL);
         App.eventLogManager.logUIEventContextMenu(_loc3_,param2,0);
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         this.hide();
      }
   }
}
